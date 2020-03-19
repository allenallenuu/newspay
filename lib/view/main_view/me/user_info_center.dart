import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/view/welcome/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/WalletLocalizations.dart';
import '../../../model/global_model.dart';
import '../../../tools/Tools.dart';
import '../../../tools/app_data_setting.dart';
import '../main_page.dart';
import 'user_info_page.dart';

class UserInfoCenter extends StatefulWidget {
  static String tag = "UserInfoCenter";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserInfoCenterState();
  }
}

class _UserInfoCenterState extends State<UserInfoCenter> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _bottomNavigationKey,
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).my_page_server_safe),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Ink(
              // nick name
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text(WalletLocalizations.of(context).startPageLoginPassword),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      WalletLocalizations.of(context).startPageForgetPasswordButton,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ChangePassword.tag);
                },
              ),
            ),
            Divider(height: 0, indent: 15),
//            Ink(
//              color: AppCustomColor.themeBackgroudColor,
//              child: ListTile(
//                title: Text(WalletLocalizations.of(context).myPageSingleCard),
//                trailing: Row(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    Text(
//                      '',
//                      style: TextStyle(color: Colors.grey),
//                    ),
//                    SizedBox(width: 15),
//                    Icon(Icons.keyboard_arrow_right),
//                  ],
//                ),
//                onTap: () {
//                  print('抢单银行卡');
////                  Navigator.of(context).pushNamed(RealNameAuthentication.tag);
//                },
//              ),
//            ),
//            Divider(height: 0, indent: 15),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
