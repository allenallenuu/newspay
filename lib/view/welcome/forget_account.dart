import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';

import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';

class ForgetAccount extends StatefulWidget {
  static String tag = 'ForgetAccount';
  var phoneNums;
  var codeNmus;

  ForgetAccount({
    Key key,
    this.phoneNums,
    this.codeNmus,
  }) : super(key: key);

  @override
  _ForgetAccountState createState() => _ForgetAccountState();
}
class _ForgetAccountState extends State<ForgetAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasPhoneFocus = false;
  bool _hasVerificationCodeFocus = false;

  FocusNode _nodePhone = FocusNode();
  FocusNode _nodeVerificationCode = FocusNode();

  TextEditingController phoneCtrl = TextEditingController(text: "");
  TextEditingController verificationCodeCtrl = TextEditingController();

  bool isSendCodeEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;
  String buttonText = "获取验证码";
  var reg = new RegExp('^1[0-9]{10}');

  @override
  void initState() {

    _nodePhone.addListener(() {
      if (_nodePhone.hasFocus) { // get focus
        _hasPhoneFocus = true;
        _hasVerificationCodeFocus = false;

      }
      setState(() {});
    });
    _nodeVerificationCode.addListener(() {
      if (_nodeVerificationCode.hasFocus) { // get focus
        _hasPhoneFocus = false;
        _hasVerificationCodeFocus = true;

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
    phoneCtrl.dispose();
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
                var phoneNums = phoneCtrl.text;
                if (phoneNums.length == 0 || phoneNums == null) {
                  Tools.showToast(_scaffoldKey, '请输入正确的手机号');
                  return;
                }
                _sendCode(phoneCtrl.toString());
              },
            ): SizedBox(),
          ],
        ),
      ),
    );
  }
  ///找回用户名
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
          title: WalletLocalizations.of(context).startPageSearchAccount,
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: () {
            var phoneNums = phoneCtrl.text;
            var verificationCodeNums = verificationCodeCtrl.text;


            if (phoneNums.length == 0 || phoneNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPagePhoneInputs);
              return;
            }

            if (verificationCodeNums.length == 0 || verificationCodeNums == null) {
              Tools.showToast(_scaffoldKey, WalletLocalizations.of(context).startPageCodeError);
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
        title: Text(WalletLocalizations.of(context).startPageForgetAccount),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            _getPhoneInput(_hasPhoneFocus,'login_phone_select','login_phone_unselect',phoneCtrl,_nodePhone,WalletLocalizations.of(context)
                .startPagePhoneInputs,false),
            SizedBox(height: 24,),
            _getPhoneInput(_hasVerificationCodeFocus,'login_code_select','login_code_unselect',verificationCodeCtrl,_nodeVerificationCode,WalletLocalizations.of(context)
                .startPageCodeInput,true),
            SizedBox(height: 24,),
            _getDataInfo(),

          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    var phoneNums = phoneCtrl.text;
    var codeNums = verificationCodeCtrl.text;

    Future result = NetConfig.post(context, NetConfig.isCode, {
      'cellphone': phoneNums,
      'code': codeNums,
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });
    result.then((data) {
      print('isCode = $data');
      if (data != null) {
//        Navigator.of(context)
//            .push(MaterialPageRoute(builder: (BuildContext context) {
//          return ForgetLoginPassword(
//            phoneNums: phonesNums,
//            codeNmus: codeNums,
//          );
//        }));
        Navigator.of(context).pop();
      }
    });
  }
}
