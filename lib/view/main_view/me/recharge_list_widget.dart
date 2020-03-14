import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/payment_method_info.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/tools/net_config.dart';
import 'package:wpay_app/view/main_view/home/home_edit_card.dart';
import 'package:wpay_app/view_model/main_model.dart';
import 'package:wpay_app/view_model/recharge_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class RechargeListWidget extends StatefulWidget {
  static String tag = "RechargeListWidget";

  @override
  _RechargeListWidgetState createState() => _RechargeListWidgetState();
}

class _RechargeListWidgetState extends State<RechargeListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    this.getDataInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  List<recordModel> _recordListModel;

  void getDataInfo({Function callback = null}) {
    Future future =
        NetConfig.post(context, NetConfig.rechargeList, {}, timeOut: 10,errorCallback: (msg) {

      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        print('rechargeList = $data');
        this._recordListModel = [];

        List list = data;
        for (int i = 0; i < list.length; i++) {
          recordModel info = recordModel(
            uid: list[i]['uid'].toString(),
            created: list[i]['created'].toString(),
            num: list[i]['num'].toString(),
            remark: list[i]['remark'].toString(),
            status: list[i]['status'],
          );
          this._recordListModel.add(info);
        }
        setState(() {});
      } else {
        this._recordListModel = [];
        setState(() {});
      }
      if (callback != null) {
        callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_recordListModel == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_recordListModel.length == 0) {
      return Center(
          child: GestureDetector(
              onTap: () {
                this.getDataInfo();
              },
              child: Text(WalletLocalizations.of(context)
                  .common_tips_no_data_refresh)));
    }
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        body: refreshView());
  }

  RefreshController _refreshController;

  void _onRefresh() {
    this.getDataInfo(callback: () {
      setState(() {
        _refreshController.refreshCompleted();
      });
    });
  }

  Widget refreshView() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
          releaseText:
              WalletLocalizations.of(context).pull_to_refresh_releaseText,
          refreshingText:
              WalletLocalizations.of(context).pull_to_refresh_refreshingText,
          completeText:
              WalletLocalizations.of(context).pull_to_refresh_completeText,
          idleText: WalletLocalizations.of(context).pull_to_refresh_idleText),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
          itemCount: _recordListModel.length,
          itemBuilder: (BuildContext context, int index) {
            recordModel dataInfo = _recordListModel[index];
            return Container(
                margin: EdgeInsets.only(top: 10),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1)),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    elevation: 1.6,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 30,
                              child: Text('',style: TextStyle(fontSize: 14,color: Color.fromRGBO(153, 153, 153, 1)),),
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                dataInfo.status == 0
                                    ? WalletLocalizations.of(context).my_page_menu_handleing
                                    : (dataInfo.status == 1 ? WalletLocalizations.of(context).my_page_menu_success : WalletLocalizations.of(context).my_page_menu_failure),
                                style: TextStyle(
                                    color: dataInfo.status == 0
                                        ? Color.fromRGBO(253, 143, 45, 1)
                                        : (dataInfo.status == 1
                                            ? Color.fromRGBO(153, 153, 153, 1)
                                            : Colors.red),
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Divider(height: 0, indent: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: AutoSizeText(
                                      dataInfo.remark,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.bold),
                                      minFontSize: 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10,top: 8),

                                    child: AutoSizeText(
                                      dataInfo.created,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(153, 153, 153, 1)),
                                      minFontSize: 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                            Expanded(
                              child: Container(
                                height: 60,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 10),
                                child: Text( '+ ￥' + dataInfo.num.toString(),style: TextStyle(color: Color.fromRGBO(253, 143, 45, 1),fontSize: 18),),
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                  ),
                ));
          }),
    );
  }
}
