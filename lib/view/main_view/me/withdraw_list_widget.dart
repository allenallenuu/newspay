import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/payment_method_info.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/main_view/home/home_edit_card.dart';
import 'package:qiangdan_app/view_model/main_model.dart';
import 'package:qiangdan_app/view_model/withdraw_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class WithdrawListWidget extends StatefulWidget {
  static String tag = "WithdrawListWidget";

  @override
  _WithdrawListWidgetState createState() => _WithdrawListWidgetState();
}

class _WithdrawListWidgetState extends State<WithdrawListWidget> {
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

  List<withdrawModel> _withdrawListModel;


  void getDataInfo({Function callback = null}) {
    Future future =
    NetConfig.post(context, NetConfig.withdrawList, {}, timeOut: 10);
    future.then((data) {
      if (NetConfig.checkData(data)) {
        print('withdrawList = $data');
        this._withdrawListModel = [];

        List list = data;
        for (int i = 0; i < list.length; i++) {
          withdrawModel info = withdrawModel(
            uid: list[i]['uid'].toString(),
            created: list[i]['created'].toString(),
            withdrawCoin: list[i]['withdrawCoin'].toString(),
            remark: list[i]['remark'].toString(),
            status: list[i]['amount'],

          );
          this._withdrawListModel.add(info);
        }
        setState(() {});
      } else {
        this._withdrawListModel = [];
        setState(() {});
      }
      if (callback != null) {
        callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_withdrawListModel == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_withdrawListModel.length == 0) {
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
          itemCount: _withdrawListModel.length,
          itemBuilder: (BuildContext context, int index) {
            withdrawModel dataInfo = _withdrawListModel[index];
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
                              child: Text('订单编号',style: TextStyle(fontSize: 14,color: Color.fromRGBO(153, 153, 153, 1)),),
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                dataInfo.status == 0
                                    ? '处理中'
                                    : (dataInfo.status == 1 ? '提现失败' : (dataInfo.status == 2 ? '取消提现' : '提现成功')),
                                style: TextStyle(
                                    color: dataInfo.status == 0
                                        ? Color.fromRGBO(253, 143, 45, 1)
                                        : (dataInfo.status == 1
                                        ? Colors.red : Color.fromRGBO(153, 153, 153, 1)
                                        ),
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
                                child: Text( '- ￥' + dataInfo.withdrawCoin.toString(),style: TextStyle(color: Colors.black,fontSize: 18),),
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
