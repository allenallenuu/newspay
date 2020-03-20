import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';

class HomePageAgency extends StatefulWidget {
  static String tag = 'HomePageAgency';

  @override
  HomePageAgencyState createState() => HomePageAgencyState();
}

class HomePageAgencyState extends State<HomePageAgency> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(WalletLocalizations.of(context).homePageAgentAgency),
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  '•	直接收益：\n\n平台设置了代理模式，当你抢单成功时，你会根据自己的代理比例获得相应的代理收益，代理收益会直接实时到账，进入你的现余额；\n\n•	直推收益：\n\n分享好友，创建自己的团队，也可以从自己的团队中获得更多的收益。分享时设置的下级比例为下级抢单成功时获取的代理收益比例，（你的代理比例—下级的代理比例）*下级抢单的金额即为下级为你赚取的收益；\n\n•	团队收益：\n\n扩大团队可获得更多的团队收益。\n'))),
    );
  }
}
