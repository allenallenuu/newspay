import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/WebTools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/home_page_agent_model.dart';
import 'package:wpay_app/view_model/state_lib.dart';
import 'package:wpay_app/view/welcome/start_login.dart';

class HomePageAgentDetail extends StatefulWidget {
  static String tag = "HomePageAgentDetail";
  String uid;

  HomePageAgentDetail({Key key, this.uid}) : super(key: key);

  @override
  _HomePageAgentDetailState createState() => _HomePageAgentDetailState();
}

class _HomePageAgentDetailState extends State<HomePageAgentDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<agentModel> _agentModel = null;
  String totalProfit = '0';
  String earningsRatio = '0';
  String customerShareCount = '0';
  TextEditingController controllerRatio;
  var isValidBtn = true;
  var isLimitBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    controllerRatio = TextEditingController();

    this.getWalletInfoes(context);
    super.initState();
  }

  getWalletInfoes(BuildContext context, {Function callback = null}) {
    Future future =
        NetConfig.post(context, NetConfig.getInfoByUid, {'uid': widget.uid},
            errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
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
                                    ? WalletLocalizations.of(context)
                                    .publicDefaultName
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
                width: 1, color: AppCustomColor.tabbarBackgroudColor),
            borderRadius: BorderRadius.circular(22),
          ),
          child: FlatButton(
              onPressed: () {
                if (this.isLimitBtn) {
                  Tools.showToast(_scaffoldKey, '不要太急哦，稍等片刻。');
                  return;
                }
                this.isLimitBtn = true;
                if (isValidBtn) {
                  updateView();
                  _bottomSheet(context);
                }
              },
              child: Text(
                WalletLocalizations.of(context).homePageAgentChangeRatio,
                style: TextStyle(
                    color: AppCustomColor.tabbarBackgroudColor, fontSize: 14),
              )),
        ),
      ],
    );
  }

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState
                  /*You can rename this!*/) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 200.0,
                padding:
                    EdgeInsets.only(top: 10, bottom: 30, left: 16, right: 16),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        WalletLocalizations.of(context).homePageAgentInputRatio,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: controllerRatio,
                              maxLines: 1,
                              maxLength: 11,
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: WalletLocalizations.of(context)
                                      .homePageAgentInputRatio,
                                  counterText: '',
                                  hintStyle: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 45.0,
                      child: RaisedButton(
                        child: Text(
                            WalletLocalizations.of(context).publicButtonOK),
                        onPressed: () {
                          var ratioNums = controllerRatio.text;
                          //安全密码
                          if (ratioNums.length == 0 || ratioNums == null) {
                            Tools.showToast(
                                _scaffoldKey,
                                WalletLocalizations.of(context)
                                    .homePageAgentInputRatio);
                            return;
                          }
                          addDigTask();
                          Navigator.pop(context);
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
          });
        }).then((value) {
      this.isLimitBtn = false;
    });
  }

  void updateView() {
    setState(() {
      controllerRatio.text = '';
    });
  }

  void addDigTask() {
    Future response = NetConfig.post(context, NetConfig.changeEarningsRatio, {
      'uid': widget.uid,
      'earningsRatio': controllerRatio.text.toString(),
    }, errorCallback: (msg) {
      if (msg.toString() == null) {
        Tools.showToast(_scaffoldKey, '接口错误，请稍后再试');
      } else {
        Tools.showToast(_scaffoldKey, msg.toString());
      }
      this.isLimitBtn = false;
    }, showToast: false);
    response.then((data) {
      if (NetConfig.checkData(data)) {
        print("changeEarnings======= $data");
        this.getWalletInfoes(context);

        this.isValidBtn = false;
        this.isLimitBtn = false;
        setState(() {});
//        updateView();
      } else {
        print("changeEarnings------- $data");
        this.isLimitBtn = false;

        setState(() {});
      }
    });
  }
}
