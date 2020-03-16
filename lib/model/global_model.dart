

import 'package:wpay_app/model/user_info.dart';
import 'package:wpay_app/tools/key_config.dart';
/**
 * Global data
 */
class  GlobalInfo{

//  static String dataEncodeString= md5.convert(Utf8Encoder().convert('P@ssw)2d!UPRETSCLIENT')).toString();
  static String dataEncodeString= 'P@ssw)2d!UPRETSCLIENT';

  ///当前版本号
  static int currVersionCode = 1;

  static String currLanguage = KeyConfig.languageEn;

  static String selectTheme = KeyConfig.defaultTheme;

  static String currencyUnit = KeyConfig.usd;

  ///
  static String colorTheme = KeyConfig.light;

  /// Is Unlock Successfully
  static bool isUnlockSuccessfully = true;

  /// need auto lock?
  static bool isNeedLock = true;
  /// Check currently status if be locked. - False: not be locked.
  static bool isLocked = false;

  /// Will be lock how many seconds when app enter background. Default is 5 mins.
  static int sleepTime = 5;

  /// userInfo
  static UserInfo userInfo = UserInfo();


  static clear(){
    userInfo = UserInfo();
  }

}
