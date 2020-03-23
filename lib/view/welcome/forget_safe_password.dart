import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/welcome/forget_account.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class ForgetSafePassword extends StatefulWidget {
  var typeSet;

  ForgetSafePassword({Key key, this.typeSet}) : super(key: key);
  static String tag = "ForgetSafePassword";

  @override
  _ForgetSafePasswordState createState() => _ForgetSafePasswordState();
}

class _ForgetSafePasswordState extends State<ForgetSafePassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasUserPhoneFocus = false;
  bool _hasPasswdFocus = false;
  bool _hasNewPasswdFocus = false;
  bool _hasCodeFocus = false;
  FocusNode _nodeUserPhone = FocusNode();
  FocusNode _nodePasswd = FocusNode();
  FocusNode _nodeNewPasswd = FocusNode();
  FocusNode _nodeCode = FocusNode();
  TextEditingController userphoneCtrl = TextEditingController(text: "");
  TextEditingController passwdCtrl = TextEditingController(text: "");
  TextEditingController newPasswdCtrl = TextEditingController(text: "");
  TextEditingController verificationCodeCtrl = TextEditingController();

  bool isSendCodeEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;
  String buttonText = "获取验证码";
  var reg = new RegExp('^1[0-9]{10}');

  @override
  void initState() {
    _nodeUserPhone.addListener(() {
      if (_nodeUserPhone.hasFocus) { // get focus
        _hasUserPhoneFocus = true;
        _hasPasswdFocus = false;
        _hasNewPasswdFocus = false;
        _hasCodeFocus = false;
      }
      setState(() {});
    });
    _nodePasswd.addListener(() {
      if (_nodePasswd.hasFocus) { // get focus
        _hasPasswdFocus = true;
        _hasUserPhoneFocus = false;
        _hasNewPasswdFocus = false;
        _hasCodeFocus = false;

      }
      setState(() {});
    });
    _nodeNewPasswd.addListener(() {
      if (_nodeNewPasswd.hasFocus) { // get focus
        _hasNewPasswdFocus = true;
        _hasUserPhoneFocus = false;
        _hasPasswdFocus = false;
        _hasCodeFocus = false;

      }
      setState(() {});
    });
    _nodeCode.addListener(() {
      if (_nodeCode.hasFocus) { // get focus
        _hasCodeFocus = true;
        _hasUserPhoneFocus = false;
        _hasPasswdFocus = false;
        _hasNewPasswdFocus = false;

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
    userphoneCtrl.dispose();
    passwdCtrl.dispose();
    newPasswdCtrl.dispose();
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
    if (userphoneCtrl.text.toString().trim() == '') {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePhoneError1);
      return null;
    } else if (!reg.hasMatch(userphoneCtrl.text.toString().trim())) {
      Tools.showToast(
          _scaffoldKey, WalletLocalizations.of(context).startPagePhoneError2);
      return null;
    }

    if (isSendCodeEnable) {
      //当按钮可点击时
      isSendCodeEnable = false; //按钮状态标记

      Future response = NetConfig.post(context, NetConfig.sendCode, {
        'cellphone': userphoneCtrl.text.toString(),
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
  Widget _getPhoneInput(bool fcousIs,String selectImgae,String unSelectImage,TextEditingController controller,FocusNode focusNodes,String hitText, bool isCode) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
        border: new Border.all(width: 1, color: fcousIs ? Color.fromRGBO(243, 69, 69,1) : Color.fromRGBO(222, 222, 222,1)),
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
                    gaplessPlayback:true,
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
                            controller: controller,
                            focusNode:   focusNodes,
                            maxLines: 1,
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

            isCode? RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),

              ),
              color: Color.fromRGBO(243, 69, 69,1),
              child: Container(
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              onPressed: () {
                var passwordNums = userphoneCtrl.text;
                if (passwordNums.length == 0 || passwordNums == null) {
                  Tools.showToast(_scaffoldKey, WalletLocalizations.of(context).startPagePhoneError2);
                  return;
                }
                _sendCode(userphoneCtrl.toString());
              },
            ): SizedBox(),
          ],
        ),
      ),
    );
  }
  ///修改安全密码
  Widget _getDataInfo() {
    return new Card(
      color: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: Colors.red)
      ),
      elevation: 1.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CustomRaiseButton(
          context: context,
          hasRow: false,
          title: WalletLocalizations.of(context).publicButtonOK,
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: () {
            var phonesNums = userphoneCtrl.text;
            var passwdNums = passwdCtrl.text;
            var newPasswdNums = newPasswdCtrl.text;
            var codeNums = verificationCodeCtrl.text;
            print('$phonesNums == $codeNums');

            if (phonesNums.length == 0 || phonesNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPageForgetPasswordButton);
              return;
            }
            if (passwdNums.length == 0 || passwdNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPageSafePwdError);
              return;
            }
            if (newPasswdNums.length == 0 || newPasswdNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPageNewSafePasswordInput);
              return;
            }
            if (newPasswdNums != passwdNums) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPageNoEqual);
              return;
            }
            if (codeNums.length == 0 || codeNums == null) {
              Tools.showToast(_scaffoldKey, WalletLocalizations.of(context).startPageCodeError);
              return;
            }

            _onSubmit();

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
        title: Text(WalletLocalizations.of(context).startPageForgetSafePassword),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _getPhoneInput(_hasUserPhoneFocus,'login_phone_select','login_phone_unselect',userphoneCtrl,_nodeUserPhone,WalletLocalizations.of(context)
                .startPagePhoneInputs,false),
            SizedBox(height: 24),

            _getPhoneInput(_hasPasswdFocus,'login_password_select','login_password_unselect',passwdCtrl,_nodePasswd,WalletLocalizations.of(context)
                .startPageSafePwdError,false),
            SizedBox(height: 24),

            _getPhoneInput(_hasNewPasswdFocus,'login_password_select','login_password_unselect',newPasswdCtrl,_nodeNewPasswd,WalletLocalizations.of(context)
                .startPageNewSafePasswordInput,false),
            SizedBox(
              height: 24,
            ),
            _getPhoneInput(_hasCodeFocus,'login_code_select','login_code_unselect',verificationCodeCtrl,_nodeCode,WalletLocalizations.of(context)
                .startPageCodeInput,true),
            SizedBox(
              height: 30,
            ),
            _getDataInfo(),

          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    var phonesNums = userphoneCtrl.text;
    var passwdNums = passwdCtrl.text;
    var newPasswdNums = newPasswdCtrl.text;
    var codeNums = verificationCodeCtrl.text;

    Future result = NetConfig.post(context, NetConfig.addWithdrawPwd, {
      'cellphone': phonesNums,
      'code': codeNums,
      'withdrawPwd':passwdNums
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });
    result.then((data) {
      print('addWithdrawPwd = $data');
      if (data != null) {
        Tools.showToast(_scaffoldKey, '设置成功');
        Navigator.of(context).pop();

      }
    });
  }
}
