import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      backgroundColor: Colors.white,
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
        children: <Widget>[
          Image.asset(
            Tools.imagePath("my_page_set_info"),
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text('1'),
        ],
      ),


      Row(
        children: <Widget>[
          Image.asset(
            Tools.imagePath("my_page_set_quit"),
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text('1'),
        ],
      ),
    ];

    List<Widget> trailingList = <Widget>[
      Icon(Icons.keyboard_arrow_right),
      Icon(Icons.keyboard_arrow_right),
    ];

    // Page routes
    List<String> routes = <String>[
      UserInfoPage.tag,
      '退出当前账户',
      //留言反馈
      //联系我们
      //退出当前账户
    ];

    for (int i = 0; i < titleList.length; i++) {
      _list.add(_menuItem(titleList[i], routes[i], trailingList[i]));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  //
  Widget _menuItem(Widget title, String route, Widget trailing) {
    return Ink(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
//         leading: Image.asset(Tools.imagePath(iconName), width: 20, height: 20),
        title: title,
        trailing: trailing,

        onTap: () {
          if (route == '退出当前账户') {
            _deleteUser();
          } else {
            Navigator.of(context).pushNamed(route);
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
            title: Text('1'),
            content:
                Text('1'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    '1'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('1'),
                onPressed: () {
                  GlobalInfo.clear();

                  Future<SharedPreferences> prefs =
                  SharedPreferences.getInstance();
                  prefs.then((share) {
                    share.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainPage()),
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
