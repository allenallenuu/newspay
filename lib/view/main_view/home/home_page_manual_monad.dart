import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/main_view/home/home_page_agent_detail.dart';
import 'package:qiangdan_app/view/main_view/home/home_page_manual_detail.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';
import 'package:qiangdan_app/view_model/home_page_agent_model.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class HomePageManualMonad extends StatefulWidget {
  static String tag = "HomePageManualMonad";

  @override
  _HomePageManualMonadState createState() => _HomePageManualMonadState();
}

class _HomePageManualMonadState extends State<HomePageManualMonad> {
  List<String> imageList = [
    "icon_manual_flow",
    "icon_course",
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
          WalletLocalizations.of(context).homePageManualSpeedy,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
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
            return HomePageManualDetail(imageName: 'icon_flow_detail',titleName: WalletLocalizations.of(context).homePageManualFlows,);
          }));
        } else if (tag == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return HomePageManualDetail(imageName: 'icon_course_detail',titleName: WalletLocalizations.of(context).homePageManualCourse);
          }));
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 24),
        width: MediaQuery.of(context).size.width / 2.2,
        child: Image.asset(
          Tools.imagePath(imageName),
          width: MediaQuery.of(context).size.width / 2.2,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
