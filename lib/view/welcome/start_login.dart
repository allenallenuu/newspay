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
import 'package:qiangdan_app/view/welcome/get_phone_code.dart';
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
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Tools.imagePath('login_bg_black')),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  _showTopView(),
                  Container(
                      margin: EdgeInsets.only(top: 50, left: 15, right: 15),
                      padding: EdgeInsets.only(
                          bottom: 40, top: 10, left: 20, right: 20),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _getPhoneInput(),
                            SizedBox(height: 30),
                            _getPasswordInput(),
                            _forgetPassword(),
                            SizedBox(height: 50),
                            _getLogin(),
                          ])),
                ],
              ))),
        ));
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
            "assets/omni-logo.png",
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
        ),
      ],
    );
  }

  /// Get 手机号
  Widget _getPhoneInput() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(84, 149, 230, 1), width: 1)),
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Container(
                child: new Center(
              child: new Image.asset(
                Tools.imagePath('login_account_select'),
                width: 24.0,
                height: 24.0,
              ),
            )),
            new Expanded(
                child: new Container(
                    height: 50.0,
                    padding: new EdgeInsets.only(left: 4.0),
                    child: new Center(
                        child: new Container(
                      height: 50.0,
                      child: new TextField(
                        controller: userphoneCtrl,
                        keyboardType: TextInputType.phone,
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

  ///验证码
  Widget _getPasswordInput() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(84, 149, 230, 1), width: 1)),
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Container(
                child: new Center(
              child: new Image.asset(
                Tools.imagePath('login_password_select'),
                width: 24.0,
                height: 24.0,
              ),
            )),
            new Expanded(
                child: new Container(
                    height: 50.0,
                    padding: new EdgeInsets.only(left: 4.0),
                    child: new Center(
                        child: new Container(
                      height: 50.0,
                      child: new TextField(
                        controller: passwdCtrl,
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

  ///忘记密码
  Widget _forgetPassword() {
    return Container(
      height: 30,
      padding: EdgeInsets.only(top: 5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(GetCodePassword.tag);
            },
            child: Text(
              WalletLocalizations.of(context).startPageForgetPassword,
              style: TextStyle(fontSize: 14, color: Color(0xFFC0C0C0)),
            ),
          )
        ],
      ),
    );
  }

  ///登录
  Widget _getLogin() {
    return new Card(
      color: AppCustomColor.tabbarBackgroudColor,
      elevation: 11.0,
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
      'code': passwdCtrl.text,
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });

    response.then((data) {
      if (NetConfig.checkData(data)) {
        GlobalInfo.userInfo.loginToken = data['token'];
        GlobalInfo.userInfo.userId = data['userId'];
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
        GlobalInfo.userInfo.isPwd = data['isPwd'];
        GlobalInfo.userInfo.isPayPwd = data['isPayPwd'];
        GlobalInfo.userInfo.isReal = data['isReal'];

        GlobalInfo.userInfo.nickname = data['nickname'];
        GlobalInfo.userInfo.virtualCoinAmount = data['virtualCoinAmount'];
        GlobalInfo.userInfo.faceUrl = data['faceUrl'];
        GlobalInfo.userInfo.level = data['level'];
        GlobalInfo.userInfo.ifBind = data['ifBind'];
        GlobalInfo.userInfo.inviteCode = data['inviteCode'];

        if (data['webUrl'] != null) {
          GlobalInfo.userInfo.webShareAddress = data['webUrl'];
        }

        if (data['downloadUrl'] != null) {
          GlobalInfo.userInfo.appShareAddress = data['downloadUrl'];
        }

        if (data['uid'] != null) {
          GlobalInfo.userInfo.uid = data['uid'].toString();
        }

        if (data["fpUserInfo"] != null &&
            data["fpUserInfo"]["username"] != null) {
          FPUserInfo fpUserInfo = FPUserInfo();
          fpUserInfo.hyperUsername = data["fpUserInfo"]["username"];
          List list = data["fpUserInfo"]["addresses"];
          fpUserInfo.addresses = [];
          for (int i = 0; i < list.length; i++) {
            fpUserInfo.addresses.add(list[i]);
          }
          GlobalInfo.userInfo.fpUserInfo = fpUserInfo;
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
