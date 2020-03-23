//import 'dart:html';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/grap_model.dart';
import 'package:wpay_app/tools/JpushMessageModel.dart';
import 'package:wpay_app/tools/JpushTools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/grab_orders/order.dart';
import 'package:wpay_app/view/main_view/home/home_page.dart';
import 'package:wpay_app/view/main_view/me/my_page.dart';
import 'package:wpay_app/view/widgets/notificationCenter.dart';
import 'package:wpay_app/view_model/state_lib.dart';
import 'package:wpay_app/tools/GlobalEventBus.dart';

class MainPage extends StatefulWidget {
  static String tag = 'MainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  Brightness brightness;

  List<Widget> pages = List();

  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();

    JpushToolsInstance();

    GlobalEventBus()
        .event
        .on<JpushMessageModel>()
        .listen((JpushMessageModel data) => showTip(data));

    //添加监听者
    NotificationCenter.instance.addObserver(NotificationCenter.eventJumpToPage, (object){
      setState(() {
        _currentIndex = 1;
      });
      _controller.jumpToPage(_currentIndex);
    });
    pages..add(HomePage())..add(OrderCenter())..add(UserCenter());
  }

  void showTip(JpushMessageModel type) {
    if (type != null) {
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.brightness = Theme.of(context).brightness;
    AppCustomColor.themeFrontColor =
        this.brightness == Brightness.dark ? Colors.white : Colors.black;
    AppCustomColor.themeBackgroudColor =
        this.brightness == Brightness.dark ? Colors.black : Colors.white;

    var navList = [
      BottomNavigationBarItem(
          icon: Image.asset(
            Tools.imagePath('ic_home_unselect'),
            width: 24,
            height: 24,
          ),
          activeIcon: Image.asset(
            Tools.imagePath('ic_home_select'),
            width: 24,
            height: 24,
          ),
          title: Text(
            WalletLocalizations.of(context).homePage,
          )),
      BottomNavigationBarItem(
          icon: Stack(
            children: <Widget>[
              Image.asset(
                Tools.imagePath('ic_single_unselect'),
                width: 24,
                height: 24,
              ),
              JpushToolsInstance().sellType
                  ? Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.topRight,
                      child: Badge(
                        badgeColor: Colors.red,
                        shape: BadgeShape.circle,
                        toAnimate: false,
                      ),
                    )
                  : Container(
                      width: 24,
                      height: 24,
                    ),
            ],
          ),
          activeIcon: Stack(
            children: <Widget>[
              Image.asset(
                Tools.imagePath('ic_single_select'),
                width: 24,
                height: 24,
              ),
              JpushToolsInstance().sellType
                  ? Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.topRight,
                      child: Badge(
                        badgeColor: Colors.red,
                        shape: BadgeShape.circle,
                        toAnimate: false,
                      ),
                    )
                  : Container(
                      width: 24,
                      height: 24,
                    ),
            ],
          ),
          title: Text(
            WalletLocalizations.of(context).singlePage,
          )),
      BottomNavigationBarItem(
          icon: Image.asset(
            Tools.imagePath('ic_mine_unselect'),
            width: 24,
            height: 24,
          ),
          activeIcon: Image.asset(
            Tools.imagePath('ic_mine_select'),
            width: 24,
            height: 24,
          ),
          title: Text(
            WalletLocalizations.of(context).minePage,
          )),
    ];
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navList,
        currentIndex: _currentIndex,
        backgroundColor: AppCustomColor.navBgColor,
        fixedColor: AppCustomColor.themeFrontColor,
        onTap: (int index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
