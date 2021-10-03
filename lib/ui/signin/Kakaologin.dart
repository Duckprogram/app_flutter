import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';
import '../../utils/popUp.dart';
import 'newaccount.dart';

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
  User user;
  String userKakaoId='';

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

  void requestUserCheck(User user){
    SvcHeader gHeader=SvcHeader();
    BytesBuilder gRequst = BytesBuilder();
    UsrSvc16111 usrSvc16111 = UsrSvc16111();
    usrSvc16111.makeUsrSvc16111(gb: '2',currency: 'KRW',nation: 'KR',personCheckGb: '1',infoGb: '1', userId: user.kakaoAccount!.email!);
    checkSeq=gGlobalSGA.getRequestSeq();
    gRequst.add(gHeader.setSvcHeader(usrSvc16111.requestData(), usrSvc16111.svcCode, checkSeq));
    gRequst.add(usrSvc16111.requestData());

    globals.gChannel.sink.add(gRequst.toBytes());


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
                    onPressed:
                      _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao),
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

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      print(token);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginDone()),
      // );
      user = await UserApi.instance.me();
      print('인증 완료 : '+user.kakaoAccount!.email.toString());
      userKakaoId=user.kakaoAccount!.email.toString();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginResult()));
      requestUserCheck(user);
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  logOutTalk() async {
    try {
      var code = await UserApi.instance.logout();
      print(code.toString());
    } catch (e) {
      print(e);
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
    } catch (e) {
    }
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
