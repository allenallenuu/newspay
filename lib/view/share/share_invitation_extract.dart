import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/model/share_invitation_info.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/tools/key_config.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';
import 'package:qiangdan_app/view_model/main_model.dart';

class ShareInvitationExtract extends StatefulWidget {
  static String tag = "ShareInvitationExtract";

  final ShareInvitationAvailable shareInvitationModel;

  ShareInvitationExtract({Key key, @required this.shareInvitationModel})
      : super(key: key);

  @override
  _ShareInvitationExtractState createState() => _ShareInvitationExtractState();
}

class _ShareInvitationExtractState extends State<ShareInvitationExtract> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ShareInvitationAvailable _shareInvitationModel;

  TextEditingController controllerShareInvitationNumber;

  @override
  void initState() {
    super.initState();
    _shareInvitationModel = widget.shareInvitationModel;
    controllerShareInvitationNumber = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controllerShareInvitationNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: Text('1'),
        ),
        body: body());
  }

  Widget body() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 30),
        child: Column(
            children: <Widget>[
            _getShareInvitationNumber(),
        _getAvailableNumber(),
        SizedBox(
          height: 20,
        ),
        _getApply(),]
    ,
    )
    ,
    );
  }

  ///转存币数
  Widget _getShareInvitationNumber() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  child: new Center(
                    child: AutoSizeText(
                     '1',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                              controller: controllerShareInvitationNumber,
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              maxLength: 11,
                              maxLengthEnforced: true,
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 18.0),
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
              new Container(
                child: new Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controllerShareInvitationNumber.text =
                            _shareInvitationModel.shareCoin.toString();
                      });
                    },
                    child: AutoSizeText(
                      '1',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///可用总额
  Widget _getAvailableNumber() {
    return new Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AutoSizeText(
                '1'+":" +
                    ((_shareInvitationModel == null)
                        ? "0"
                        : _shareInvitationModel.shareCoin.toString()),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///提现
  Widget _getApply() {
    return new Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.87 * 0.8,
      child: CustomRaiseButton(
        context: context,
        hasRow: false,
        title: '1',
        titleColor: Colors.white,
        color: AppCustomColor.tabbarBackgroudColor,
        callback: () {
          _saveAction(controllerShareInvitationNumber.text);
        },
      ),
    );
  }

  void _saveAction(String text) {
    var mDouble =
    double.tryParse(controllerShareInvitationNumber.text.toString());
    if (mDouble is double) {
      if (mDouble > _shareInvitationModel.shareCoin) {
        Tools.showToast(_scaffoldKey,'1');
      } else {
        Tools.loadingAnimation(context);
        Future<SharedPreferences> prefs = SharedPreferences.getInstance();
        prefs.then((share) {
          String val = share.getString(KeyConfig.user_login_userId);
          GlobalInfo.userInfo.userId = val;

          Future future =
          NetConfig.post(context, NetConfig.AgentInvitationSave, {
            'userId': GlobalInfo.userInfo.userId,
            'withdrawCoin': controllerShareInvitationNumber.text.toString()
          }, errorCallback: (msg) {
            Tools.showToast(_scaffoldKey,msg.toString());
          });

          future.then((data) {
            Navigator.pop(context);
            if (NetConfig.checkData(data)) {
              Tools.showToast(_scaffoldKey,'1');
              Navigator.pop(context,true);
            }else{
              Navigator.pop(context);
            }
          });
        });
      }
    } else {
      Tools.showToast(_scaffoldKey,
          '1');
    }
  }
}
