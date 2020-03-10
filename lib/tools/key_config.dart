import 'Tools.dart';

/// Key Config page.
/// [author] tt
/// [time] 2019-4-19

class KeyConfig {
  static final String user_login_token = Tools.convertMD5Str('user.login_token');
  static final String user_login_userId = Tools.convertMD5Str('user.login_suerid');
  static final String backParentId = Tools.convertMD5Str('backParentId');
  static final String set_language = Tools.convertMD5Str('set_language');
  static final String set_currency_unit = Tools.convertMD5Str('set_currency_unit');
  static final String set_theme = Tools.convertMD5Str('set_theme');
  static final String set_themes = Tools.convertMD5Str('set_themes');
  static const String languageEn = 'English';
  static const String languageCn = '简体中文';
  static const String cny = 'CNY';
  static const String usd = 'USD';
  static const String light = 'Light';
  static const String dark = 'Dark';

  static const String defaultTheme = 'defaultTheme';
  static const String blueTheme = 'blueTheme';
  static const String purpleTheme = 'purpleTheme';
}