import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/main_view/home/home_notice_view.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainStateModel stateModel = null;
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
    stateModel = MainStateModel().of(context);
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
          child: GridView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              //Widget Function(BuildContext context, int index)
              return InkWell(
                onTap: () {
                  print(index);
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        alignment: Alignment.center,
                        child: Image.asset(
                          Tools.imagePath(imageList[index]),
                          width: 164,
                          height: 93,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 5.0,
                //子组件宽高长度比例
                childAspectRatio: 1.8),
          ),
        ),
        //通知
        HomeNoticeView(),

        //入门手册
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: GridView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              //Widget Function(BuildContext context, int index)
              return InkWell(
                onTap: () {
                  print(index);
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        alignment: Alignment.center,
                        child: Image.asset(
                          Tools.imagePath(imageList1[index]),
                          width: 164,
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 0.0,
                //横轴间距
                crossAxisSpacing: 0.0,
                //子组件宽高长度比例
                childAspectRatio: 2),
          ),
        ),

//        Container(
//          child: ,
//        )
      ],
    );
  }
}
