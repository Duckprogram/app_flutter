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
  String _status = 'no-action';
  String _username, _password;
  bool _isKakaoTalkInstalled = false;

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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginDone()),
      );
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
              // Form(
              //   key: formKey,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       ListTile(
              //         title: TextFormField(
              //           decoration: InputDecoration(labelText: 'Username'),
              //           validator: (val) =>
              //               val.length < 1 ? 'Username Required' : null,
              //           onSaved: (val) => _username = val,
              //           obscureText: false,
              //           keyboardType: TextInputType.text,
              //           controller: _controllerUsername,
              //           autocorrect: false,
              //         ),
              //       ),
              //       ListTile(
              //         title: TextFormField(
              //           decoration: InputDecoration(labelText: 'Password'),
              //           validator: (val) =>
              //               val.length < 1 ? 'Password Required' : null,
              //           onSaved: (val) => _password = val,
              //           obscureText: true,
              //           controller: _controllerPassword,
              //           keyboardType: TextInputType.text,
              //           autocorrect: false,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
              ListTile(
                title: RaisedButton(
                  child: Text(
                    'Login',
                    textScaleFactor: textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final snackbar = SnackBar(
                        duration: Duration(seconds: 30),
                        content: Row(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Text("  Logging In...")
                          ],
                        ),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackbar);

                      setState(() => this._status = 'loading');
                      _auth
                          .login(
                        username: _username.toString().toLowerCase().trim(),
                        password: _password.toString().trim(),
                      )
                          .then((result) {
                        if (result) {
                        } else {
                          setState(() => this._status = 'rejected');
                          showAlertPopup(context, 'Info', _auth.errorMessage);
                        }
                        if (!_auth.isBioSetup) {
                          setState(() {
                            print('Bio No Longer Setup');
                          });
                        }
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                      });
                    }
                  },
                ),
                // trailing: !_auth.isBioSetup
                //     ? null
                //     : NativeButton(
                //         child: Icon(
                //           Icons.fingerprint,
                //           color: Colors.white,
                //         ),
                //         color: Colors.redAccent[400],
                //         onPressed: _auth.isBioSetup
                //             ? loginWithBio
                //             : () {
                //                 globals.Utility.showAlertPopup(context, 'Info',
                //                     "Please Enable in Settings after you Login");
                //               },
                //       ),
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
              )
            ].reversed.toList(),
          ),
        ),
      ),
    );
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
