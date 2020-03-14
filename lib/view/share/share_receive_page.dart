import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';

//收款页面
class ShareReceivePage extends StatefulWidget {
  static String tag = "ShareReceivePage";

  ShareReceivePage({
    Key key,
  }) : super(key: key);

  @override
  _ShareReceivePageState createState() => _ShareReceivePageState();
}

class _shareModel {
  String webRegisterUrl;
  String invitationCode;
  double minEarningsRatio;
  double maxEarningsRatio;

  _shareModel({
    @required this.webRegisterUrl,
    @required this.invitationCode,
    @required this.minEarningsRatio,
    @required this.maxEarningsRatio,
  });
}

class _ShareReceivePageState extends State<ShareReceivePage> {
  final key = new GlobalKey<ScaffoldState>();

  _shareModel _model = null;

  String shareAddress = null;

  @override
  void initState() {
    super.initState();
    getRanage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(WalletLocalizations.of(context).my_page_server_share),
        ),
        key: this.key,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        body: _model == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : this.body());
  }

  copyAddress(String value) {
    if (kIsWeb) {
      WebTools.copyToClipboardHack(value);
    } else {
      Clipboard.setData(new ClipboardData(text: value));
    }

    Tools.showToast(
        key, WalletLocalizations.of(context).order_recharge_tips_copy);
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        Image.asset(
          Tools.imagePath('share_receive_bg'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  WalletLocalizations.of(context).share_code,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _model.invitationCode,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5495E6)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                shareAddress == null
                                    ? Container(
                                        width: 200,
                                        height: 200,
                                        padding: EdgeInsets.only(
                                            left: 50,
                                            right: 50,
                                            top: 80,
                                            bottom: 80),
                                        color: Color(0xffFFEEEB),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF34545),
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: InkWell(onTap: (){

                                          },
                                            child: Text(
                                              WalletLocalizations.of(context)
                                                  .share_rate,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : QrImage(
                                        data: shareAddress,
                                        size: 200.0,
                                        foregroundColor: Colors.black,
                                        padding: EdgeInsets.all(20),
                                        version: 7,
                                        //字符串很长的时候要加
                                        onError: (ex) {
                                          print("[QR] ERROR - $ex");
                                        },
                                      ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: AutoSizeText(
                                    GlobalInfo.userInfo.webShareAddress,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    minFontSize: 8,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    copyAddress(
                                        GlobalInfo.userInfo.webShareAddress);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 38,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.0),
                                      color: Colors.blue,
                                    ),
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ],
    );
  }

  showTips(String content) {
    this.key.currentState.hideCurrentSnackBar();
    this.key.currentState.showSnackBar(
          SnackBar(
            content: Text(content),
            duration: Duration(seconds: 1, milliseconds: 200),
          ),
        );
  }

  void getRanage() {
    Future future = NetConfig.post(context, NetConfig.shareRatioRanage, {},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(key, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        _model = _shareModel(
            webRegisterUrl: data['webRegisterUrl'],
            invitationCode: data['invitationCode'],
            minEarningsRatio: data['minEarningsRatio'],
            maxEarningsRatio: data['maxEarningsRatio']);
      }
      setState(() {});
    });
  }
}
