import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/WebTools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/home/home_page_agent_detail.dart';
import 'package:wpay_app/view/main_view/home/home_page_manual_detail.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/home_page_agent_model.dart';
import 'package:wpay_app/view_model/state_lib.dart';
import 'package:wpay_app/view/welcome/start_login.dart';

import 'home_page_manual_monad.dart';

class HomePageManual extends StatefulWidget {
  static String tag = "HomePageManual";

  @override
  _HomePageManualState createState() => _HomePageManualState();
}

class _HomePageManualState extends State<HomePageManual> {
  List<String> imageList = [
    "icon_flow",
    "icon_channel",
    "icon_recharge",
    "icon_monad",
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          WalletLocalizations.of(context).homePageManual,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildImage(imageList[0], 0),
              buildImage(imageList[1], 1),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildImage(imageList[2], 2),
              buildImage(imageList[3], 3),
            ],
          )
        ]),
      ),
    );
  }

  Widget buildImage(String imageName, int tag) {
    return InkWell(
      onTap: () {
        if (tag == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return HomePageManualDetail(imageName: 'icon_mannual_flow',titleName:WalletLocalizations.of(context).homePageManualFlow,);
          }));
        } else if (tag == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return HomePageManualDetail(imageName: 'icon_manual_channel',titleName: WalletLocalizations.of(context).homePageManualChannel);
          }));
        } else if (tag == 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return HomePageManualDetail(imageName: 'icon_manual_recharge',titleName: WalletLocalizations.of(context).homePageManualRecharge);
          }));
        } else {
          Navigator.of(context).pushNamed(HomePageManualMonad.tag);

        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 24),
        width: MediaQuery.of(context).size.width / 2.2,
        child: Image.asset(
          Tools.imagePath(imageName),
          width: MediaQuery.of(context).size.width / 2.2,
          height: 93,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
