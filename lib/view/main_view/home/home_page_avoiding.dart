import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';

class HomePageAvoiding extends StatefulWidget {
  static String tag = 'HomeAvoiding';

  @override
  HomePageAvoidingState createState() => HomePageAvoidingState();
}

class HomePageAvoidingState extends State<HomePageAvoiding> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(WalletLocalizations.of(context).homePageAgentAvoiding),
        ),
        body:  SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                    '平台政策和会员行为规范 \n •	在抢到单子的过程中，发现收到钱后，在上图的收款单列表里， 核对订单信息，确认收款。但在15-20 分钟之内没有及时确认收款的，系统将禁止抢单至少30分钟，第二次发现禁止一天，第三次发现禁止15天。超过三次而且态度不端正者直接解封合作关系 ！\n•	误点了确认收款必须第一时间向客服反应。客服尽力帮你们找回，做单时一定要保持头脑是清醒状态，不要在疲劳后饮酒后不自控的情况下做单。\n•	付款方任何留言都不要回复！禁止给付款方留言！如有违反，被平台发现，平台将封冻你的所有资金。\n•	最后，祝福大家做单愉快，财源滚滚！'))),);
  }
}
