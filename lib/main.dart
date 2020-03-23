import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wpay_app/l10n/chinese_local.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/grab_orders/order_match.dart';
import 'package:wpay_app/view/main_view/grab_orders/order_recharge.dart';
import 'package:wpay_app/view/main_view/grab_orders/order_withdraw.dart';
import 'package:wpay_app/view/main_view/home/home_page_agency.dart';
import 'package:wpay_app/view/main_view/home/home_page_agent.dart';
import 'package:wpay_app/view/main_view/home/home_page_agent_detail.dart';
import 'package:wpay_app/view/main_view/home/home_page_card.dart';
import 'package:wpay_app/view/main_view/home/home_page_manual.dart';
import 'package:wpay_app/view/main_view/home/home_page_manual_detail.dart';
import 'package:wpay_app/view/main_view/home/home_page_manual_monad.dart';
import 'package:wpay_app/view/main_view/main_page.dart';
import 'package:wpay_app/view/main_view/me/my_about.dart';
import 'package:wpay_app/view/main_view/me/user_info_center.dart';
import 'package:wpay_app/view/main_view/me/user_info_record.dart';
import 'package:wpay_app/view/main_view/me/user_info_trading_data.dart';
import 'package:wpay_app/view/welcome/change_password.dart';
import 'package:wpay_app/view/welcome/forget_account.dart';
import 'package:wpay_app/view/main_view/me/user_info_set.dart';
import 'package:wpay_app/view/payment_method/payment_method_bankcard_edit.dart';
import 'package:wpay_app/view/welcome/change_password.dart';
import 'package:wpay_app/view/welcome/forget_password.dart';
import 'package:wpay_app/view/welcome/forget_safe_password.dart';
import 'package:wpay_app/view/welcome/register_account.dart';
import 'package:wpay_app/view/welcome/splash.dart';
import 'package:wpay_app/view/main_view/me/user_info_page.dart';
import 'package:wpay_app/view/payment_method/payment_method_bankcard_add.dart';
import 'package:wpay_app/view/share/share_receive_page.dart';
import 'package:wpay_app/view_model/main_model.dart';
import 'package:wpay_app/view_model/state_lib.dart';
import 'package:wpay_app/view/welcome/start_login.dart';

import 'view/main_view/home/home_page_avoiding.dart';
//import 'dart:js' as js;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
//   debugPaintSizeEnabled = true;
  runApp(MyApp());

  //set status bar color
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {
      state.locale = newLocale;
    });
  }

  static void setThemeColor(BuildContext context, Brightness brightness) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {
      state.brightness = brightness;
      AppCustomColor.setColors(brightness);
    });
  }

  /// Restart app when unlock.
// static void restartApp(BuildContext context) {
//   _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
//   state.setState(() {});
// }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Create the model.
  MainStateModel mainStateModel = MainStateModel();

  String log;

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      log = "";
    });
  }

  Locale locale;

  final routes = <String, WidgetBuilder>{
    PaymentMethodBankCardAdd.tag: (context) => PaymentMethodBankCardAdd(),
    PaymentMethodBankCardEdit.tag: (context) => PaymentMethodBankCardEdit(),
    UserInfoPage.tag: (context) => UserInfoPage(),
    MainPage.tag: (context) => MainPage(),
    StartLoginPage.tag: (context) => StartLoginPage(needBack: true),
    ShareReceivePage.tag: (context) => ShareReceivePage(),
    ForgetAccount.tag: (context) => ForgetAccount(),
    UserInfoSet.tag: (context) => UserInfoSet(),
    RegisterPage.tag: (context) => RegisterPage(),
    ForgetPassword.tag: (context) => ForgetPassword(),
    HomePageAgent.tag: (context) => HomePageAgent(),
    HomePageAgentDetail.tag: (context) => HomePageAgentDetail(),
    HomePageManual.tag: (context) => HomePageManual(),
    HomePageManualDetail.tag: (context) => HomePageManualDetail(),
    HomePageManualMonad.tag: (context) => HomePageManualMonad(),
    HomePageCard.tag: (context) => HomePageCard(),
    OrderRecharge.tag: (context) => OrderRecharge(),
    OrderWithdraw.tag: (context) => OrderWithdraw(),
    ChangePassword.tag: (context) => ChangePassword(),
    UserInfoCenter.tag: (context) => UserInfoCenter(),
    UserInfoRecord.tag: (context) => UserInfoRecord(),
    UserInfoTradingData.tag: (context) => UserInfoTradingData(),
    HomePageAgency.tag:(context) =>  HomePageAgency(),
    HomePageAvoiding.tag:(context) => HomePageAvoiding(),
    MyAbout.tag:(context) => MyAbout(),
    OrderMatch.tag:(context) => OrderMatch(),
    ForgetSafePassword.tag:(context) => ForgetSafePassword(),


  };

  Brightness brightness = Brightness.light;

  ///----------------------
  /// App Lifecycle coding for lock and unlock app.

  Timer _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initPlatformState();
    switchPlatForm();
  }

  bool isSharePlatForm = false;

  void switchPlatForm() {
    //webVersion
//    if (kIsWeb) {
//      var uri = Uri.tryParse(js.context['location']['href']);
//      if (uri != null) {
//        if (uri.queryParameters['shareCode'] != null &&
//            uri.queryParameters['shareRato'] != null) {
//          GlobalInfo.userInfo.webShareCode = uri.queryParameters['shareCode'];
//          GlobalInfo.userInfo.webShareRatio = uri.queryParameters['shareRato'];
//          GlobalInfo.userInfo.webPlation = uri.queryParameters['type'];
//          isSharePlatForm = true;
//        } else {
//          GlobalInfo.userInfo.webShareCode = null;
//          GlobalInfo.userInfo.webShareRatio = null;
//          GlobalInfo.userInfo.webPlation = null;
//          isSharePlatForm = false;
//        }
//      }
//    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("==> lifeChanged = $state");
    print("==> lifeChanged -> isLocked = ${GlobalInfo.isLocked}");

    // Enter background.
    if (state == AppLifecycleState.paused) {
      // print("==> paused -> loginToken = ${GlobalInfo.userInfo.loginToken}");
      print("==> paused -> GlobalInfo.isLocked = ${GlobalInfo.isNeedLock}");

      if (GlobalInfo.userInfo.loginToken != null &&
          GlobalInfo.isNeedLock == true) {
        // User has logged in.
        GlobalInfo.isLocked = false;
        print("==> paused -> isLocked = ${GlobalInfo.isLocked}");

        // if (GlobalInfo.fromParent > 10) {
        //   routeObserver.navigator.pop();
        // }

        _timer =
            Timer(Duration(minutes: GlobalInfo.sleepTime), // Default is 5 mins.
                () {
          GlobalInfo.isLocked = true; // will be locked.
          _timer.cancel();
        });
      }
    }

    // Back from background.
    if (state == AppLifecycleState.resumed) {
      // print("==> resumed -> loginToken = ${GlobalInfo.userInfo.loginToken}");

    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///----------------------

  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  ///
  Widget _buildApp() {
    AppCustomColor.setColors(brightness);
    return ScopedModel<MainStateModel>(
      model: mainStateModel,
      child: MaterialApp(
        title: 'wpay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            splashFactory: const NoSplashFactory(),
            highlightColor: Colors.transparent,
            primaryColor: Color(0xFF5495E6),
            brightness: brightness,
            appBarTheme: AppBarTheme(
                elevation: 0,
                color: brightness == Brightness.dark
                    ? Color(0xFF191E32)
                    : Colors.white,
                brightness: brightness,
                textTheme: brightness == Brightness.dark
                    ? TextTheme(
                        title: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal))
                    : TextTheme(
                        title: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                iconTheme: brightness == Brightness.dark
                    ? IconThemeData(color: Colors.white)
                    : IconThemeData(color: Colors.black))),

        //
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (this.locale == null) {
            this.locale = deviceLocale;
          }
//          if (kIsWeb) {
          this.locale = Locale('zh', 'CH');
//          }
          return this.locale;
        },

        // set app language
        locale: this.locale,

        // onGenerateTitle: (context){
        //   return WalletLocalizations.of(context).main_index_title;
        // },

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          WalletLocalizationsDelegate.delegate,
          ChineseCupertinoLocalizations.delegate, // Fix for Flutter Bug
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
          const Locale('zh', ''), // Fix for Flutter Bug
        ],
        routes: routes,
        // home: BackupWalletIndex(),
        navigatorObservers: [routeObserver],
        home: kIsWeb
            ? isSharePlatForm ? RegisterPage() : StartLoginPage()
            : Splash(),
      ),
    );
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  InteractiveInkFeature create({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
    @required Offset position,
    @required Color color,
    TextDirection textDirection,
    bool containedInkWell: false,
    RectCallback rectCallback,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    double radius,
    VoidCallback onRemoved,
  }) {
    return new NoSplash(
      controller: controller,
      referenceBox: referenceBox,
      color: color,
      onRemoved: onRemoved,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
    Color color,
    VoidCallback onRemoved,
  })  : assert(controller != null),
        assert(referenceBox != null),
        super(
            controller: controller,
            referenceBox: referenceBox,
            onRemoved: onRemoved) {
    controller.addInkFeature(this);
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
