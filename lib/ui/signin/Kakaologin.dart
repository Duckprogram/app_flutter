import 'package:duckie_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/auth.dart';
import 'package:kakao_flutter_sdk/all.dart';
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

  @override
  initState() {
    super.initState();
    _initKakaoTalkInstalled();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });

    KakaoContext.clientId = 'aca6149f183ca8e52113ddcb5cafe2eb';
    KakaoContext.javascriptClientId = '1dd0e6325c1be9c1451814daa0839a87';
    isKakaoTalkInstalled();
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    var jwttoken = await storage.read(key: "accessToken");
    print("token check");
    // 신규 버전이 나오면서 더 이상 storage를 굳이 안써도 될 거 같다.
    var token = await TokenManager.instance.getToken();
    // user의 정보가 있다면 바로 자동 로그인 method로 넘어감
    // await storage.write(key: "accessToken", value: null);
    if (token.refreshToken != null && jwttoken != null ) {
      print("token access " + token.accessToken.toString());
      print("token refresh " + token.refreshToken.toString());
      print('is it not null?');
      await _issueJWTandLogin(token.accessToken.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "어서오세요 덕님!\n더키에 오신걸 환영해요! ",
                style: h1,
                textAlign: TextAlign.center,
              )),
          Container(
              padding: EdgeInsets.only(bottom: 45),
              child: Text(
                "다른 곳에선 못했던 이야기\n덕친들과 자유롭게 애기하세요!",
                style: body1MediumGray3,
                textAlign: TextAlign.center,
              )),
          Container(
              width: 220,
              padding: EdgeInsets.only(bottom: 85),
              child: Image.asset('assets/login/duckie_character.png')),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xfffae100),
            ),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color(0xfffae100);
                    } else {
                      return Color(0xfffae100);
                    }
                  }),
                  // alignment: 0,
                ),
                child: Text("카카오톡 으로 로그인 하기",
                    textAlign: TextAlign.center, style: body1Bold),
                onPressed: _loginWithKakaoTalk),
          ),
        ],
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
      TokenManager.instance.setToken(token);
      print("AccessToken : " + token.accessToken);
      print("refreshToken : " + token.refreshToken.toString());
      try {
        // listen 은 전체를 rebuild 한다는 뜻으로 set 함수를 사용하기 위해서 단순하게
        // listen 을 false로 하여 진행한다.
        final _auth = Provider.of<AuthModel>(context, listen: false);
        _auth.user = await UserApi.instance.me();
        print("카카오톡 에서 보내준 유저 정보 user : " + _auth.user.toString());
        final snackBar = SnackBar(
            content: Text(_auth.user.properties!['nickname']! + "님 반갑습니다."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // if (!(await _registerUserInfoWithKakao(token.accessToken))) {
        //   print("회원가입 실패");
        //   final snackBar = SnackBar(content: Text("회원가입 실패"));
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   return;
        // }
        await _issueJWTandLogin(token.accessToken);
      } on KakaoAuthException catch (e) {
      } catch (e) {
        print(e);
      }
    } catch (e) {
      await storage.write(key: "accessToken", value: "");
      print("error on issuing access token: $e");
    }
  }

  // Future<bool> _registerUserInfoWithKakao(String accessToken) async {
  //   var signUpBody = {'accessToken': accessToken};
  //   try {
  //     var response = await api_userRegisterCheck(
  //         header: null, path: '/auth/signup', body: signUpBody);
  //     if (response['code'] == 0 ||
  //         response['code'] == -9999) //정상 가입 또는 이미 가입한 회원
  //       return true;
  //     else
  //       return false;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  //로그인 혹은 회원가입이 잘 되어 있다면 jwt 토큰 발행 향후 모든 로그인은 해당 토큰으로 해결
  _issueJWTandLogin(String accessToken) async {
    try {
      print('Jwt Login');
      // var fcm_token = await FirebaseMessaging.instance.getToken();
      // print(fcm_token);
      // var signUpBody = {'fcmToken': fcm_token};
      var signUpBody = {'accessToken': accessToken};
      var response = await api_userRegisterCheck(
          header: null, path: '/auth/signin', body: signUpBody);
      // if (response['code'] == 0 ||
      //     response['code'] == -9999) //정상 가입 또는 이미 가입한 회원
      // 추후 정상적으로 로그인이 완료 되었을 경우 유저 정보를 login 진행시 저장하도록 재구성
      // final _auth = Provider.of<AuthModel>(context, listen: false);
      // _auth.user = await UserApi.instance.me();
      print(response);
      if (response['data']['access_token'] != null) {
        await storage.write(
            key: "accessToken", value: response['data']['access_token']);
        await storage.write(key: "username", value: response['data']['name']);
        await storage.write(key: "picture", value: response['data']['picture']);
        await storage.write(
            key: "refreshToken", value: response['data']['refresh_token']);
        // 이상없이 잘 되었다면 main 화면으로 넘어가기
        Navigator.pushReplacementNamed(context, '/home');
      }
      //   return true;
      // else
      //   return false;
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
      try {
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
