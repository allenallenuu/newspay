import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Start page.
/// [author] tt
/// [time] 2019-3-5

import 'package:flutter/material.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/model/user_info.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/tools/key_config.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/main_view/main_page.dart';
import 'package:qiangdan_app/view/welcome/forget_password.dart';
import 'package:qiangdan_app/view/welcome/register_account.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';


class StartLoginPage extends StatefulWidget {
  static String tag = "StartPage";
  bool needBack = true;

  StartLoginPage({Key key, this.needBack}) : super(key: key);

  @override
  _StartLoginPageState createState() => _StartLoginPageState();
}

class _StartLoginPageState extends State<StartLoginPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String log;
  bool _hasAccountFocus = false;
  bool _hasPasswordFocus = false;

  FocusNode _nodeAccount = FocusNode();
  FocusNode _nodePassword = FocusNode();

  //手机号控制器
  TextEditingController userphoneCtrl = TextEditingController(text: "");

  //密码控制器
  TextEditingController passwdCtrl = TextEditingController();

  var reg = new RegExp('^1[0-9]{10}');

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      log = "";
    });
  }

  @override
  void initState() {
    _nodeAccount.addListener(() {
      if (_nodeAccount.hasFocus) {
        // get focus
        _hasAccountFocus = true;
        _hasPasswordFocus = false;
      }
      setState(() {});
    });
    _nodePassword.addListener(() {
      if (_nodePassword.hasFocus) {
        // get focus
        _hasPasswordFocus = true;
        _hasAccountFocus = false;
      }
      setState(() {});
    });
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              _showTopView(),
              Container(
                  margin: EdgeInsets.only(top: 50, left: 15, right: 15),
                  padding:
                      EdgeInsets.only(bottom: 40, top: 10, left: 20, right: 20),
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
//                        borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _getPhoneInput(),
                        SizedBox(height: 25),
                        _getPasswordInput(),
                        SizedBox(height: 40),
                        _getLogin(),
                        SizedBox(height: 24),
                        _forgetPassword(),
                      ])),
            ],
          ))),
    );
  }

  @override
  void dispose() {
    userphoneCtrl.dispose();
    passwdCtrl.dispose();
    super.dispose();
  }

  /// topView
  Widget _showTopView() {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 70),
          height: 120,
          child: Image.asset(
            Tools.imagePath('login_account_unselect'),
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
        ),
      ],
    );
  }

  Widget _getPhoneInput() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
        border: new Border.all(
            width: 1,
            color: _hasAccountFocus
                ? Color.fromRGBO(243, 69, 69, 1)
                : Color.fromRGBO(222, 222, 222, 1)),
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Container(
                padding: new EdgeInsets.only(left: 19.0),
                child: new Center(
                  child: new Image.asset(
                    Tools.imagePath(_hasAccountFocus
                        ? 'login_account_select'
                        : 'login_account_unselect'),
                    width: 19.0,
                    height: 24.0,
                    gaplessPlayback: true,
                  ),
                )),
            new Expanded(
                child: new Container(
                    height: 50.0,
                    padding: new EdgeInsets.only(left: 10.0),
                    child: new Center(
                        child: new Container(
                      height: 50.0,
                      child: new TextField(
                        controller: userphoneCtrl,
                        focusNode: _nodeAccount,
                        maxLines: 1,
                        maxLength: 11,
                        maxLengthEnforced: true,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: new InputDecoration(
                            hintText: WalletLocalizations.of(context)
                                .startPagePhoneInput,
                            counterText: '',
                            border: InputBorder.none,
                            hintStyle: new TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    )))),
          ],
        ),
      ),
    );
  }

  ///密码
  Widget _getPasswordInput() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
        border: new Border.all(
            width: 1,
            color: _hasPasswordFocus
                ? Color.fromRGBO(243, 69, 69, 1)
                : Color.fromRGBO(222, 222, 222, 1)),
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Container(
                padding: new EdgeInsets.only(left: 19.0),
                child: new Center(
                  child: new Image.asset(
                    Tools.imagePath(_hasPasswordFocus
                        ? 'login_password_select'
                        : 'login_password_unselect'),
                    width: 19.0,
                    height: 24.0,
                    gaplessPlayback: true,
                  ),
                )),
            new Expanded(
                child: new Container(
                    height: 50.0,
                    padding: new EdgeInsets.only(left: 10.0),
                    child: new Center(
                        child: new Container(
                      height: 50.0,
                      child: new TextField(
                        controller: passwdCtrl,
                        focusNode: _nodePassword,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        maxLength: 11,
                        maxLengthEnforced: true,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: new InputDecoration(
                            hintText: WalletLocalizations.of(context)
                                .startPagePasswordInput,
                            counterText: '',
                            border: InputBorder.none,
                            hintStyle: new TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    )))),
          ],
        ),
      ),
    );
  }

  ///忘记密码和注册
  Widget _forgetPassword() {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ForgetPassword.tag);
            },
            child: Text(
              WalletLocalizations.of(context).startPageForgetPassword,
              style: TextStyle(fontSize: 14, color: Color(0xFFC0C0C0)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RegisterPage.tag);
            },
            child: Text(
              WalletLocalizations.of(context).startPageRegistedUser,
              style: TextStyle(
                  fontSize: 14, color: AppCustomColor.tabbarBackgroudColor),
            ),
          )
        ],
      ),
    );
  }

  ///登录
  Widget _getLogin() {
    return new Card(
      color: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: AppCustomColor.tabbarBackgroudColor)),
      elevation: 1.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CustomRaiseButton(
          context: context,
          hasRow: false,
          title: WalletLocalizations.of(context).startPagePhoneLogin,
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: () {
            _loginActionByPwd(userphoneCtrl.text, passwdCtrl.text);
          },
        ),
      ),
    );
  }

  void _loginActionByPwd(String phone, String code) {
    if (phone.trim() == '') {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePhoneError1);
      return null;
    } else if (!reg.hasMatch(phone.trim())) {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePhoneError2);
      return null;
    } else if (code == '') {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePwdError);
      return null;
    }

    Tools.loadingAnimation(context);

    Future response = NetConfig.post(context, NetConfig.loginByPwd, {
      'cellphone': userphoneCtrl.text,
      'password': passwdCtrl.text,
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });

    response.then((data) {
      if (NetConfig.checkData(data)) {
//        print('loginByPwd = $data');
        GlobalInfo.userInfo.loginToken = data['token'];
        GlobalInfo.userInfo.userId = data['uid'].toString();
        Tools.saveStringKeyValue(
            KeyConfig.user_login_token, GlobalInfo.userInfo.loginToken);
        Tools.saveStringKeyValue(
            KeyConfig.user_login_userId, GlobalInfo.userInfo.userId);

        _getUserInfo();
      } else {
        Navigator.pop(context);
      }
    });
  }

  void _getUserInfo() {
    Future data = NetConfig.post(context, NetConfig.getUserInfo, {},
        errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });

    data.then((data) {
      if (NetConfig.checkData(data)) {
        print('getUserInfo = $data');

        if (data['webUrl'] != null) {
          GlobalInfo.userInfo.webShareAddress = data['webUrl'];
        }

        if (data['appDownUrl '] != null) {
          GlobalInfo.userInfo.appDownloadAddress = data['appDownUrl '];
        }

        if (data['uid'] != null) {
          GlobalInfo.userInfo.uid = data['uid'].toString();
        }
        if (data['faceUrl'] != null) {
          GlobalInfo.userInfo.faceUrl = data['faceUrl'].toString();
        }
        if (data['nickname'] != null) {
          GlobalInfo.userInfo.nickname = data['nickname'].toString();
        }
        if (data['userId'] != null) {
          GlobalInfo.userInfo.userId = data['userid'].toString();
        }
        if (data['cellphone'] != null) {
          GlobalInfo.userInfo.cellphone = data['cellphone'].toString();
        }
        Navigator.of(context).pushAndRemoveUntil(
          // remove unlock page
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => route == null,
        );
      } else {
        Navigator.pop(context);
      }
    });
  }
}
