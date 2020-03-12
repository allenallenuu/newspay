import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';
import 'package:qiangdan_app/view_model/home_page_agent_model.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class HomePageAgentDetail extends StatefulWidget {
  static String tag = "HomePageAgentDetail";
  String uid;
  HomePageAgentDetail({Key key,  this.uid})
      : super(key: key);
  @override
  _HomePageAgentDetailState createState() => _HomePageAgentDetailState();
}

class _HomePageAgentDetailState extends State<HomePageAgentDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<agentModel> _agentModel = null;
  String totalProfit = '0';
  String earningsRatio = '0';
  String customerShareCount = '0';

  @override
  void initState() {
    // TODO: implement initState
    this.getWalletInfoes(context);
    super.initState();
  }

  getWalletInfoes(BuildContext context, {Function callback = null}) {
    print("getInfoByUid -------" + NetConfig.getInfoByUid.toString());
    Future future =
    NetConfig.post(context, NetConfig.getInfoByUid, {
      'uid' : widget.uid
    }, errorCallback: (msg) {
      print("getInfoByUid ------- $msg");
    }, timeOut: 10);
    future.then((data) {
      print("getInfoByUid = $data");
      if (NetConfig.checkData(data)) {
        this._agentModel = [];
        customerShareCount = data['customerShareCount'].toString();
        totalProfit = data['totalProfit'].toString();
        earningsRatio = data['earningsRatio'].toString();

            agentModel info = agentModel(
              uid: data['uid'].toString(),
              faceUrl: data['faceUrl'],
              nickname: data['nickname'],
              cellphone: data['cellphone'],
            );
            _agentModel.add(info);


        setState(() {});
      } else {
        this._agentModel = [];
        setState(() {});
      }

      if (callback != null) {
        callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          WalletLocalizations.of(context).homePageAgent,
        ),
      ),
      body: _agentModel == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(246, 246, 246, 1),
                  ),
                  child: buildItemes(context));
            }),
      ),
    );
  }
  Widget _agentTotalWidget() {
    return Card(
      margin: EdgeInsets.only(left: 15, right: 15, top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 8.0,
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppCustomColor.tabbarBackgroudColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            WalletLocalizations.of(context).sellcoinTotalAssets,
                            style:
                            TextStyle(fontSize: 15, color: Colors.white70),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
//                                dataInfo.totalBalance.toString(),
                            this.totalProfit,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          margin: EdgeInsets.only(top: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                WalletLocalizations.of(context)
                                    .homePageAgentNums,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white70),
                                minFontSize: 8,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
//                                dataInfo.totalBalance.toString(),
                                this.customerShareCount,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          margin: EdgeInsets.only(top: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                WalletLocalizations.of(context)
                                    .homePageAgentRatio,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white70),
                                minFontSize: 8,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
//                                dataInfo.totalBalance.toString(),
                                this.earningsRatio + '%',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  buildItemes(BuildContext context) {
    return Column(
      children: <Widget>[
        _agentTotalWidget(),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15),
//              width: MediaQuery.of(context).size.width / 2 -30,
              child: Text(
                WalletLocalizations.of(context).homePageAgentSubordinate,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
//          height: (82.0 * _walletInfoes.length),
          height: 75.0 * _agentModel.length,
          child: ListView.builder(
              physics: new NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 15, right: 15),
              itemCount: _agentModel.length,
              itemBuilder: (BuildContext context, int index) {
                agentModel agentInfos = _agentModel[index];
                return Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new CircleAvatar(
//                              child: kIsWeb
//                                  ? WebTools.networkImageWeb(
//                                  NetConfig.imageHost + dataInfos.remark)
//                                  : Tools.networkImage(dataInfos.remark),
                              child: Image.asset(
                                Tools.imagePath('icon_defalut'),
                                width: 36,
                                height: 36,
                              ),
                              radius: 25.0,
                              backgroundColor: Colors.transparent,
                            ),
                            new Container(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: new Text(
                                agentInfos.nickname == null
                                    ? '匿名'
                                    : agentInfos.nickname,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            new Container(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: new Text(
                                agentInfos.cellphone == null
                                    ? '138xxxx33'
                                    : agentInfos.cellphone,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppCustomColor.tabbarBackgroudColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 20),
        new Container(
          padding: const EdgeInsets.only(right: 8.0),
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(
                width: 1,
                color: AppCustomColor.tabbarBackgroudColor),
            borderRadius: BorderRadius.circular(22),
          ),
          child: FlatButton(
              onPressed: () {

              },
              child: Text(
                WalletLocalizations.of(context)
                    .homePageAgentChangeRatio,
                style: TextStyle(
                    color: AppCustomColor.tabbarBackgroudColor, fontSize: 14),
              )),
        ),
      ],
    );
  }
}