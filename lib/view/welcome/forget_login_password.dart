import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';

import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class ForgetLoginPassword extends StatefulWidget {
  static String tag = 'ForgetLoginPassword';
  var phoneNums;
  var codeNmus;

  ForgetLoginPassword({
    Key key,
    this.phoneNums,
    this.codeNmus,
  }) : super(key: key);

  @override
  _ForgetLoginPasswordState createState() => _ForgetLoginPasswordState();
}

class _ForgetLoginPasswordState extends State<ForgetLoginPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controllerPassword;
  TextEditingController controllerPasswordAgain;
  bool obscureTextisVail = true;
  bool obscureTextisVailAgain = true;

  @override
  void initState() {
    controllerPassword = TextEditingController();
    controllerPasswordAgain = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerPasswordAgain.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        appBar: AppBar(
          title: Text(
              '1'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: controllerPassword,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        maxLength: 11,
                        maxLengthEnforced: true,
                        obscureText: obscureTextisVail,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 18.0),
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: '1',
                            counterText: '',
                            hintStyle: new TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 40.0,
                      margin: EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        child: Image.asset(
                          !obscureTextisVail
                              ? Tools.imagePath('password_hide')
                              : Tools.imagePath('password_show'),
                          width: 20,
                          height: 20,
                        ),
                        onTap: () {
                          setState(() {
                            obscureTextisVail = !obscureTextisVail;
                          });
                        },
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.blue,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: controllerPasswordAgain,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        maxLength: 11,
                        maxLengthEnforced: true,
                        obscureText: obscureTextisVailAgain,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 18.0),
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: '1',
                            counterText: '',
                            hintStyle: new TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 40.0,
                      margin: EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        child: Image.asset(
                          !obscureTextisVailAgain
                              ? Tools.imagePath('password_hide')
                              : Tools.imagePath('password_show'),
                          width: 20,
                          height: 20,
                        ),
                        onTap: () {
                          setState(() {
                            obscureTextisVailAgain = !obscureTextisVailAgain;
                          });
                        },
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Color.fromRGBO(84, 149, 230, 1),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45.0,
                child: RaisedButton(
                  child: Text('确定'),
                  onPressed: () {
                    var passwordNums = controllerPassword.text;
                    var passwordNumss = controllerPasswordAgain.text;

                    //安全密码
                    if (passwordNums.length == 0 ||
                        passwordNums == null ||
                        passwordNumss.length == 0 ||
                        passwordNumss == null) {
                      Tools.showToast(
                          _scaffoldKey,
                          '1');
                      return;
                    }
                    if (passwordNums != passwordNumss) {
                      Tools.showToast(_scaffoldKey, '请输入相同的密码！');
                      return;
                    }
//                    if(widget.codeNmus.length > 0){
                    _onSubmit();
//                    }else {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (BuildContext context) {
//                            return SetPayPassword();
//                          }));
//                    }
                  },
                  //通过将onPressed设置为null来实现按钮的禁用状态
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10) //设置圆角
                      ),
                ),
              ),
            ],
          ),
        ));
  }

  void _onSubmit() {
    //安全密码
    if (controllerPassword.text.length == 0 ||
        controllerPassword.text == null ||
        controllerPasswordAgain.text.length == 0 ||
        controllerPasswordAgain.text == null) {
      Tools.showToast(_scaffoldKey,
          '1');
      return;
    }
    if (controllerPassword.text != controllerPasswordAgain.text) {
      Tools.showToast(_scaffoldKey, '新密码不一致，请重新输入。');
      return;
    }
    Future result = NetConfig.post(context, NetConfig.forgetPwd, {
      'cellphone': widget.phoneNums,
      'code': widget.codeNmus,
      'pwd': controllerPasswordAgain.text
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });

    result.then((data) {
      print('forgetPwd = $data');
      if (NetConfig.checkData(data)) {
        Navigator.of(context).pushNamed(StartLoginPage.tag);
      }
    });
  }
}
