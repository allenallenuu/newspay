import 'package:flutter/material.dart';

import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
class HomeCardList extends StatefulWidget {
  static String tag = "HomeCardList";

  @override
  _HomeCardListState createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppCustomColor.themeBackgroudColor,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width ,
            child: Image.asset(
              Tools.imagePath('icon_flow_detail'),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        )
    );
  }
}
