import 'package:flutter/material.dart';

/**
 * app的颜色配置文件
 */
class AppCustomColor {
  /**
   * 确认按钮
   */
  static Color btnConfirm = Color(0xFF5495E6);

  /**
   * 取消按钮
   */
  static Color btnCancel = Color(0xFFDCDCDC);

  /**
   * 主题前景颜色
   */
  static Color themeFrontColor = Colors.black;

  static Color navBgColor = Color(0xFF191E32);

  /**
   * 主题背景颜色
   */
  static Color themeBackgroudColor = Colors.white;
  static Color themeBackgroudGrayColor = Color(0xffF6F6F6);

  static Color tabbarBackgroudColor = Color.fromRGBO(243, 69, 69, 1);

  /// About Page Banner Area Backgroud Color
  static Color aboutPageBannerBGColor = Colors.blue[50];

  /// font color - grey
  static Color fontGreyColor = Colors.grey[600];

  /// Set theme colors
  static setColors(Brightness brightness) {
    AppCustomColor.themeFrontColor =
        brightness == Brightness.dark ? Colors.grey[50] : Color(0xFF1F253B);

    AppCustomColor.themeBackgroudColor =
        brightness == Brightness.dark ? Colors.black : Colors.grey[50];

    AppCustomColor.aboutPageBannerBGColor =
        brightness == Brightness.dark ? Colors.black45 : Colors.blue[50];

    AppCustomColor.navBgColor =
        brightness == Brightness.dark ? Color(0xFF191E32) : Colors.grey[50];
  }

  ///
  static String fontFamily = 'OpenSansCondensed';
}
