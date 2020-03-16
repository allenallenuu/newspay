import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/WebTools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/home/home_page_agency.dart';
import 'package:wpay_app/view/main_view/home/home_page_agent.dart';
import 'package:wpay_app/view/main_view/home/home_notice_view.dart';
import 'package:wpay_app/view/main_view/home/home_page_avoiding.dart';
import 'package:wpay_app/view/main_view/home/home_page_card.dart';
import 'package:wpay_app/view/main_view/home/home_page_manual.dart';
import 'package:wpay_app/view/share/share_receive_page.dart';
import 'package:wpay_app/view_model/state_lib.dart';
import 'package:wpay_app/view/welcome/start_login.dart';

import 'home_page_manual_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _bannerImageList = [
    "banner_one",
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
        if (tag == 0) {
          Navigator.of(context).pushNamed(HomePageCard.tag);
        } else if (tag == 1) {
          Navigator.of(context).pushNamed(HomePageAgent.tag);
        } else if (tag == 2) {
          Navigator.of(context).pushNamed(HomePageManual.tag);
        } else if (tag == 3) {
          Navigator.of(context).pushNamed(HomePageAvoiding.tag);
        } else if (tag == 4) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return HomePageManualDetail(
              imageName: 'icon_operation',
              titleName: WalletLocalizations.of(context).homePageAgentOperation,
            );
          }));
        } else if (tag == 5) {
          Navigator.of(context).pushNamed(HomePageAgency.tag);
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        child: Image.asset(
          Tools.imagePath(imageName),
          width: (MediaQuery.of(context).size.width - 30) / 2,
          height: ((MediaQuery.of(context).size.width - 30) / 2) / 1.98,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildImageParent(Widget one, Widget two) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            one,
            SizedBox(
              width: 10,
            ),
            two
          ],
        ));
  }

  Widget buildItemes(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2.3,
          child: Swiper(
            itemCount: _bannerImageList.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ShareReceivePage.tag);
                    },
                    child: Image.asset(
                      Tools.imagePath(_bannerImageList[index]),
                      fit: BoxFit.fill,
                    ),
                  ));
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
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                buildImageParent(
                  buildImage(imageList[0], 0),
                  buildImage(imageList[1], 1),
                ),
              ],
            )),

        //通知
        HomeNoticeView(),

        //入门手册
        Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                buildImageParent(
                  buildImage(imageList1[0], 2),
                  buildImage(imageList1[1], 3),
                ),
                SizedBox(height: 10),
                buildImageParent(
                  buildImage(imageList1[2], 4),
                  buildImage(imageList1[3], 5),
                ),
              ],
            )),
      ],
    );
  }
}
