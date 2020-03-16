import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpay_app/model/grap_model.dart';
import 'package:wpay_app/tools/GlobalEventBus.dart';
import 'package:wpay_app/view/welcome/start_login.dart';
import 'package:wpay_app/view/widgets/notificationCenter.dart';

import '../../../l10n/WalletLocalizations.dart';
import '../../../model/global_model.dart';
import '../../../tools/Tools.dart';
import '../../../tools/app_data_setting.dart';
import '../main_page.dart';
import 'user_info_page.dart';

class UserInfoSet extends StatefulWidget {
  static String tag = "UserInfoSet";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserInfoSetState();
  }
}

class _UserInfoSetState extends State<UserInfoSet> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _bottomNavigationKey,
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        elevation: 0,
        title: Text('设置'),
      ),
      body: SingleChildScrollView(
//          padding: EdgeInsets.only(top: 180),
          child: Column(
        children: _buildMenuList(),
      )),
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

  /// Build menu list
  List<Widget> _buildMenuList() {
    // list tile
    List<Widget> _list = List();

    List<Widget> titleList = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(WalletLocalizations.of(context).common_title_userName,style: TextStyle(fontSize: 16),),

          SizedBox(
            width: 10,
          ),
          Text(GlobalInfo.userInfo.nickname == null
              ? 'unknow'
              : GlobalInfo.userInfo.nickname,style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),),
        ],
      ),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(WalletLocalizations.of(context).common_title_phone,style: TextStyle(fontSize: 16)),
          SizedBox(
            width: 10,
          ),
          Text(GlobalInfo.userInfo.cellphone == null
              ? 'unknow'
              : GlobalInfo.userInfo.cellphone,style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),),
        ],
      ),


          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(WalletLocalizations.of(context).userInfoPageButton,style: TextStyle(fontSize: 16)),
            ],
          ),
    ];


    // Page routes
    List<String> routes = <String>[
      UserInfoPage.tag,
      UserInfoPage.tag,
      '退出当前账户',
      //留言反馈
      //联系我们
      //退出当前账户
    ];

    for (int i = 0; i < titleList.length; i++) {
      _list.add(_menuItem(titleList[i], routes[i]));
      _list.add(Divider(height: 0, indent: 15));
      if(i == 1){
        _list.add(SizedBox(height: 12));

      }
    }

    return _list;
  }

  //
  Widget _menuItem(Widget title, String route) {
    return Ink(
      color: Colors.white,
      child: ListTile(
//         leading: Image.asset(Tools.imagePath(iconName), width: 20, height: 20),
        title: title,

        onTap: () {
          if (route == '退出当前账户') {
            _deleteUser();
          } else {
//            Navigator.of(context).pushNamed(route);
          }
        },
      ),
    );
  }

  /// Delete current user
  void _deleteUser() {
    showDialog(
        context: context,
        // barrierDismissible: false,  // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(WalletLocalizations.of(context).userInfoPageButton),
            content:
            Text(WalletLocalizations.of(context).userInfoPageDeleteMsg),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    WalletLocalizations.of(context).createNewAddress_Cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(WalletLocalizations.of(context).common_btn_confirm),
                onPressed: () {
                  GlobalInfo.clear();

                  Future<SharedPreferences> prefs =
                  SharedPreferences.getInstance();
                  prefs.then((share) {
                    share.clear();
                    GlobalEventBus().event.fire(new StopGrapThreadModel());
                    NotificationCenter.instance.removeNotification('jumpToPage');
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => StartLoginPage()),
                          (route) => route == null,
                    );
                  });
                },
              )
            ],
          );
        });
  }
}
