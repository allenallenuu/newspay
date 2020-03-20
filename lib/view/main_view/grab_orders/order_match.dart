import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/payment_method_info.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/tools/net_config.dart';
import 'package:wpay_app/view/main_view/home/home_edit_card.dart';
import 'package:wpay_app/view/main_view/me/balance_list_widget.dart';
import 'package:wpay_app/view_model/balance_list_model.dart';
import 'package:wpay_app/view_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderMatch extends StatefulWidget {
  static String tag = "OrderMatch";

  @override
  _OrderMatchState createState() => _OrderMatchState();
}

class _OrderMatchState extends State<OrderMatch> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              WalletLocalizations.of(context).order_match
          ),
        ),
        body: BanlanceListWidget());
  }

}
