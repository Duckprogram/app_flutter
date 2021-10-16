import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../api/auth.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';

// import 'forgot.dart';

class KakoaLoginPage extends StatefulWidget {
  @override
  KakoaLoginPageState createState() => KakoaLoginPageState();
}

class KakoaLoginPageState extends State<KakoaLoginPage> {
  bool _isKakaoTalkInstalled = false;
  static final storage = FlutterSecureStorage();
  User user;

  String _status = 'no-action';

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    _initKakaoTalkInstalled();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    print(_status);
    print('Kakao Login Page');
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    var code = await storage.read(key: "authCode");
    print(code);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (code != null) {
      await _issueKakaoAccessToken(code);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = 'aca6149f183ca8e52113ddcb5cafe2eb';
    KakaoContext.javascriptClientId = '1dd0e6325c1be9c1451814daa0839a87';

    isKakaoTalkInstalled();

    final _auth = Provider.of<AuthModel>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/login/login.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: SafeArea(
          child: ListView(
            reverse: true,
            physics: AlwaysScrollableScrollPhysics(),
            key: PageStorageKey("Divider 1"),
            padding: EdgeInsets.all(16),
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              ButtonBar(
                // 가운데로
                alignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      child: Text("카카오톡 으로 로그인 하기"),
                      onPressed: _loginWithKakaoTalk),
                ],
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao Install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  //먼저 code를 활용하여 백앤드로 보냄 이상이 없는 경우 jwt로 보내기
  _issueKakaoAccessToken(String authCode) async {
    try {
      AccessTokenResponse token =
          await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      print("AccessToken : " + token.accessToken);
      try {
        User user = await UserApi.instance.me();
        print("user : " + user.toString());
        final snackBar =
            SnackBar(content: Text(user.properties['nickname'] + "님 반갑습니다."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (!(await _registerUserInfoWithKakao(authCode))) {
          final snackBar = SnackBar(content: Text("회원가입 실패"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
        await _issueJWTandLogin(authCode);
      } on KakaoAuthException catch (e) {
      } catch (e) {}
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  Future<bool> _registerUserInfoWithKakao(String authCode) async {
    var signUpBody = {'authCode': authCode};
    try {
      var response = await api_userRegisterCheck(
          header: null, path: 'auth/signup/', body: signUpBody);
      if (response['code'] == 0 ||
          response['code'] == -9999) //정상 가입 또는 이미 가입한 회원
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //로그인 혹은 회원가입이 잘 되어 있다면 jwt 토큰 발행 향후 모든 로그인은 해당 토큰으로 해결
  _issueJWTandLogin(String authCode) async {
    try {
      print('Jwt Login');
      var fcm_token = await FirebaseMessaging.instance.getToken();
      print(fcm_token);
      var signUpBody = {'fcmToken': fcm_token, 'authCode': authCode};

      var response = await api_userRegisterCheck(
          header: null, path: 'auth/signin/', body: signUpBody);

      print("access_token : " + response['data']['access_token']);
      await storage.write(
          key: "access_token", value: response['data']['access_token']);
      await storage.write(
          key: "refresh_token", value: response['data']['refresh_token']);
      await storage.write(key: "authCode", value: authCode);
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  _loginWithKakaoTalk() async {
    if (_isKakaoTalkInstalled) {
      try {
        var code = await AuthCodeClient.instance.requestWithTalk();
        print(code);
        await _issueKakaoAccessToken(code);
      } catch (e) {
        print(e);
      }
    } else {
      //카톡이 깔려있지 않으면 웹으로 진행
      print("로그인 이상여부 확인 ");
      final snackBar = SnackBar(content: Text("카카오톡이 설치되어있지 않습니다."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      try {
        //Not Working
        var code = await AuthCodeClient.instance.request();

        print(code);
        await _issueKakaoAccessToken(code);
      } catch (e) {
        print(e);
      }
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }
}

class LoginDone extends StatelessWidget {
  Future<bool> _getUser() async {
    try {
      User user = await UserApi.instance.me();
      print(user.toString());
    } on KakaoAuthException catch (e) {
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    _getUser();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Login Success!'),
        ),
      ),
    );
  }
}
