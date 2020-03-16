import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';

class MyAbout extends StatefulWidget {
  static String tag = 'MyAbout';

  @override
  MyAboutState createState() => MyAboutState();
}

class MyAboutState extends State<MyAbout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        appBar: AppBar(
        centerTitle: true,
        title: Text(WalletLocalizations.of(context).my_page_server_about),
    ),
    body:  SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
                '•	一款可以赚钱的APP，只需要添加银行卡并进行抢单收款，就可以为您产生收益。\n •	钱包金额\n •	余额是指您账户上的现金额，是您充值和收益的总额。\n •	打码量\n •	为了平台正常运转使用，当您充值的时候，平台会按比例增加您的应打码量，您抢单确认成功总额大于充值金额的70%时，您可以提现。\n •	冻结金额\n •	提现的时候，为了防止提现与抢单冲突，会把提现的押金金额暂时冻结起来，剩下的金额可用来抢单;抢单成功时，也会把部分金额放入冻结金额中。\n •	充值\n •	充值到系统提供的对应银行卡账户，审核通过后，会存到您押金中。'
            )
        )
    ));
  }
}