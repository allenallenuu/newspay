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
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';
import 'package:qiangdan_app/view_model/home_page_agent_model.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class HomePageManualDetail extends StatefulWidget {
  static String tag = "HomePageManualDetail";
  String imageName;
  String titleName;

  HomePageManualDetail({Key key, this.imageName,this.titleName}) : super(key: key);

  @override
  _HomePageManualDetailState createState() => _HomePageManualDetailState();
}

class _HomePageManualDetailState extends State<HomePageManualDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppCustomColor.themeBackgroudColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.titleName,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width ,
            child: Image.asset(
              Tools.imagePath(widget.imageName),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        )
    );
  }
}
