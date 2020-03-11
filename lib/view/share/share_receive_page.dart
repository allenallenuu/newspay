import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/model/share_invitation_info.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';

//收款页面
class ShareReceivePage extends StatefulWidget {
  static String tag = "ShareReceivePage";

  final ShareReceiveModel shareReceiveModel;

  ShareReceivePage({Key key, @required this.shareReceiveModel})
      : super(key: key);

  @override
  _ShareReceivePageState createState() => _ShareReceivePageState();
}

class _ShareReceivePageState extends State<ShareReceivePage> {
  ShareReceiveModel _shareAddress;

  final key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _shareAddress = widget.shareReceiveModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.key,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        body: this.body());
  }

  copyAddress(String value) {
    if (kIsWeb) {
      WebTools.copyToClipboardHack(value);
    } else {
      Clipboard.setData(new ClipboardData(text: value));
    }

    this.showTips(
       '1');
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
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                    height: 458,
                      padding: EdgeInsets.only(top:32),
                      decoration: !kIsWeb
                          ? BoxDecoration(
                              image: DecorationImage(fit: BoxFit.fitHeight,
                              image: AssetImage(Tools.imagePath('icon_code_2')),
                            ))
                          : BoxDecoration(
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
                           height: 118,
                           alignment: Alignment.center,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Text(
                                '1',
                                 style: TextStyle(fontSize: 16),
                               ),
                               SizedBox(height: 10),
                               Text(
                                 GlobalInfo.userInfo.webShareAddress,
                                 style: TextStyle(
                                     fontSize: 22,
                                     fontWeight: FontWeight.bold,
                                     color: Color(0xFF5495E6)),
                               ),
                               SizedBox(height: 10),
                               InkWell(
                                 onTap: () {
                                   GlobalInfo.userInfo.webShareAddress;
                                 },
                                 child: Container(
                                   width: 100,
                                   height: 38,
                                   alignment: Alignment.center,
                                   padding: EdgeInsets.only(
                                       left: 20, right: 20, top: 10, bottom: 10),
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

                          Container(
                            height: 308,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                QrImage(
                                  data: _shareAddress.shareAddress,
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
                                    _shareAddress.shareAddress,
                                    style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                    minFontSize: 8,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    copyAddress(_shareAddress.shareAddress);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 38,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 10, bottom: 10),
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
        Container(
          margin: EdgeInsets.only(top: 40, left: 10),
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
}
