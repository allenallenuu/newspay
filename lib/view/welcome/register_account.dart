import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Start page.
/// [author] tt
/// [time] 2019-3-5

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/global_model.dart';
import 'package:wpay_app/model/user_info.dart';
import 'package:wpay_app/tools/CustomTabbar/CustomTabIndicator.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/tools/key_config.dart';
import 'package:wpay_app/tools/net_config.dart';
import 'package:wpay_app/view/main_view/main_page.dart';
import 'package:wpay_app/view/welcome/forget_password.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';

import 'forget_account.dart';

class RegisterPage extends StatefulWidget {
  static String tag = "RegisterPage";
  bool needBack = true;

  RegisterPage({Key key, this.needBack}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasInviteCodeFocus = false;
  bool _hasPhoneFocus = false;
  bool _hasVerificationCodeFocus = false;
  bool _hasPasswdFocus = false;

  FocusNode _nodeInviteCode = FocusNode();
  FocusNode _nodePhone = FocusNode();
  FocusNode _nodeVerificationCode = FocusNode();
  FocusNode _nodePasswd = FocusNode();

  TextEditingController inviteCodeCtrl = TextEditingController(text: "");
  TextEditingController phoneCtrl = TextEditingController(text: "");
  TextEditingController verificationCodeCtrl = TextEditingController();
  TextEditingController passwdCtrl = TextEditingController(text: "");

  bool isSendCodeEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;
  String buttonText = "获取验证码";
  var reg = new RegExp('^1[0-9]{10}');

  //判断是否是分享成功
  bool shareSuccess = false;

  @override
  void initState() {
    shareSuccess = (kIsWeb &&
        (GlobalInfo.userInfo.webShareCode != null &&
            GlobalInfo.userInfo.webShareRatio != null));
    if (shareSuccess) {
      inviteCodeCtrl.text = GlobalInfo.userInfo.webShareCode;
    }

    _nodeInviteCode.addListener(() {
      if (_nodeInviteCode.hasFocus) {
        // get focus
        _hasInviteCodeFocus = true;
        _hasPhoneFocus = false;
        _hasVerificationCodeFocus = false;
        _hasPasswdFocus = false;
      }
      setState(() {});
    });
    _nodePhone.addListener(() {
      if (_nodePhone.hasFocus) {
        // get focus
        _hasInviteCodeFocus = false;
        _hasPhoneFocus = true;
        _hasVerificationCodeFocus = false;
        _hasPasswdFocus = false;
      }
      setState(() {});
    });
    _nodeVerificationCode.addListener(() {
      if (_nodeVerificationCode.hasFocus) {
        // get focus
        _hasInviteCodeFocus = false;
        _hasPhoneFocus = false;
        _hasVerificationCodeFocus = true;
        _hasPasswdFocus = false;
      }
      setState(() {});
    });
    _nodePasswd.addListener(() {
      if (_nodePasswd.hasFocus) {
        // get focus
        _hasInviteCodeFocus = false;
        _hasPhoneFocus = false;
        _hasVerificationCodeFocus = false;
        _hasPasswdFocus = true;
      }
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inviteCodeCtrl.dispose();
    phoneCtrl.dispose();
    passwdCtrl.dispose();
    verificationCodeCtrl.dispose();
    if (timer != null) {
      timer.cancel();
      //销毁计时器
      timer = null;
    }
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isSendCodeEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText =
              WalletLocalizations.of(context).startPageSendCode; //重置按钮文本
        } else {
          buttonText = WalletLocalizations.of(context).startPageSendCodeRetry +
              '($count)'; //更新文本内容
        }
      });
    });
  }

  Function _sendCode(String phone) {
    if (phoneCtrl.text.toString().trim() == '') {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePhoneError1);
      return null;
    } else if (!reg.hasMatch(phoneCtrl.text.toString().trim())) {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePhoneError2);
      return null;
    }

    if (isSendCodeEnable) {
      //当按钮可点击时
      isSendCodeEnable = false; //按钮状态标记

      Future response = NetConfig.post(context, NetConfig.sendCode, {
        'cellphone': phoneCtrl.text.toString(),
      }, errorCallback: (msg) {
        Tools.showToast(_scaffoldKey, msg);
      });

      response.then((data) {
        print(data);
        if (NetConfig.checkData(data)) {
          _initTimer();
        }
      });
    }
  }

  Widget _getPhoneInput(
      bool enable,
      bool fcousIs,
      String selectImgae,
      String unSelectImage,
      TextEditingController controller,
      FocusNode focusNodes,
      String hitText,
      bool isCode) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
        border: new Border.all(
            width: 1,
            color: fcousIs
                ? Color.fromRGBO(243, 69, 69, 1)
                : Color.fromRGBO(222, 222, 222, 1)),
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Container(
                padding: new EdgeInsets.only(left: 24.0),
                child: new Center(
                  child: new Image.asset(
                    Tools.imagePath(fcousIs ? selectImgae : unSelectImage),
                    gaplessPlayback: true,
                    width: 19.0,
                    height: 24.0,
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
                        enabled: enable,
                        controller: controller,
                        focusNode: focusNodes,
                        maxLines: 1,
                        maxLength: 11,
                        maxLengthEnforced: true,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: new InputDecoration(
                            hintText: hitText,
                            counterText: '',
                            border: InputBorder.none,
                            hintStyle: new TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    )))),
            isCode
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Color.fromRGBO(243, 69, 69, 1),
                    child: Container(
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      var phoneNums = phoneCtrl.text;
                      if (phoneNums.length == 0 || phoneNums == null) {
                        Tools.showToast(_scaffoldKey, '请输入正确的手机号');
                        return;
                      }
                      _sendCode(phoneCtrl.toString());
                    },
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  ///注册
  Widget _getDataInfo() {
    return new Card(
      color: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: Colors.red)),
      elevation: 1.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CustomRaiseButton(
          context: context,
          hasRow: false,
          title: WalletLocalizations.of(context).startPageRegisterAndLogin,
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: () {
            var inviteCodeNums = inviteCodeCtrl.text;
            var phoneNums = phoneCtrl.text;
            var passwdNums = passwdCtrl.text;
            var verificationCodeNums = verificationCodeCtrl.text;

            if (phoneNums.length == 0 || phoneNums == null) {
              Tools.showToast(_scaffoldKey,
                  WalletLocalizations.of(context).startPagePhoneInputs);
              return;
            }
            if (passwdNums.length == 0 || passwdNums == null) {
              Tools.showToast(_scaffoldKey,
                  WalletLocalizations.of(context).startPagePasswordInput);
              return;
            }

            if (verificationCodeNums.length == 0 ||
                verificationCodeNums == null) {
              Tools.showToast(_scaffoldKey,
                  WalletLocalizations.of(context).startPageCodeError);
              return;
            }

            _onSubmit();
//            _loginActionByPwd(inviteCodeCtrl.text, phoneCtrl.text);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).startPageRegister),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                shareSuccess
                    ? _getPhoneInput(
                        !shareSuccess,
                        _hasInviteCodeFocus,
                        'login_inviteCode_select',
                        'login_inviteCode_unselect',
                        inviteCodeCtrl,
                        _nodeInviteCode,
                        WalletLocalizations.of(context).startPageInviteCode,
                        false)
                    : Container(),
                SizedBox(height: 24),
                _getPhoneInput(
                    true,
                    _hasPhoneFocus,
                    'login_phone_select',
                    'login_phone_unselect',
                    phoneCtrl,
                    _nodePhone,
                    WalletLocalizations.of(context).startPagePhoneInputs,
                    false),
                SizedBox(
                  height: 24,
                ),
                _getPhoneInput(
                    true,
                    _hasVerificationCodeFocus,
                    'login_code_select',
                    'login_code_unselect',
                    verificationCodeCtrl,
                    _nodeVerificationCode,
                    WalletLocalizations.of(context).startPageCodeInput,
                    true),
                SizedBox(
                  height: 24,
                ),
                _getPhoneInput(
                    true,
                    _hasPasswdFocus,
                    'login_password_select',
                    'login_password_unselect',
                    passwdCtrl,
                    _nodePasswd,
                    WalletLocalizations.of(context).startPagePwdError,
                    false),
                SizedBox(height: 24),
                _getDataInfo(),
              ],
            ),
          )),
    );
  }

  void _onSubmit() {
    var inviteCodeNums = inviteCodeCtrl.text;
    var phoneNums = phoneCtrl.text;
    var codeNums = verificationCodeCtrl.text;
    var passwdNums = passwdCtrl.text;

    Future result = NetConfig.post(context, NetConfig.registerAccount, {
      'cellphone': phoneNums,
      'code': codeNums,
      'password': passwdNums,
      'invitationCode': shareSuccess ? GlobalInfo.userInfo.webShareCode : '',
      'earningsRatio': shareSuccess ? GlobalInfo.userInfo.webShareRatio : ''
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });
    result.then((data) {
      print('registerAccount = $data');
      if (data != null) {
        GlobalInfo.userInfo.appDownloadAddress = data['appDownUrl'];
        if (kIsWeb) {
          if (GlobalInfo.userInfo.webPlation != null &&
              GlobalInfo.userInfo.webPlation == 'false') {
            _upgradeAppDownload();
          } else {
            Navigator.of(context).pop();
          }
        } else {
          Navigator.of(context).pop();
        }
        print('注册成功');
      }
    });
  }

  void _upgradeAppDownload() async {
    // APK install file download url for Android.
    var url = GlobalInfo.userInfo.appDownloadAddress;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Tools.showToast(_scaffoldKey, 'Could not launch $url');
    }
  }
}
