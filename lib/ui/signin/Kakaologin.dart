import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../utils/http.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';

// import 'forgot.dart';

class KakoaLoginPage extends StatefulWidget {
  KakoaLoginPage({this.username});

  final String username;

  @override
  KakoaLoginPageState createState() => KakoaLoginPageState();
}

class KakoaLoginPageState extends State<KakoaLoginPage> {
  bool _isKakaoTalkInstalled = false;
  static final storage = FlutterSecureStorage();
  User user;
  String userKakaoId = '';

  String _status = 'no-action';
  String _username, _password;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerUsername, _controllerPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController(text: widget?.username ?? "");
    _controllerPassword = TextEditingController();
    _loadUsername();
    super.initState();
    _initKakaoTalkInstalled();
    print(_status);
    print('Kakao Login Page');
  }

  void _loadUsername() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("saved_username") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        _controllerUsername.text = _username ?? "";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = '4jD9QBO4Qs3NrW9KO0bF9rINTJiGMTU4';

    isKakaoTalkInstalled();

    final _auth = Provider.of<AuthModel>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/login/backgroud.gif'))),
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
              CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 36,
                  child: Image.asset('assets/login/logo.png')),
              SizedBox(
                height: 16,
              ),
              ButtonBar(
                // 가운데로
                alignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      child: Text("Login with Talk"),
                      onPressed: _loginWithKakaoTalk),
                ],
              ),
              ListTile(
                title: Text(
                  'Remember Me',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Switch.adaptive(
                  onChanged: _auth.handleRememberMe,
                  value: _auth.rememberMe,
                ),
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

  _issueKakaoAccessToken(String authCode) async {
    try {
      AccessTokenResponse token =
          await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      //print("AccessToken : " + token.accessToken);
      try {
        User user = await UserApi.instance.me();

        final snackBar =
            SnackBar(content: Text(user.properties['nickname'] + "님 반갑습니다."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (!(await _registerUserInfoWithKakao(token.accessToken))) {
          final snackBar = SnackBar(content: Text("회원가입 실패"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
        await _issueJWTandLogin(token.accessToken);
      } on KakaoAuthException catch (e) {
      } catch (e) {}
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  Future<bool> _registerUserInfoWithKakao(String accessToken) async {
    var signUpBody = {
      'userIdentifier': 'compatibleForApple'
    }; //애플로그인과 호환성을 위해 Body 담음
    try {
      var response = await http_post(
          header: null,
          path: 'v1/signup/kakao?accessToken=' + accessToken,
          body: signUpBody);
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

  _issueJWTandLogin(String accessToken) async {
    // var url =
    //     "http://ec2-13-124-23-131.ap-northeast-2.compute.amazonaws.com:8080/v1/signin/kakao?accessToken=" +
    //         accessToken;
    try {
      // var response = await http.post(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      // var JsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));

      print('toooken');
      var fcm_token = await FirebaseMessaging.instance.getToken();
      print(fcm_token);
      var signUpBody = {'fcmToken': fcm_token};

      var response = await http_post(
          header: null,
          path: 'v1/signin/kakao?accessToken=' + accessToken,
          body: signUpBody);

      print("access_token : " + response['data']['access_token']);
      await storage.write(
          key: "access_token", value: response['data']['access_token']);
      await storage.write(
          key: "refresh_token", value: response['data']['refresh_token']);
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
        await _issueKakaoAccessToken(code);
      } catch (e) {
        print(e);
      }
    } else {
      //카톡이 깔려있지 않으면 웹으로 진행
      final snackBar = SnackBar(content: Text("카카오톡이 설치되어있지 않습니다."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      try {
        //Not Working
        var code = await AuthCodeClient.instance.request();
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
