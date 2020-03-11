import 'package:flutter/material.dart';

class WalletLocalizations {
  final Locale locale;

  WalletLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'zh': {
      'network_error': '请检查网络',
      'network_time_out_error': '超时，请检查网络',
      'common_tips_refresh': '刷新',
      'appVersionTitle': '新版本',
      'appVersionContent1': '有新的版本了，更新吧',
      'appVersionBtn1': '以后再说',
      'appVersionBtn2': '好的',
      'appVersionNoNewerVersion': '已经是最新的版本',

      'startPagePhoneInput': '用户名或手机号',
      'startPagePhoneInputs': '请输入手机号',
      'startPagePasswordInput': '请输入密码',
      'startPageNewPasswordInput': '请再次输入密码',
      'startPageNoEqual': '输入密码不一致',
      'startPageInviteCode': '请输入邀请码',

      'startPageRegisterAndLogin': '注册并登陆',
      'startPageForgetAccount': '忘记用户名',
      'startPageSearchAccount': '找回用户名',

      'startPageForgetPassword': '忘记密码?',
      'startPageRegistedUser': '注册用户',
      'startPageCodeInput': '请输入验证码',
      'startPageSendCode': '获取验证码',
      'startPageSendCodeRetry': '重新发送',
      'startPagePhoneLogin': '登录',
      'startPagePhoneError1': '手机号不能为空',
      'startPagePhoneError2': '请输入正确的手机号',
      'startPageCodeError': '请输入正确的验证码',
      'startPagePwdError': '请输入密码',
      'startPageUserInfoError': '用户信息获取失败',
      'welcomePageTwoButtonBack': '返回',
      'startPageChangePasswordButton': '修改密码',
      'startPageRegister': '注册',
      'homePage': '首页',
      'singlePage': '抢单',
      'minePage': '我的',

    },
    'en': {
      'network_error': 'Please check the network',
      'network_time_out_error': 'Timeout, please check the network',
      'common_tips_refresh': 'Refresh',
      'appVersionTitle': 'New Version',
      'appVersionContent1': 'A new version is available, update it',
      'appVersionBtn1': 'Speak later',
      'appVersionBtn2': 'OK',
      'appVersionNoNewerVersion': 'Already the latest version',
      'startPageRegistedUser': 'Registered',

      'startPagePhoneInput': 'Please enter a phone number or account',
      'startPagePhoneInputs': 'Please enter a phone number',

      'startPagePasswordInput': 'Please enter a password',
      'startPageNewPasswordInput': 'Please again enter a password',
      'startPageNoEqual': 'Enter the password inconsistently',
      'startPageRegisterAndLogin': 'Register',
      'startPageInviteCode': 'Please enter a inviteCode',
      'startPageForgetAccount': 'Forget account',
      'startPageSearchAccount': 'Search account',

      'startPageForgetPassword': 'Forgot your password?',
      'startPageCodeInput': 'Please enter a verification code',
      'startPageSendCode': 'Get Verification Code',
      'startPageSendCodeRetry': 'Resend',
      'startPagePhoneLogin': 'Login',
      'startPagePhoneError1': 'Phone number cannot be empty',
      'startPagePhoneError2': 'Please enter the correct phone number',
      'startPageCodeError': 'Please enter a verification code',
      'startPagePwdError': 'Please enter a password',
      'startPageUserInfoError': 'Failed to get user information',
      'welcomePageTwoButtonBack': 'Return',
      'startPageChangePasswordButton': 'Change',
      'startPageRegister': 'Register',
      'homePage': 'Home',
      'singlePage': 'Single',
      'minePage': 'Mine',
    }
  };

// flash pay Payment Method page
  get network_error => _localizedValues[locale.languageCode]['network_error'];

  get network_time_out_error =>
      _localizedValues[locale.languageCode]['network_time_out_error'];

  get common_tips_refresh =>
      _localizedValues[locale.languageCode]['common_tips_refresh'];

  get appVersionTitle =>
      _localizedValues[locale.languageCode]['appVersionTitle'];

  get appVersionContent1 =>
      _localizedValues[locale.languageCode]['appVersionContent1'];

  get appVersionBtn1 => _localizedValues[locale.languageCode]['appVersionBtn1'];

  get appVersionBtn2 => _localizedValues[locale.languageCode]['appVersionBtn2'];

  get appVersionNoNewerVersion =>
      _localizedValues[locale.languageCode]['appVersionNoNewerVersion'];

  get startPagePhoneInput =>
      _localizedValues[locale.languageCode]['startPagePhoneInput'];
  get startPagePhoneInputs =>
      _localizedValues[locale.languageCode]['startPagePhoneInputs'];
  get startPageRegistedUser =>
      _localizedValues[locale.languageCode]['startPageRegistedUser'];
  get startPagePasswordInput =>
      _localizedValues[locale.languageCode]['startPagePasswordInput'];
  get startPageNewPasswordInput =>
      _localizedValues[locale.languageCode]['startPageNewPasswordInput'];
  get startPageNoEqual =>
      _localizedValues[locale.languageCode]['startPageNoEqual'];
  get startPageInviteCode =>
      _localizedValues[locale.languageCode]['startPageInviteCode'];

  get startPageRegisterAndLogin =>
      _localizedValues[locale.languageCode]['startPageRegisterAndLogin'];
  get startPageForgetAccount =>
      _localizedValues[locale.languageCode]['startPageForgetAccount'];
  get startPageSearchAccount =>
      _localizedValues[locale.languageCode]['startPageSearchAccount'];
  get startPageForgetPassword =>
      _localizedValues[locale.languageCode]['startPageForgetPassword'];

  get startPageCodeInput =>
      _localizedValues[locale.languageCode]['startPageCodeInput'];

  get startPageSendCode =>
      _localizedValues[locale.languageCode]['startPageSendCode'];

  get startPageSendCodeRetry =>
      _localizedValues[locale.languageCode]['startPageSendCodeRetry'];

  get startPagePhoneLogin =>
      _localizedValues[locale.languageCode]['startPagePhoneLogin'];

  get startPagePhoneError1 =>
      _localizedValues[locale.languageCode]['startPagePhoneError1'];

  get startPagePhoneError2 =>
      _localizedValues[locale.languageCode]['startPagePhoneError2'];

  get startPageCodeError =>
      _localizedValues[locale.languageCode]['startPageCodeError'];

  get startPagePwdError =>
      _localizedValues[locale.languageCode]['startPagePwdError'];

  get startPageUserInfoError =>
      _localizedValues[locale.languageCode]['startPageUserInfoError'];
  get welcomePageTwoButtonBack =>
      _localizedValues[locale.languageCode]['welcomePageTwoButtonBack'];

  get startPageChangePasswordButton =>
      _localizedValues[locale.languageCode]['startPageChangePasswordButton'];

  get startPageRegister =>
      _localizedValues[locale.languageCode]['startPageRegister'];
  get homePage =>
      _localizedValues[locale.languageCode]['homePage'];
  get singlePage =>
      _localizedValues[locale.languageCode]['singlePage'];
  get minePage =>
      _localizedValues[locale.languageCode]['minePage'];

  static WalletLocalizations of(BuildContext context) {
    return Localizations.of(context, WalletLocalizations);
  }
}