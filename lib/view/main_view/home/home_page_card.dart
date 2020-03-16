import 'package:flutter/material.dart';

import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/home/home_add_card.dart';
import 'package:wpay_app/view/main_view/home/home_card_list.dart';

class HomePageCard extends StatefulWidget {
  static String tag = "HomePageCard";
  _HomePageCardState createState() => _HomePageCardState();

}

class _HomePageCardState extends State<HomePageCard> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  List<Widget> views = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this);
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
    views.add(new HomeAddCard());
    views.add(new HomeCardList());
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          WalletLocalizations.of(context).homePageManualChannel,
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
      list.add(Text('添加银行卡',style: TextStyle(fontSize: 16.0),));
      list.add(Text('银行卡列表',style: TextStyle(fontSize: 16.0)));
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