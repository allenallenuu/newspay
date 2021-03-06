import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpay_app/model/grap_model.dart';
import 'package:wpay_app/tools/GlobalEventBus.dart';
import 'package:wpay_app/view/welcome/start_login.dart';
import 'package:wpay_app/view/widgets/notificationCenter.dart';
import 'package:wpay_app/view_model/state_lib.dart';
import 'package:http_parser/http_parser.dart';

class NetConfig {
  static String imageHost = 'http://sev.mb2p9.cn:9040';
  static String apiHost = 'http://sev.mb2p9.cn:9040/walletClientTest/api/';

  /// 获取最新的版本信息
  static String getNewestVersion = 'common/getNewestVersion';
  //我的代理信息
  static String getOwnInfo = 'share/getOwnInfo';
  //我的下级代理信息
  static String getInfoByUid = 'share/getInfoByUid';

  //修改比例
  static String changeEarningsRatio = 'share/changeEarningsRatio';


  /// 图片上传
  static String uploadImage = 'common/uploadImage';

  ///推送信息提交
  static String JpushIdentity = 'user/updateUserIdentity';

  /// user/updateUserFace   更新用户头像
  static String updateUserFace = 'user/updateUserFace';

  ///上传凭证
  static String updateVoucher = 'common/uploadRechangeImg';

  /// bankList 获取充值方式
  static String GetPaymentMethodList = 'user/bankList';
  //发送短信
  static String sendCode = 'common/getSmsCode';

  //金额变动
  static String balanceLogList = 'user/balanceLogList';

  //提现记录
  static String withdrawList = 'withdraw/withdrawList';

  //充值记录
  static String rechargeList = 'recharge/rechargeList';

  //登录
  static String loginByPhone = 'common/activeByPhone';

  //密码登录
  static String loginByPwd = 'common/login';

  /// 获取用户信息
  static String getUserInfo = 'user/getUserInfo';

  //修改登录密码
  static String updateUserPassword = 'user/updateUserPassword';

  //忘记密码
  static String retrievePassword = 'common/retrievePassword';
  //安全密码
  static String addWithdrawPwd = 'withdraw/addWithdrawPwd';

  //忘记安全密码
  static String forgetPayPwd = 'common/forgetPayPwd';

  //验证码验证
  static String registerAccount = 'common/activeByPhone';

  //联系我们
  static String contactusGet = 'contactus/get';

  //修改名字
  static String updateUserNickname = 'user/updateUserNickname';

  //PaymentMethodAdd 添加
  static String AddPaymentMethod = "user/addBank";

  /// PaymentMethodUpdate/修改充值方式
  static String UpdatePaymentMethod = 'user/updateBank';

  //PaymentMethodDele 删除
  static String DelePaymentMethod = "user/deleteBank";

  ///代理用户提现接口
  static String AgentInvitationSave = 'userAgency/addAgencyWithdraw';

  /// 获取 用户余额列表
  static String balanceList = 'user/getBalance';

  /// 今日收益
  static String profitData = 'user/grap/profit';

  //查询抢单页面数据：
  static String grapOrderInfo = 'user/grap/grapData';

  //开始抢单
  static String startGrap = 'user/grap/startGrap';

  //停止抢单
  static String stopGrap = 'user/grap/stopGrap';

  //确认订单
  static String sureGrap = 'user/grap/orderConfirm';

  //获取公号银行信息
  static String golbalCard= 'recharge/rechargeMethod';

  //充值接口
  static String recharge = 'recharge/recharge';

  //提现
  static String withDraw = 'withdraw/addUserWithdraw';

  //获取代理比例范围
  static String shareRatioRanage = 'share/getEarningsRatioRange';

  static post(
    BuildContext context,
    String url,
    Map<String, String> data, {
    Function errorCallback = null,
    int timeOut = 60,
    bool showToast = true,
  }) async {
    return _sendData(
      context,
      "post",
      url,
      data,
      errorCallback: errorCallback,
      timeOut: timeOut,
      showToast: showToast,
    );
  }

  static get(BuildContext context, String url,
      {Function errorCallback, int timeOut = 60, bool showToast = true}) async {
    return _sendData(context, "get", url, null,
        errorCallback: errorCallback, timeOut: timeOut, showToast: showToast);
  }

  static bool checkData(data) {
    if (data != null && (data != 408 && data != 600 && data != 404)) {
      return true;
    }
    return false;
  }

  static _sendData(
    BuildContext context,
    String reqType,
    String url,
    Map<String, String> data, {
    Function errorCallback = null,
    int timeOut = 60,
    bool showToast = true,
  }) async {
    Map<String, String> header = new Map();
    //common/sellcoinList 加token 不显示自己的订单

    if (GlobalInfo.userInfo.loginToken != null) {
      header['authorization'] = 'Bearer ' + GlobalInfo.userInfo.loginToken;
    }

    url = apiHost + url;
    print(url);
    print('seed to server data: $data');
//    showToast('begin get data from server ',toastLength:Toast.LENGTH_LONG);
    Response response = null;
    try {
      if (reqType == "get") {
        response = await http
            .get(url, headers: header)
            .timeout(Duration(seconds: timeOut));
      } else {
        var dataStr = json.encode(data);
        var dataMD5 =
            Tools.convertMD5Str(dataStr + GlobalInfo.dataEncodeString);
        data['dataStr'] = dataStr;
        data['dataMD5'] = dataMD5;
        response = await http
            .post(url, headers: header, body: data)
            .timeout(Duration(seconds: timeOut));
      }
    } on TimeoutException {
      if (errorCallback != null) {
        errorCallback(WalletLocalizations.of(context).network_time_out_error);
      }
      return 408;
    } on Exception {
      if (errorCallback != null) {
        errorCallback(WalletLocalizations.of(context).network_error);
      }
      return 600;
    }

//    Fluttertoast.cancel();
    print(response.statusCode);
    bool isError = true;
    String msg;
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      int status = result['status'];
      print(result);
      if (status == 1) {
        var data = result['data'];
        isError = false;
        return data;
      }
      if (status == 0) {
        msg = result['msg'];
        if (msg != null && msg.length > 0 && showToast) {
          if (errorCallback != null) {
            errorCallback(msg);
          }
        }
      }
      if (status == 403) {}
    } else if (response.statusCode == 403) {

      NotificationCenter.instance.postNotification(NotificationCenter.eventStopGrap, 1);

      NotificationCenter.instance.removeNotification(NotificationCenter.eventStopGrap);
      NotificationCenter.instance.removeNotification(NotificationCenter.eventJumpToPage);

      GlobalInfo.clear();
      msg = '请重新登录';
      if (!kIsWeb) {
        Future<SharedPreferences> prefs = SharedPreferences.getInstance();
        prefs.then((share) {
          share.clear();
        });
      }

      if (context != null && !url.contains(NetConfig.getUserInfo)) {
        Navigator.of(context).pushNamed(StartLoginPage.tag);
      }
      debugPrint('user logout, please login');
    } else {
      debugPrint('server is sleep, please wait');
    }
    if (errorCallback != null && isError) {
      errorCallback(msg);
    }
    if (response.statusCode == 404) {
      return response.statusCode;
    }
    return null;
  }

  ///更新用户头像
  static updateImage(String api,String key,String returnKey,File imageFile,
      {@required Function callback, Function errorCallback}) async {
    String url = apiHost + api;
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> header = new Map();
    header['authorization'] = 'Bearer ' + GlobalInfo.userInfo.loginToken;
    request.headers.addAll(header);
    var multipartFile = new http.MultipartFile(key, stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var response = await request.send();

    bool flag = true;
    if (response.statusCode == 200) {
      await response.stream.transform(utf8.decoder).listen((data) {
        var result = json.decode(data);
        if(returnKey.isEmpty){
          callback(result['data']);
        }else{
          callback(result['data'][returnKey]);
        }
        flag = false;
      });
    }
    if (flag == true && errorCallback != null) {
      errorCallback();
    }
  }

  //更新用户头像web
  static updateImageWeb(String api,String key,String returnKey,List<int> _selectedFile,
      {@required Function callback, Function errorCallback}) async {
    String url = apiHost + api;
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> header = new Map();
    header['authorization'] = 'Bearer ' + GlobalInfo.userInfo.loginToken;
    request.headers.addAll(header);
    request.files.add(await http.MultipartFile.fromBytes(
        key, _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "temp.png"));

    var response = await request.send();

    bool flag = true;
    if (response.statusCode == 200) {
      await response.stream.transform(utf8.decoder).listen((data) {
        var result = json.decode(data);
        if(returnKey.isEmpty){
          callback(result['data']);
        }else{
          callback(result['data'][returnKey]);
        }
        flag = false;
      });
    }
    if (flag == true && errorCallback != null) {
      errorCallback();
    }
  }
}
