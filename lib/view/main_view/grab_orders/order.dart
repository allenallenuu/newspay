import 'dart:async';

import 'package:flutter/cupertino.dart';

/// My profile page.
/// [author] tt
/// [time] 2019-3-21

import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/grap_model.dart';
import 'package:wpay_app/tools/GlobalEventBus.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/tools/net_config.dart';
import 'package:wpay_app/view/main_view/grab_orders/order_recharge.dart';

class OrderCenter extends StatefulWidget {
  @override
  _OrderCenterState createState() => _OrderCenterState();
}

class _OrderCenterState extends State<OrderCenter> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitch = false;

  GrapModel _grapModel;
  Timer _timePeriodic;

  @override
  void initState() {
    super.initState();

    grapOrderInfo();

    GlobalEventBus()
        .event
        .on<StopGrapThreadModel>()
        .listen((StopGrapThreadModel data) => cancelTimer());

    _timePeriodic = Timer.periodic(Duration(milliseconds: 5000), (timer) {
      grapOrderInfo();
    });
  }

  void cancelTimer() {
    if (_timePeriodic != null) {
      _timePeriodic.cancel();
      _timePeriodic = null;
    }
  }

  @override
  void deactivate() {
    print('离开界面');
    cancelTimer();
  }

  @override
  void dispose() {
    super.dispose();
    GlobalEventBus().event.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudGrayColor,
      body: _grapModel == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 50),
                    color: Color(0xffF34545),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          WalletLocalizations.of(context).singlePage,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    )),
                topView(),
                SizedBox(
                  height: 5,
                ),
                _grapModel == null
                    ? Container()
                    : _grapModel.errorMessage.trim().length == 0
                        ? contentView()
                        : errorView(),
              ],
            ),
    );
  }

  Widget topView() {
    return Stack(
      children: <Widget>[
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Tools.imagePath('order_top_bg')),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 5.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Color(0x33000000),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(90),
                              topRight: Radius.circular(90))),
                      child: Text(
                        WalletLocalizations.of(context).order_total_balance +
                            ':  ' +
                            (_grapModel != null && _grapModel.balance != null
                                ? '￥' + _grapModel.balance.toString()
                                : '￥0.0'),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 5.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Color(0x33000000),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(90),
                              topRight: Radius.circular(90))),
                      child: Text(
                          WalletLocalizations.of(context).order_index +
                              ':  ' +
                              (_grapModel != null &&
                                      _grapModel.grapRatioMinStr != null &&
                                      _grapModel.grapRatioMaxStr != null
                                  ? _grapModel.grapRatioMinStr.toString() +
                                      ' ~ ' +
                                      _grapModel.grapRatioMaxStr.toString() +
                                      '%'
                                  : '0.0 ~ 0.0%'),
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(WalletLocalizations.of(context).order_amount,
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        '￥' +
                            (_grapModel != null &&
                                    _grapModel.grabNumMin != null &&
                                    _grapModel.grabNumMax != null
                                ? _grapModel.grabNumMin.toString() +
                                    ' ~ ' +
                                    _grapModel.grabNumMax.toString()
                                : '0.0 ~ 0.0'),
                        style: TextStyle(fontSize: 24, color: Colors.white))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (isSwitch) {
                          Tools.showToast(_scaffoldKey,
                              WalletLocalizations.of(context).order_graping);
                        } else {
                          startGrap();
                        }
                      },
                      child: Image.asset(
                        !isSwitch
                            ? Tools.imagePath('order_switch_close')
                            : Tools.imagePath('order_switch_open'),
                        width: 60,
                        height: 60,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 175.0, left: 50, right: 50),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(90),
              //主要用来设置阴影设置
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color(0xffF34545),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  WalletLocalizations.of(context).order_scale + ':  ',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  (_grapModel != null
                      ? _grapModel.earningsRatio.toString() + '%'
                      : ''),
                  style: TextStyle(color: Color(0xffF34545)),
                ),
                InkWell(
                  onTap: () {
                    _showGuide();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Color(0xffF34545),
                        borderRadius: BorderRadius.circular(90)),
                    child: Text(WalletLocalizations.of(context).order_guide,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  /// Delete current user
  void _showGuide() {
    showDialog(
        context: context,
        // barrierDismissible: false,  // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                Text(WalletLocalizations.of(context).order_recharge_guide_tip),
            actions: <Widget>[
              FlatButton(
                child: Text(WalletLocalizations.of(context).publicButtonOK),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void grapOrderInfo() {
    Future future = NetConfig.post(context, NetConfig.grapOrderInfo, {},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        _grapModel = GrapModel(
            grabNumMin: double.parse(data['grabNumMin'].toString()),
            grabNumMax: double.parse(data['grabNumMax'].toString()),
            grapType: data['grapType'],
            balance: double.parse(data['balance'].toString()),
            errorMessage: data['errorMessage'],
            earningsRatio: double.parse(data['earningsRatio'].toString()),
            orderNum:data['orderNum'],
            grapRatioMaxStr: double.parse(data['grapRatioMaxStr'].toString()),
            grapRatioMinStr: double.parse(data['grapRatioMinStr'].toString()));

        isSwitch = data['grapType'];
      }
      setState(() {});
    });
  }

  void startGrap() {
    Tools.loadingAnimation(context);
    Future future = NetConfig.post(context, NetConfig.startGrap, {},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        isSwitch = true;
        Tools.showToast(
            _scaffoldKey, WalletLocalizations.of(context).order_start_grap);
      }
      Navigator.of(context).pop();
      setState(() {});
    });
  }

  void sureGrap(GrapListModel model) {
    Tools.loadingAnimation(context);
    Future future = NetConfig.post(
        context, NetConfig.sureGrap, {'grabOrder': model.grabOrder.toString()},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        grapOrderInfo();
      }
      Navigator.of(context).pop();
      setState(() {});
    });
  }

  Widget errorView() {
    return Expanded(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Tools.imagePath('order_error'),
                  width: 200,
                  height: 200,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    _grapModel.errorMessage.toString(),
                    style: TextStyle(fontSize: 15, color: Color(0xffB4B4B4)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return OrderRecharge();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                        left: 45, right: 45, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF34545),
                        borderRadius: BorderRadius.circular(90)),
                    child: Text(
                        WalletLocalizations.of(context).order_recharge_now,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ));
          }),
    );
  }

  Widget contentView() {
    return _grapModel.orderNum > 0
        ? Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    Tools.imagePath('order_qiang'),
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    WalletLocalizations.of(context).order_have_a_new_open_order,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    _grapModel.orderNum.toString(),
                    style: TextStyle(fontSize: 15, color: Color(0xffF34545)),
                  ),
                  Text(
                    WalletLocalizations.of(context).order_each,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
