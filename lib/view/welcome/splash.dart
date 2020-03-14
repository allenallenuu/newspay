/// Splash page.
/// [author] tt
/// [time] 2019-4-4

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/main.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/model/user_info.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/key_config.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/main_view/main_page.dart';
import 'package:qiangdan_app/view_model/main_model.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';

class Splash extends StatefulWidget {
  static String tag = "Splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double refreshOpacity = 0.0;
  Image image1, imageIcon;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _getSettingsWeb().then((value) => () {
            setState(() {});
          });
    } else {
      Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      prefs.then((share) {
        // check language, currency unit, theme.
        _getSettings(share);
      });
    }

    _timer = Timer(Duration(seconds: 2), () {
      if (kIsWeb) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StartLoginPage()),
          (route) => route == null,
        );
      } else {
        _checkVersion();
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // It will hide status bar and notch.
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
            child: image1 == null || imageIcon == null
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: image1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Align(
                                  alignment: Alignment(0, 0.7),
                                  child: InkWell(
                                    onTap: this._onTouchRefresh(),
                                    child: AnimatedOpacity(
                                      opacity: refreshOpacity,
                                      duration: Duration(milliseconds: 500),
                                      child: Text(
                                        WalletLocalizations.of(context)
                                            .common_tips_refresh,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 150),
                        child: imageIcon,
                      ),
                    ],
                  )));
  }

  _onTouchRefresh() {
    if (this.refreshOpacity == 0) {
      return null;
    } else {
      return () {
        refreshOpacity = 0;
        setState(() {});
      };
    }
  }

  /// Check if has a newer version
  _checkVersion() async {
    // Invoke api.
    var data = await NetConfig.post(context, NetConfig.getNewestVersion, {},
        timeOut: 5, errorCallback: (msg) {
      // No newer version.
    });

    if (NetConfig.checkData(data)) {
      /// Check if has a newer version.
      if (data['code'] > GlobalInfo.currVersionCode && !kIsWeb) {
        showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text(WalletLocalizations.of(context).appVersionTitle),
                  content:
                      Text(WalletLocalizations.of(context).appVersionContent1),
                  actions: _actions(data),
                ),
              );
            });
      } else {
        // Already clicked the 'Later' button, then ignore newer version.
        _processData();
      }
    } else {
      // If has not a newer, continue process data.
      _processData();
    }
  }

  /// Actions for update version
  List<Widget> _actions(data) {
    bool isForce = data['isForce'];
    int code = data['code'];

    List<Widget> btns = [];

    // The version can be ignored.
    if (isForce == false) {
      // Later button
      btns.add(FlatButton(
        child: Text(WalletLocalizations.of(context).appVersionBtn1),
        onPressed: () {
          Navigator.of(context).pop();
          _processData(); // go to next logic
        },
      ));
    }

    // OK button - The version must be upgraded.
    btns.add(FlatButton(
      child: Text(WalletLocalizations.of(context).appVersionBtn2),
      onPressed: () {
        _upgradeNewerVersion(data);
      },
    ));

    return btns;
  }

  /// Upgrade to newer version
  void _upgradeNewerVersion(data) async {
    String path = data['path'];
    // APK install file download url for Android.
    var url = path;

    // Go to App Store for iOS.
    if (Platform.isIOS) {
      //设置跳落地页
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Tools.showToast(_scaffoldKey, 'Could not launch $url');
    }
  }

  ///
  void _processData() async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((share) {
      // Check login status
      String val = share.getString(KeyConfig.user_login_token);

      if (val != null && val != '') {
        GlobalInfo.userInfo.loginToken = val;
        _getUserInfo(share);
      } else {
        // new user or logout (delete id)
        print('==> new user or logout (delete id)');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StartLoginPage()),
          (route) => route == null,
        );
      }
    });
  }

  //
  void _getUserInfo(SharedPreferences share) {
    Future data = NetConfig.post(context, NetConfig.getUserInfo, {},
        errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    // Tools.loadingAnimation(context);
    data.then((data) {
      print("getUserInfo = $data");
      if (NetConfig.checkData(data)) {
        if (data['webUrl'] != null) {
          GlobalInfo.userInfo.webShareAddress = data['webUrl'];
        }

        if (data['appDownUrl '] != null) {
          GlobalInfo.userInfo.appDownloadAddress = data['appDownUrl '];
        }

        if (data['uid'] != null) {
          GlobalInfo.userInfo.uid = data['uid'].toString();
        }

        if (data['faceUrl'] != null) {
          GlobalInfo.userInfo.faceUrl = data['faceUrl'].toString();
        }
        if (data['nickname'] != null) {
          GlobalInfo.userInfo.nickname = data['nickname'].toString();
        }
        if (data['userId'] != null) {
          GlobalInfo.userInfo.userId = data['userid'].toString();
        }
        if (data['cellphone'] != null) {
          GlobalInfo.userInfo.cellphone = data['cellphone'].toString();
        }
        // print('==> GET DATA | ${DateTime.now()}');
        // check if has finished to back up mnimonic.

        Navigator.of(context).pushAndRemoveUntil(
          // remove unlock page
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => route == null,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StartLoginPage()),
          (route) => route == null,
        );
      }
    });
  }

  /// get app settings
  void _getSettings(SharedPreferences share) {
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;
    print('languageCode = $languageCode');

    String setLanguage = share.getString(KeyConfig.set_language);
    String setCurrencyUnit = share.getString(KeyConfig.set_currency_unit);
    String setTheme = share.getString(KeyConfig.set_theme);
    String setThemes = share.getString(KeyConfig.set_themes);

    print('saved setLanguage     = $setLanguage');
    print('saved setCurrencyUnit = $setCurrencyUnit');
    print('saved setTheme        = $setTheme');
    print('saved setThemes        = $setThemes');
    if (setThemes == null) {
      setThemes = KeyConfig.defaultTheme;
    }
    // for language
    if (setLanguage == KeyConfig.languageEn) {
      locale = Locale('en', "US");
    } else if (setLanguage == KeyConfig.languageCn) {
      locale = Locale('zh', "CH");
    } else {
      // No select before
      if (languageCode == 'zh') {
        setLanguage = KeyConfig.languageCn;
      } else if (languageCode == 'en') {
        setLanguage = KeyConfig.languageEn;
      } else {
        setLanguage = KeyConfig.languageCn;
      }
    }

    // for currency unit
    if (setCurrencyUnit == null) {
      if (languageCode == 'zh') {
        setCurrencyUnit = KeyConfig.cny;
      } else if (languageCode == 'en') {
        setCurrencyUnit = KeyConfig.usd;
      } else {
        setCurrencyUnit = KeyConfig.cny;
      }
    }

    // for color theme
    if (setTheme == null) {
      setTheme = KeyConfig.light;
    }
    if (setTheme == KeyConfig.light) {
      MyApp.setThemeColor(context, Brightness.light);
    } else {
      MyApp.setThemeColor(context, Brightness.dark);
    }

    MyApp.setLocale(context, locale);

    image1 = Image.asset(
      Tools.imagePath('splash_bg_black'),
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    imageIcon = Image.asset(
      Tools.imagePath('splash_bg_icon_black'),
    );

    precacheImage(
      image1.image,
      context,
    );
    precacheImage(
      imageIcon.image,
      context,
    );
    setState(() {});
  }

  Future _getSettingsWeb() {
    return Future(() {
      Locale locale = Localizations.localeOf(context);
      locale = Locale('zh', "CH");
      // for color theme
      MyApp.setThemeColor(context, Brightness.light);

      MyApp.setLocale(context, locale);

      image1 = Image.asset(
        Tools.imagePath('splash_bg_black'),
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
      imageIcon = Image.asset(
        Tools.imagePath('splash_bg_icon_black'),
      );

      precacheImage(
        image1.image,
        context,
      );
      precacheImage(
        imageIcon.image,
        context,
      );
    });
  }
}
