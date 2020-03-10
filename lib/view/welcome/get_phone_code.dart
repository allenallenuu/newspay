import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/welcome/forget_login_password.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';

class GetCodePassword extends StatefulWidget {
  var typeSet;

  GetCodePassword({Key key, this.typeSet}) : super(key: key);
  static String tag = "GetCodePassword";

  @override
  _GetCodePasswordState createState() => _GetCodePasswordState();
}

class _GetCodePasswordState extends State<GetCodePassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController userphoneCtrl = TextEditingController(text: "");
  TextEditingController controllerPassword;
  TextEditingController passwdCtrl = TextEditingController();

  bool isSendCodeEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;
  String buttonText = "获取验证码";
  var reg = new RegExp('^1[0-9]{10}');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userphoneCtrl.dispose();
    passwdCtrl.dispose();
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
              '1'; //重置按钮文本
        } else {
          buttonText = '1' +
              '($count)'; //更新文本内容
        }
      });
    });
  }

  Function _sendCode(String phone) {
    if (userphoneCtrl.text.toString().trim() == '') {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    } else if (!reg.hasMatch(userphoneCtrl.text.toString().trim())) {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    }

    if (isSendCodeEnable) {
      //当按钮可点击时
      isSendCodeEnable = false; //按钮状态标记
      _initTimer();

      Future response = NetConfig.post(context, NetConfig.sendCode, {
        'cellphone': userphoneCtrl.text.toString(),
      }, errorCallback: (msg) {
        Tools.showToast(_scaffoldKey, msg);
      });

      response.then((data) {
        if (NetConfig.checkData(data)) {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('1'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                '手机号',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 10),
              child: TextField(
                controller: userphoneCtrl,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                maxLength: 11,
                maxLengthEnforced: true,
                obscureText: false,
                style: new TextStyle(color: Colors.black, fontSize: 18.0),
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入手机号码',
                    counterText: '',
                    hintStyle: new TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    )),
              ),
            ),
            Divider(height: 0, indent: 15),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                '验证码',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                          height: 50.0,
                          margin: new EdgeInsets.only(bottom: 4.0),
                          child: new Center(
                              child: new Container(
                            height: 50.0,
                            child: new TextField(
                              controller: passwdCtrl,
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              maxLength: 11,
                              maxLengthEnforced: true,
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              decoration: new InputDecoration(
                                  hintText: '1',
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintStyle: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  )),
                            ),
                          )))),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: AppCustomColor.btnConfirm,
                    child: Container(
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      var passwordNums = userphoneCtrl.text;
                      if (passwordNums.length == 0 || passwordNums == null) {
                        Tools.showToast(_scaffoldKey, '请输入正确的手机号');
                        return;
                      }
                      _sendCode(userphoneCtrl.toString());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(height: 0, indent: 15),
            SizedBox(
              height: 70,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: RaisedButton(
                child: Text('1'),
                onPressed: () {
                  var phonesNums = userphoneCtrl.text;
                  var codeNums = passwdCtrl.text;
                  print('$phonesNums == $codeNums');

                  if (phonesNums.length == 0 || phonesNums == null) {
                    Tools.showToast(
                        _scaffoldKey,
                       '1');
                    return;
                  }
                  if (codeNums.length == 0 || codeNums == null) {
                    Tools.showToast(_scaffoldKey, '请输入正确的验证码');
                    return;
                  }

                  _onSubmit();

//                  addDigTask(moneyNums.toString());
                },
                //通过将onPressed设置为null来实现按钮的禁用状态
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10) //设置圆角
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    var phonesNums = userphoneCtrl.text;
    var codeNums = passwdCtrl.text;

    Future result = NetConfig.post(context, NetConfig.isCode, {
      'cellphone': phonesNums,
      'code': codeNums,
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });
    result.then((data) {
      print('isCode = $data');
      if (data != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ForgetLoginPassword(
            phoneNums: phonesNums,
            codeNmus: codeNums,
          );
        }));
      }
    });
  }
}
