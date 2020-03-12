import 'package:flutter/cupertino.dart';

/// My profile page.
/// [author] tt
/// [time] 2019-3-21

import 'package:flutter/material.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';

class OrderCenter extends StatefulWidget {
  @override
  _OrderCenterState createState() => _OrderCenterState();
}

class _OrderCenterState extends State<OrderCenter> {
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
      backgroundColor: AppCustomColor.themeBackgroudColor,
      body: Container(
        child: Column(
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
          ],
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
        height: 200.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Tools.imagePath('order_top_bg')),
          ),

        ));
  }
}
