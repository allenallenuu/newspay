import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Start page.
/// [author] tt
/// [time] 2019-3-5

import 'package:flutter/material.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/model/user_info.dart';
import 'package:qiangdan_app/tools/CustomTabbar/CustomTabIndicator.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/tools/key_config.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/main_view/main_page.dart';
import 'package:qiangdan_app/view/welcome/get_phone_code.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';

class RegisterPage extends StatefulWidget {
  static String tag = "RegisterPage";
  bool needBack = true;

  RegisterPage({Key key, this.needBack}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _needBack;

  ///总的分页
  TabController _tabMainController = null;
  int mainTabPosition = 0;

  String tab1;
  String tab2;
  int tabLength = 2;

  //总分页
  Widget _getInitMainTab() {
    tab1 = '1';
    tab2 = '1';

    if (_tabMainController == null) {
      _tabMainController = TabController(
          initialIndex: mainTabPosition, length: tabLength, vsync: this);
      _tabMainController.addListener(() {
        if (this._tabMainController.offset == 0) {
          setState(() {
            mainTabPosition = this._tabMainController.index;
          });
        }
      });
    }
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: TabBar(
          controller: _tabMainController,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(fontSize: 16.0),
          labelPadding: EdgeInsets.only(bottom: 3),
          isScrollable: false,
          indicator: CustomTabIndicator(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
            insets: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          ),
          unselectedLabelColor: Colors.grey,
          tabs: [
            Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  tab1.toString(),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  tab1.toString(),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ]),
    );
  }

  String log;

  bool isSendCodeEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;
  String buttonText = '获取验证码';

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
    _needBack = widget.needBack;
  }

  @override
  Widget build(BuildContext context) {
    String bgString;

    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Tools.imagePath(bgString)),
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
                            _getInitMainTab(),
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
    if (_tabMainController != null) {
      _tabMainController.dispose();
    }
    userphoneCtrl.dispose();
    passwdCtrl.dispose();
    if (timer != null) {
      timer.cancel();
      //销毁计时器
      timer = null;
    }
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
        _needBack
            ? Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        Tools.imagePath('icon_back_page'),
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        '1',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox()
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
                Tools.imagePath('login_phone'),
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
                            hintText: '1',
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
                Tools.imagePath('login_password'),
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
                            hintText: mainTabPosition == 0
                                ? '1'
                                : '1',
                            counterText: '',
                            border: InputBorder.none,
                            hintStyle: new TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    )))),
            mainTabPosition == 0
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: AppCustomColor.tabbarBackgroudColor,
                    child: Container(
                      child: Text(
                       '1',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      _sendCode(userphoneCtrl.toString());
                    },
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  ///忘记密码
  Widget _forgetPassword() {
    return mainTabPosition == 0
        ? SizedBox(
            height: 30,
          )
        : Container(
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
                    '1',
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
          title: '1',
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: () {
            if (mainTabPosition == 0) {
              _loginActionByCode(userphoneCtrl.text, passwdCtrl.text);
            } else {
              _loginActionByPwd(userphoneCtrl.text, passwdCtrl.text);
            }
          },
        ),
      ),
    );
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

      Future response = NetConfig.post(
        context,
        NetConfig.sendCode,
        {'cellphone': userphoneCtrl.text},
      );

      response.then((data) {
        if (NetConfig.checkData(data)) {}
      });
    }
  }

  void _loginActionByCode(String phone, String code) {
    if (phone.trim() == '') {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    } else if (!reg.hasMatch(phone.trim())) {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    } else if (code == '') {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    }

    Tools.loadingAnimation(context);

    Future response = NetConfig.post(context, NetConfig.loginByPhone, {
      'cellphone': userphoneCtrl.text,
      'code': passwdCtrl.text,
//      'userId': GlobalInfo.userInfo.shareUid == null
//          ? ""
//          : GlobalInfo.userInfo.shareUid,
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

  void _loginActionByPwd(String phone, String code) {
    if (phone.trim() == '') {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    } else if (!reg.hasMatch(phone.trim())) {
      Tools.showToast(
          _scaffoldKey, '1');
      return null;
    } else if (code == '') {
      Tools.showToast(
          _scaffoldKey, '1');
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
