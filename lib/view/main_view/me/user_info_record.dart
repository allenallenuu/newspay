import 'package:flutter/material.dart';

import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/me/recharge_list_widget.dart';
import 'package:wpay_app/view/main_view/me/withdraw_list_widget.dart';

import 'balance_list_widget.dart';

class UserInfoRecord extends StatefulWidget {
  static String tag = "UserInfoRecord";
  _UserInfoRecordState createState() => _UserInfoRecordState();

}

class _UserInfoRecordState extends State<UserInfoRecord> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  List<Widget> views = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (this._tabController.offset == 0) {
//        this._loadDataFromServer(this._tabController.index);
      }

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    views = [];
    views.add(new RechargeListWidget());
    views.add(new WithdrawListWidget());
    views.add(new BanlanceListWidget());

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          WalletLocalizations.of(context).userInfoRecord
        ),
      ),
      body: Column(
        children: <Widget>[Divider(height: 1, indent: 15),_showExchange(), _quotationList()],
      ),
    );
  }
//切换头文件
  Widget _showExchange() {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(top: 4),
      child: TabBar(
          controller: _tabController,
          labelColor: AppCustomColor.tabbarBackgroudColor,
          indicatorColor:AppCustomColor.tabbarBackgroudColor,
          labelPadding: EdgeInsets.only(bottom: 3),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
          unselectedLabelColor: Colors.grey,
          tabs: this.createTabBarHeader()),
    );
  }

  List<Widget> createTabBarHeader() {
    List<Widget> list = [];
    list.add(Text(WalletLocalizations.of(context).my_page_menu_recharge,style: TextStyle(fontSize: 16.0)));
    list.add(Text(WalletLocalizations.of(context).my_page_menu_withdrawal,style: TextStyle(fontSize: 16.0)));
    list.add(Text(WalletLocalizations.of(context).my_page_menu_balance,style: TextStyle(fontSize: 16.0)));
    return list;
  }
  Widget _quotationList() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: views,
      ),
    );
  }
}