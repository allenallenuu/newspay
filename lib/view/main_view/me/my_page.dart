import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// My profile page.
/// [author] tt
/// [time] 2019-3-21

import 'package:flutter/material.dart';
import 'package:qiangdan_app/model/BalanceModel.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/main_view/grab_orders/order_withdraw.dart';
import 'package:qiangdan_app/view/main_view/home/home_notice_view.dart';
import 'package:qiangdan_app/view/main_view/me/user_info_trading_data.dart';
import 'package:qiangdan_app/view/share/share_receive_page.dart';
import 'package:qiangdan_app/view/main_view/me/user_info_center.dart';
import 'package:qiangdan_app/view/main_view/me/user_info_record.dart';
import 'package:qiangdan_app/view/main_view/me/user_info_set.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenterState createState() => _UserCenterState();
}

class _UserCenterState extends State<UserCenter> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    this.getBalanceInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      body: Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          children: <Widget>[topView(), refreshView()],
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              (GlobalInfo.userInfo != null &&
                  GlobalInfo.userInfo.faceUrl != null)
                  ? ClipOval(
                  child: kIsWeb
                      ? WebTools.networkImageWeb(
                    NetConfig.imageHost +
                        GlobalInfo.userInfo.faceUrl,
                    width: 55,
                    height: 55,
                  )
                      : CachedNetworkImage(
                    imageUrl: NetConfig.imageHost +
                        GlobalInfo.userInfo.faceUrl,
                    errorWidget: (context, url, error) =>
                    new Icon(Icons.error),
                    width: 55,
                    height: 55,
                    fit: BoxFit.fitHeight,
                  ))
                  : ClipOval(
                child: Image.asset(
                  Tools.imagePath('my_page_avatar'),
                  fit: BoxFit.fitHeight,
                  height: 42,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                GlobalInfo.userInfo.nickname == null
                    ? 'unknow'
                    : GlobalInfo.userInfo.nickname,
                style: TextStyle(fontSize: 16, color: Color(0xff333333)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Image.asset(
                  Tools.imagePath('my_page_app'),
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(UserInfoSet.tag);

                },
                child: Image.asset(
                  Tools.imagePath('my_page_set'),
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  RefreshController _refreshController;

  void _onRefresh() {
    this.getBalanceInfo(callback: () {
      setState(() {
        _refreshController.refreshCompleted();
      });
    });
  }

  BalanceModel _balanceModel = null;

  void getBalanceInfo({Function callback = null}) {
    Future future =
        NetConfig.post(context, NetConfig.balanceList, {}, timeOut: 10);
    future.then((data) {
      if (NetConfig.checkData(data)) {
        _balanceModel = BalanceModel(
          balance: double.parse(data['balance'].toString()),
          totalBalance: double.parse(data['totalBalance'].toString()),
          frozenBalance: double.parse(data['frozenBalance'].toString()),
          totalProfit: double.parse(data['totalProfit'].toString()),
          id: data['id'],
          uid: data['uid'],
        );
      }
      setState(() {});
      if (callback != null) {
        callback();
      }
    });
  }

  Widget refreshView() {
    return Expanded(
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(
              releaseText:
                  WalletLocalizations.of(context).pull_to_refresh_releaseText,
              refreshingText: WalletLocalizations.of(context)
                  .pull_to_refresh_refreshingText,
              completeText:
                  WalletLocalizations.of(context).pull_to_refresh_completeText,
              idleText:
                  WalletLocalizations.of(context).pull_to_refresh_idleText),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                infoView(),
                Container(
                  color: Color(0xffF6F6F6),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
                HomeNoticeView(),
                menuView(),
                Container(
                  color: Color(0xffF6F6F6),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
                serverMenu(),
              ],
            ),
          )),
    );
  }

  Widget infoView() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 7),
        decoration: BoxDecoration(
          color: Color(0xfff34545),
          borderRadius: BorderRadius.circular(8),
          //主要用来设置阴影设置
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: Color.fromARGB(20, 0, 0, 0),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  WalletLocalizations.of(context).my_page_balance,
                  style: TextStyle(fontSize: 12, color: Color(0xffF3F3F3)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Text(
                  _balanceModel != null && _balanceModel.balance != null
                      ? _balanceModel.balance.toString()
                      : '0.0',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        WalletLocalizations.of(context).my_page_total_profit,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffF3F3F3)),
                      ),
                      AutoSizeText(
                        _balanceModel != null &&
                                _balanceModel.totalProfit != null
                            ? _balanceModel.totalProfit.toString()
                            : '0.0',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 10,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        WalletLocalizations.of(context).my_page_frozen,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffF3F3F3)),
                      ),
                      AutoSizeText(
                        _balanceModel != null &&
                                _balanceModel.frozenBalance != null
                            ? _balanceModel.frozenBalance.toString()
                            : '0.0',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 10,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget menuView() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: <Widget>[
          menuItem('my_page_qiangdan',
              WalletLocalizations.of(context).my_page_menu_qiangdan, onTap: () {
            Tools.showToast(_scaffoldKey, '1');
          }),
          menuItem('my_page_recharge',
              WalletLocalizations.of(context).my_page_menu_recharge, onTap: () {
            Tools.showToast(_scaffoldKey, '2');
          }),
          menuItem('my_page_withdrawal',
              WalletLocalizations.of(context).my_page_menu_withdrawal,
              onTap: () {
            Tools.showToast(_scaffoldKey, '3');
          }),
          menuItem('my_page_record',
              WalletLocalizations.of(context).my_page_menu_record, onTap: () {
//            Tools.showToast(_scaffoldKey, '4');
                Navigator.of(context).pushNamed(UserInfoRecord.tag);

              }),
        ],
      ),
    );
  }

  Widget serverMenu() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                menuItem('my_page_server_income',
                    WalletLocalizations.of(context).my_page_server_income,
                    onTap: () {
//                  Tools.showToast(_scaffoldKey, '1');
                      Navigator.of(context).pushNamed(UserInfoTradingData.tag);

                    }),
                menuItem('my_page_server_agent',
                    WalletLocalizations.of(context).my_page_server_agent,
                    onTap: () {
                  Tools.showToast(_scaffoldKey, '2');
                }),
                menuItem('my_page_server_share',
                    WalletLocalizations.of(context).my_page_server_share,
                    onTap: () {
                  Navigator.of(context).pushNamed(ShareReceivePage.tag);
                }),
                menuItem('my_page_server_wait',
                    WalletLocalizations.of(context).my_page_server_wait,
                    onTap: () {
                  Tools.showToast(_scaffoldKey, '4');
                }),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                menuItem('my_page_server_safe',
                    WalletLocalizations.of(context).my_page_server_safe,
                    onTap: () {
//                  Tools.showToast(_scaffoldKey, '1');
                      Navigator.of(context).pushNamed(UserInfoCenter.tag);
                    }),
                menuItem('my_page_server_about',
                    WalletLocalizations.of(context).my_page_server_about,
                    onTap: () {
                  Tools.showToast(_scaffoldKey, '2');
                }),
                menuItem('my_page_server_download',
                    WalletLocalizations.of(context).my_page_server_download,
                    onTap: () {
                  Tools.showToast(_scaffoldKey, '3');
                }),
                menuItem('my_page_server_wait',
                    WalletLocalizations.of(context).my_page_server_wait,
                    onTap: () {
                  Tools.showToast(_scaffoldKey, '4');
                }),
              ],
            ),
          ],
        ));
  }

  Widget menuItem(String image, String txt, {Function onTap = null}) {
    return Expanded(
        child: InkWell(
      onTap: onTap == null ? () {} : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Tools.imagePath(image),
            width: 30,
            height: 30,
            fit: BoxFit.fill,
          ),
          Text(
            txt,
            style: TextStyle(fontSize: 12, color: Color(0xff333333)),
          ),
        ],
      ),
    ));
  }
}
