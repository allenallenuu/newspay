import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:wpay_app/model/global_model.dart';
import 'package:wpay_app/tools/GlobalEventBus.dart';
import 'package:wpay_app/tools/JpushMessageModel.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/net_config.dart';

class JpushToolsInstance {
  factory JpushToolsInstance() => _jpushToolsInstance();
  static JpushToolsInstance _instance;

  bool resginSuccess = false;
  String registrationId;

  String debugLable = 'Unknown';
  final JPush jpush = new JPush();
  Timer _timer;

  // 1就是卖家提醒 2就是买家提醒
  bool buyType = false;
  bool sellType = false;


  JpushToolsInstance._() {
    // 具体初始化代码
    initJpushPlatformState();
  }

  Future<void> initJpushPlatformState() async {
    if (resginSuccess) {
      return;
    }

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          debugLable = "flutter onReceiveNotification: $message";
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          debugLable = "flutter onOpenNotification: $message";
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          debugLable = "flutter onReceiveMessage: $message";
          if(message != null &&  message["extras"] != null){
            if(message["extras"]["cn.jpush.android.CONTENT_TYPE"] != null){
              String type = message["extras"]["cn.jpush.android.CONTENT_TYPE"];
              if(type == "1"){
                this.sellType = true;
              }
              if(type == "2"){
                this.buyType = true;
              }
              GlobalEventBus().event.fire(new JpushMessageModel());
            }
          }
        },
      );
    } on PlatformException {
    }

    jpush.setup(
      appKey: "9fa49b090afa7e574b80e5ef",
      channel: "theChannel",
      production: false,
      debug: true,
    );

    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      debugLable = "flutter getRegistrationID: $rid";
//      Tools.showToast(debugLable);
      resginSuccess = true;

      registrationId = rid;

      updateIdentity("",registrationId);

      _timer =
          Timer(Duration(seconds: GlobalInfo.sleepTime), // Default is 5 mins.
              () {
        setAlias(); // will be
      });
    });
  }

  void setAlias() {
    //设置别名  实现指定用户推送
    jpush.setAlias(GlobalInfo.userInfo.uid).then((map) {
      print("设置别名成功");
      updateIdentity(GlobalInfo.userInfo.uid,registrationId);
      _timer.cancel();

    }).catchError((error) {
      debugLable = "setAlias error: $error";
      _timer =
          Timer(Duration(seconds: GlobalInfo.sleepTime), // Default is 5 mins.
              () {
        setAlias();
        if (_timer != null) {
          _timer.cancel();
        }
      });
    });
  }

  //上传参数到服务器
  void updateIdentity(String alias, String registrationId){

    Future future = NetConfig.post(null, NetConfig.JpushIdentity, {
      'alias': alias,
      'registrationId': registrationId
    }, errorCallback: (msg) {
    });

    future.then((data) {
      if (NetConfig.checkData(data)) {
      }
    });

  }

  static JpushToolsInstance _jpushToolsInstance() {
    if (_instance == null) {
      _instance = JpushToolsInstance._();
    }
    return _instance;
  }
}
