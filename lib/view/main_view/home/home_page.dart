import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/main_view/home/home_page_agent.dart';
import 'package:qiangdan_app/view/main_view/home/home_notice_view.dart';
import 'package:qiangdan_app/view/main_view/home/home_page_manual.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _bannerImageList = [
    "banner_one",
    "banner_two",
    "banner_three",
  ];

  List<String> imageList = [
    "home_card",
    "home_daili",
  ];
  List<String> imageList1 = [
    "home_manual",
    "home_minefields",
    "home_operation",
    "home_money",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          WalletLocalizations.of(context).homePage,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppCustomColor.themeBackgroudColor,
        ),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  decoration: BoxDecoration(
                    color: AppCustomColor.themeBackgroudColor,
                  ),
                  child: buildItemes(context));
            }),
      ),
    );
  }

  Widget buildImage(String imageName, int tag) {
    return InkWell(
      onTap: () {
        if(tag == 0){
        }else if (tag == 1) {
          Navigator.of(context).pushNamed(HomePageAgent.tag);
        }else if(tag == 2){
          Navigator.of(context).pushNamed(HomePageManual.tag);

        }else if(tag == 3){

        }else if(tag == 4){

        }else if(tag == 5){

        }else if(tag == 6){

        }
      },
      child: Container(
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

  Widget buildItemes(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 135.0,
          child: Swiper(
            itemCount: _bannerImageList.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  child: Image.asset(Tools.imagePath(_bannerImageList[index]),
                      fit: BoxFit.cover));
            },
            autoplay: true,
            autoplayDelay: 3000,
            autoplayDisableOnInteraction: true,
            duration: 600,
            viewportFraction: 0.95,
            scale: 0.9,
            onTap: (int index) {
              print("index-----$index");
            },
          ),
        ),
        //银行卡和代理模式
        Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.symmetric( horizontal: 10),
            padding: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildImage(imageList[0], 0),
                buildImage(imageList[1], 1),
              ],
            )),
        //通知
        HomeNoticeView(),

        //入门手册
        Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: EdgeInsets.symmetric( horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildImage(imageList1[0], 2),
                    buildImage(imageList1[1], 3),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildImage(imageList1[2], 4),
                    buildImage(imageList1[3], 5),
                  ],
                )
              ],
            )
        ),

//        Container(
//          child: ,
//        )
      ],
    );
  }
}
