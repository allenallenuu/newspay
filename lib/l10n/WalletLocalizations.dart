import 'package:flutter/material.dart';

class WalletLocalizations {
  final Locale locale;

  WalletLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'zh': {
      'network_error': '请检查网络',
      'network_time_out_error': '超时，请检查网络',
      'common_tips_refresh': '刷新',
      'common_tips_no_data_refresh': '没有数据，刷新',
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
      'startPageForgetPasswordButton': '修改密码',
      'startPageOriginalPassInputs': '请输入原密码',
      'startPageLoginPassword': '登录密码',
      'startPageRegister': '注册',
      'homePage': '首页',
      'homePageManual': '入门手册',
      'homePageManualFlow': '使用流程',
      'homePageManualChannel': '收款渠道',
      'homePageManualRecharge': '充值提现',
      'homePageManualSpeedy': '便捷抢单',
      'homePageManualFlows': '抢单流程',
      'homePageManualCourse': '抢单教程',
      'homePageAgent': '代理模式',
      'homePageAgentOperation': '代理操作',
      'homePageAgentAvoiding': '规避雷区',
      'homePageAgentAgency': '代理奖励',
      'sellcoinTotalAssets': '代理总收益',
      'homePageAgentNums': '代理总个数',
      'homePageAgentRatio': '我的比例',
      'homePageAgentSubordinate': '我的下级',
      'homePageAgentDetail': '查看详情',
      'homePageAgentChangeRatio': '修改他的比例',
      'homePageAgentInputRatio': '请输入修改比例',
      'publicDefaultName': '匿名',
      'myPageSingleCard': '抢单银行卡',
      'homeEditCard': '银行卡修改',
      'homeCardName': '持卡人',
      'homeCardNameTip': '请输入持卡人信息',
      'homeCardNums': '银行卡号',
      'homeCardNumsTip': '请输入银行卡号',
      'homeCardTypes': '卡类型',
      'homeCardTypesTip': '请输入开户行',
      'publicButtonOK': '确定',
      'homeCard': '银行卡',
      'singlePage': '抢单',
      'minePage': '我的',
      'pull_to_refresh_releaseText': '释放时刷新',
      'pull_to_refresh_refreshingText': '正在刷新...',
      'pull_to_refresh_completeText': '刷新完成',
      'pull_to_refresh_idleText': '下拉刷新',
      'my_page_balance': '账户余额',
      'my_page_total_profit': '总收益',
      'my_page_frozen': '冻结余额',
      'my_page_menu_qiangdan': '抢单',
      'my_page_menu_recharge': '充值',
      'my_page_menu_withdrawal': '提现',
      'my_page_menu_balance': '金额变动',
      'my_page_menu_orderNums': '订单编号:  ',
      'my_page_menu_handleing': '处理中',
      'my_page_menu_success': '成功',
      'my_page_menu_failure': '失败',
      'my_page_menu_cancel': '取消提现',
      'my_page_menu_record': '记录',
      'my_page_server_about': '关于我们',
      'my_page_server_agent': '我的代理',
      'my_page_server_download': '下载app',
      'my_page_server_income': '订单详情',
      'my_page_server_service': '在线客服',
      'my_page_server_help': '帮助中心',
      'my_page_server_safe': '安全中心',
      'my_page_server_share': '分享',
      'my_page_server_wait': '敬请期待',
      'userInfoPageButton': '退出当前身份',
      'userInfoPageDeleteMsg': '',
      "createNewAddress_Cancel": "取消",
      'common_btn_confirm': '确定',
      'common_title_userName': '用户名',
      'common_title_phone': '手机号',
      'order_grap_ai': 'AI匹配',
      'order_grap_check':'查看',
      'order_total_balance': '总额',
      'order_index': '指数',
      'order_amount': '抢单额度',
      'order_scale': '我的比例',
      'order_guide': '抢单攻略',
      'order_error_balance_no_enough': '您的余额不足，请先充值',
      'order_recharge_now': '马上充值',
      "order_have_a_new_open_order": '您有已匹配订单',
      'order_sure_order': '确认订单',
      'order_each': '个',
      'order_order': '订单',
      'order_bankcard': '银行卡',
      'order_start_grap': '开始抢单',
      'order_graping': '正在抢单...',
      'order_recharge_payee_name': '收款方户名',
      'order_recharge_payee_account': '收款方账号',
      'order_recharge_payee_bank': '开户行',
      'order_recharge_copy': '一键复制',
      'order_recharge_amount': '充值金额',
      'order_recharge_my_bank': '银行',
      'order_recharge_my_name': '户名',
      'order_recharge_my_card': '卡号',
      'order_recharge_submit': '提交',
      'order_recharge_input_bank': '请输入银行卡',
      'order_recharge_input_name': '请输入真是姓名',
      'order_recharge_input_card': '请输入银行卡后四位',
      'order_recharge_input_amount': '请输入充值金额',
      'order_recharge_tips_copy': '复制成功',
      'order_recharge_guide_tip':
          '1、充值金额越多，抢单金额越大，抢单成功率更高；\n 2、成功收款后请及时确认订单，认准对应收款账号和金额； \n 3、若长时间无订单或收款无效，请及时更换收款账号，规避风控； \n 4、请勿相信任何非官方人员言辞，提高防骗意识，如有问题请及时联系我们。',
      'withdraw_balance': '钱包总额',
      'withdraw_amount': '提现金额',
      'withdraw_input_card': '请输入银行卡号',
      'share_code': '我的邀请码',
      'share_rate': '设置比例',
      'share_range': '范围',
      'share_rate_unit': '比例',
      'share_range_inout_error': '请输入范围内的值',
      'share_agent_rate': '设置下级比例',
      'share_copy': '复制链接',
      'order_each': '个',
      'order_order': '订单',
      'order_bankcard': '银行卡',
      'order_start_grap': '开始抢单',
      'order_graping': '正在抢单...',
      'order_stop_grap': '未开始抢单...',
      'userInfoRecord': '记录',
      'order_order_detail': '订单详情',
      'order_order_grap': '应打码量',
      'order_order_hasGrap': '已打码量',
      'order_order_frozenBalance': '冻结金额',
      'order_order_totalProfit': '代理收益',
      'order_order_total': '订单总数',
      'order_order_success': '订单成功数',
      'order_order_fail': '订单异常数',
      'order_order_successRate': '订单确认成功率',
    },
    'en': {
      'userInfoPageButton': 'Quit current identity',
      'userInfoPageDeleteMsg': '',
      "createNewAddress_Cancel": "Cancel",
      'common_btn_confirm': 'OK',
      'network_error': 'Please check the network',
      'network_time_out_error': 'Timeout, please check the network',
      'common_tips_refresh': 'Refresh',
      'common_tips_no_data_refresh': 'No Data,Refresh',
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
      'startPageForgetPasswordButton': 'Change',
      'startPageOriginalPassInputs': 'Please enter original password',
      'startPageLoginPassword': 'Login Password',
      'startPageRegister': 'Register',
      'homePage': 'Home',
      'homePageAgent': 'Agent',
      'singlePage': 'Single',
      'minePage': 'Mine',
      'sellcoinTotalAssets': 'Total Assets',
      'homePageAgentNums': 'number of agents',
      'homePageAgentRatio': 'Ratio',
      'homePageAgentSubordinate': 'Subordinate',
      'homePageAgentDetail': 'Detail',
      'homePageAgentChangeRatio': 'Change Ratio',
      'homePageAgentInputRatio': 'Please enter Ratio',
      'homePageAgentOperation': 'Operation',
      'homePageAgentAvoiding': 'Avoiding',
      'homePageAgentAgency': 'Agency',
      'pull_to_refresh_releaseText': 'Refresh on release',
      'pull_to_refresh_refreshingText': 'Refreshing ...',
      'pull_to_refresh_completeText': 'Refresh completed',
      'pull_to_refresh_idleText': 'Pull down refresh',
      'my_page_balance': 'Balance',
      'my_page_total_profit': 'TotalProfit',
      'my_page_frozen': 'Frozen',
      'my_page_menu_qiangdan': 'Order',
      'my_page_menu_recharge': 'Recharge',
      'my_page_menu_withdrawal': 'Withdrawal',
      'my_page_menu_record': 'Record',
      'my_page_menu_balance': 'Balance',
      'my_page_menu_orderNums': 'OrderNums:  ',
      'my_page_menu_handleing': 'Dealing',
      'my_page_menu_success': 'Success',
      'my_page_menu_failure': 'Failure',
      'my_page_menu_cancel': 'Cancel',
      'my_page_server_about': 'About us',
      'my_page_server_agent': 'Agent',
      'my_page_server_download': 'Download app',
      'my_page_server_income': 'Order',
      'my_page_server_service': 'Customer',
      'my_page_server_help': 'Help',
      'my_page_server_safe': 'Safety center',
      'my_page_server_share': 'Share',
      'my_page_server_wait': 'Soon',
      'homePageManual': 'Manual',
      'homePageManualFlow': 'Flow',
      'homePageManualChannel': 'Channel',
      'homePageManualRecharge': 'Recharge',
      'homePageManualSpeedy': 'Speedy Manual',
      'homePageManualFlows': 'Manual Flow',
      'homePageManualCourse': 'Course',
      'homeCard': 'Card',
      'homeEditCard': 'bank card modification',
      'homeCardName': 'cardholder',
      'homeCardNameTip': 'please enter cardholder information',
      'homeCardNums': ' bank card number ',
      'homeCardNumsTip': 'please enter the bank card number',
      'homeCardTypes': ' card type ',
      'homeCardTypesTip': 'please enter account bank',
      'publicButtonOK': 'OK',
      'publicDefaultName': 'Anonymous',
      'myPageSingleCard': 'Card',
      'common_title_userName': 'Name',
      'common_title_phone': 'Phone',
      'order_grap_ai': 'AI match',
      'order_grap_check':'Check',
      'order_total_balance': 'Total',
      'order_index': 'Index',
      'order_amount': 'Grab orders',
      'order_scale': 'My scale',
      'order_guide': 'Grab a single strategy',
      'order_error_balance_no_enough':
          'Your balance is insufficient, please recharge first',
      'order_recharge_now': 'Recharge now',
      "order_have_a_new_open_order": 'You have a new unconfirmed order',
      'order_sure_order': 'Confirm order',
      'order_each': 'Each',
      'order_order': 'Order',
      'order_bankcard': 'Bank card',
      'order_start_grap': 'Start grap',
      'order_graping': 'Graping...',
      'order_stop_grap': 'No graping...',
      'order_recharge_payee_name': 'Payee_name',
      'order_recharge_payee_account': 'Payee_account',
      'order_recharge_payee_bank': 'Payee_bank',
      'order_recharge_copy': 'Copy',
      'order_recharge_amount': 'Amount',
      'order_recharge_my_bank': 'Bank',
      'order_recharge_my_name': 'Account',
      'order_recharge_my_card': 'Card',
      'order_recharge_submit': 'Submit',
      'order_recharge_input_bank': 'Please enter the bank card',
      'order_recharge_input_name': 'Please enter a real name',
      'order_recharge_input_card':
          'Please enter the last four digits of the bank card',
      'order_recharge_input_amount': 'Please enter the recharge',
      'order_recharge_tips_copy': 'Copy success',
      'order_recharge_guide_tip':
          '1. The more the recharge amount is, the more the amount of order grabbing is, the higher the success rate of order grabbing is;\n2. After the successful collection, please confirm the order in time and identify the corresponding collection account number and amount;\n 3. If there is no order for a long time or the collection is invalid, please change the collection account number in time to avoid risk control; 4. Please do not believe the words of any unofficial personnel and improve the awareness of fraud prevention. If there is any problem, please contact us in time.',
      'withdraw_balance': 'Wallet total',
      'withdraw_amount': 'Withdrawal Amount',
      'withdraw_input_card': 'Please enter your bank card number',
      'share_code': 'My invitation code',
      'share_rate': 'Set rate',
      'share_range': 'Range',
      'share_rate_unit': 'Rate',
      'share_range_inout_error': 'Please enter a value within the range',
      'share_agent_rate': 'set child proportion',
      'share_copy': 'Copy link',
      'order_each': 'Each',
      'order_order': 'Order',
      'order_bankcard': 'Bank card',
      'order_start_grap': 'Start grap',
      'userInfoRecord': 'Record',
      'order_order_detail': 'Order Detail',
      'order_order_grap': 'Grap',
      'order_order_hasGrap': 'HasGrap',
      'order_order_frozenBalance': 'FrozenBalance',
      'order_order_totalProfit': 'TotalProfit',
      'order_order_total': 'Total',
      'order_order_success': 'Success',
      'order_order_fail': 'Fail',
      'order_order_successRate': 'SuccessRate',
    }
  };

// flash pay Payment Method page
  get network_error => _localizedValues[locale.languageCode]['network_error'];

  get network_time_out_error =>
      _localizedValues[locale.languageCode]['network_time_out_error'];

  get common_tips_refresh =>
      _localizedValues[locale.languageCode]['common_tips_refresh'];

  get common_tips_no_data_refresh =>
      _localizedValues[locale.languageCode]['common_tips_no_data_refresh'];

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

  get startPageOriginalPassInputs =>
      _localizedValues[locale.languageCode]['startPageOriginalPassInputs'];

  get startPageLoginPassword =>
      _localizedValues[locale.languageCode]['startPageLoginPassword'];

  get startPageForgetPasswordButton =>
      _localizedValues[locale.languageCode]['startPageForgetPasswordButton'];

  get startPageChangePasswordButton =>
      _localizedValues[locale.languageCode]['startPageChangePasswordButton'];

  get homePageAgentDetail =>
      _localizedValues[locale.languageCode]['homePageAgentDetail'];

  get homePageAgentOperation =>
      _localizedValues[locale.languageCode]['homePageAgentOperation'];

  get homePageAgentAvoiding =>
      _localizedValues[locale.languageCode]['homePageAgentAvoiding'];

  get homePageAgentAgency =>
      _localizedValues[locale.languageCode]['homePageAgentAgency'];

  get homePageAgentChangeRatio =>
      _localizedValues[locale.languageCode]['homePageAgentChangeRatio'];

  get homePageAgentInputRatio =>
      _localizedValues[locale.languageCode]['homePageAgentInputRatio'];

  get startPageRegister =>
      _localizedValues[locale.languageCode]['startPageRegister'];

  get homePage => _localizedValues[locale.languageCode]['homePage'];

  get homePageAgentRatio =>
      _localizedValues[locale.languageCode]['homePageAgentRatio'];

  get homePageAgentSubordinate =>
      _localizedValues[locale.languageCode]['homePageAgentSubordinate'];

  get homePageAgentNums =>
      _localizedValues[locale.languageCode]['homePageAgentNums'];

  get sellcoinTotalAssets =>
      _localizedValues[locale.languageCode]['sellcoinTotalAssets'];

  get homePageAgent => _localizedValues[locale.languageCode]['homePageAgent'];

  get homeCard => _localizedValues[locale.languageCode]['homeCard'];

  get singlePage => _localizedValues[locale.languageCode]['singlePage'];

  get minePage => _localizedValues[locale.languageCode]['minePage'];

  get pull_to_refresh_releaseText =>
      _localizedValues[locale.languageCode]['pull_to_refresh_releaseText'];

  get pull_to_refresh_refreshingText =>
      _localizedValues[locale.languageCode]['pull_to_refresh_refreshingText'];

  get pull_to_refresh_completeText =>
      _localizedValues[locale.languageCode]['pull_to_refresh_completeText'];

  get pull_to_refresh_idleText =>
      _localizedValues[locale.languageCode]['pull_to_refresh_idleText'];

  get my_page_balance =>
      _localizedValues[locale.languageCode]['my_page_balance'];

  get my_page_total_profit =>
      _localizedValues[locale.languageCode]['my_page_total_profit'];

  get my_page_frozen => _localizedValues[locale.languageCode]['my_page_frozen'];

  get my_page_menu_qiangdan =>
      _localizedValues[locale.languageCode]['my_page_menu_qiangdan'];

  get my_page_menu_recharge =>
      _localizedValues[locale.languageCode]['my_page_menu_recharge'];

  get my_page_menu_withdrawal =>
      _localizedValues[locale.languageCode]['my_page_menu_withdrawal'];

  get my_page_menu_balance =>
      _localizedValues[locale.languageCode]['my_page_menu_balance'];

  get my_page_menu_orderNums =>
      _localizedValues[locale.languageCode]['my_page_menu_orderNums'];

  get my_page_menu_handleing =>
      _localizedValues[locale.languageCode]['my_page_menu_handleing'];

  get my_page_menu_success =>
      _localizedValues[locale.languageCode]['my_page_menu_success'];

  get my_page_menu_failure =>
      _localizedValues[locale.languageCode]['my_page_menu_failure'];

  get my_page_menu_cancel =>
      _localizedValues[locale.languageCode]['my_page_menu_cancel'];

  get my_page_menu_record =>
      _localizedValues[locale.languageCode]['my_page_menu_record'];

  get my_page_server_about =>
      _localizedValues[locale.languageCode]['my_page_server_about'];

  get my_page_server_agent =>
      _localizedValues[locale.languageCode]['my_page_server_agent'];

  get my_page_server_download =>
      _localizedValues[locale.languageCode]['my_page_server_download'];

  get my_page_server_income =>
      _localizedValues[locale.languageCode]['my_page_server_income'];

  get my_page_server_service =>
      _localizedValues[locale.languageCode]['my_page_server_service'];

  get my_page_server_help =>
      _localizedValues[locale.languageCode]['my_page_server_help'];

  get my_page_server_safe =>
      _localizedValues[locale.languageCode]['my_page_server_safe'];

  get my_page_server_share =>
      _localizedValues[locale.languageCode]['my_page_server_share'];

  get my_page_server_wait =>
      _localizedValues[locale.languageCode]['my_page_server_wait'];

  get homePageManual => _localizedValues[locale.languageCode]['homePageManual'];

  get homePageManualFlow =>
      _localizedValues[locale.languageCode]['homePageManualFlow'];

  get homePageManualChannel =>
      _localizedValues[locale.languageCode]['homePageManualChannel'];

  get homePageManualRecharge =>
      _localizedValues[locale.languageCode]['homePageManualRecharge'];

  get homePageManualSpeedy =>
      _localizedValues[locale.languageCode]['homePageManualSpeedy'];

  get homePageManualFlows =>
      _localizedValues[locale.languageCode]['homePageManualFlows'];

  get homePageManualCourse =>
      _localizedValues[locale.languageCode]['homePageManualCourse'];

  get homeEditCard => _localizedValues[locale.languageCode]['homeEditCard'];

  get homeCardName => _localizedValues[locale.languageCode]['homeCardName'];

  get homeCardNameTip =>
      _localizedValues[locale.languageCode]['homeCardNameTip'];

  get homeCardNums => _localizedValues[locale.languageCode]['homeCardNums'];

  get homeCardNumsTip =>
      _localizedValues[locale.languageCode]['homeCardNumsTip'];

  get homeCardTypes => _localizedValues[locale.languageCode]['homeCardTypes'];

  get homeCardTypesTip =>
      _localizedValues[locale.languageCode]['homeCardTypesTip'];

  get publicButtonOK => _localizedValues[locale.languageCode]['publicButtonOK'];

  get publicDefaultName =>
      _localizedValues[locale.languageCode]['publicDefaultName'];

  get myPageSingleCard =>
      _localizedValues[locale.languageCode]['myPageSingleCard'];

  get userInfoPageButton =>
      _localizedValues[locale.languageCode]['userInfoPageButton'];

  get userInfoPageDeleteMsg =>
      _localizedValues[locale.languageCode]['userInfoPageDeleteMsg'];

  get createNewAddress_Cancel =>
      _localizedValues[locale.languageCode]['createNewAddress_Cancel'];

  get common_btn_confirm =>
      _localizedValues[locale.languageCode]['common_btn_confirm'];

  get common_title_userName =>
      _localizedValues[locale.languageCode]['common_title_userName'];

  get common_title_phone =>
      _localizedValues[locale.languageCode]['common_title_phone'];

  get order_grap_ai =>
      _localizedValues[locale.languageCode]['order_grap_ai'];

  get order_grap_check =>
      _localizedValues[locale.languageCode]['order_grap_check'];

  get order_total_balance =>
      _localizedValues[locale.languageCode]['order_total_balance'];

  get order_index => _localizedValues[locale.languageCode]['order_index'];

  get order_amount => _localizedValues[locale.languageCode]['order_amount'];

  get order_scale => _localizedValues[locale.languageCode]['order_scale'];

  get order_guide => _localizedValues[locale.languageCode]['order_guide'];

  get order_error_balance_no_enough =>
      _localizedValues[locale.languageCode]['order_error_balance_no_enough'];

  get order_recharge_now =>
      _localizedValues[locale.languageCode]['order_recharge_now'];

  get order_have_a_new_open_order =>
      _localizedValues[locale.languageCode]['order_have_a_new_open_order'];

  get order_sure_order =>
      _localizedValues[locale.languageCode]['order_sure_order'];

  get order_each => _localizedValues[locale.languageCode]['order_each'];

  get order_order => _localizedValues[locale.languageCode]['order_order'];

  get order_bankcard => _localizedValues[locale.languageCode]['order_bankcard'];

  get order_start_grap =>
      _localizedValues[locale.languageCode]['order_start_grap'];

  get order_graping => _localizedValues[locale.languageCode]['order_graping'];

  get order_stop_grap => _localizedValues[locale.languageCode]['order_stop_grap'];


  get order_recharge_input_card =>
      _localizedValues[locale.languageCode]['order_recharge_input_card'];

  get order_recharge_input_amount =>
      _localizedValues[locale.languageCode]['order_recharge_input_amount'];

  get order_recharge_tips_copy =>
      _localizedValues[locale.languageCode]['order_recharge_tips_copy'];

  get order_recharge_input_name =>
      _localizedValues[locale.languageCode]['order_recharge_input_name'];

  get order_recharge_input_bank =>
      _localizedValues[locale.languageCode]['order_recharge_input_bank'];

  get order_recharge_submit =>
      _localizedValues[locale.languageCode]['order_recharge_submit'];

  get order_recharge_my_bank =>
      _localizedValues[locale.languageCode]['order_recharge_my_bank'];

  get order_recharge_my_name =>
      _localizedValues[locale.languageCode]['order_recharge_my_name'];

  get order_recharge_my_card =>
      _localizedValues[locale.languageCode]['order_recharge_my_card'];

  get order_recharge_amount =>
      _localizedValues[locale.languageCode]['order_recharge_amount'];

  get order_recharge_copy =>
      _localizedValues[locale.languageCode]['order_recharge_copy'];

  get order_recharge_payee_bank =>
      _localizedValues[locale.languageCode]['order_recharge_payee_bank'];

  get order_recharge_payee_account =>
      _localizedValues[locale.languageCode]['order_recharge_payee_account'];

  get order_recharge_payee_name =>
      _localizedValues[locale.languageCode]['order_recharge_payee_name'];

  get withdraw_balance =>
      _localizedValues[locale.languageCode]['withdraw_balance'];

  get order_recharge_guide_tip =>
      _localizedValues[locale.languageCode]['order_recharge_guide_tip'];

  get withdraw_amount =>
      _localizedValues[locale.languageCode]['withdraw_amount'];

  get withdraw_input_card =>
      _localizedValues[locale.languageCode]['withdraw_input_card'];

  get share_code => _localizedValues[locale.languageCode]['share_code'];

  get share_rate => _localizedValues[locale.languageCode]['share_rate'];

  get share_range => _localizedValues[locale.languageCode]['share_range'];

  get share_range_inout_error =>
      _localizedValues[locale.languageCode]['share_range_inout_error'];

  get share_agent_rate =>
      _localizedValues[locale.languageCode]['share_agent_rate'];

  get share_copy => _localizedValues[locale.languageCode]['share_copy'];

  get share_rate_unit =>
      _localizedValues[locale.languageCode]['share_rate_unit'];

  get userInfoRecord => _localizedValues[locale.languageCode]['userInfoRecord'];

  get order_order_detail =>
      _localizedValues[locale.languageCode]['order_order_detail'];

  get order_order_grap =>
      _localizedValues[locale.languageCode]['order_order_grap'];

  get order_order_hasGrap =>
      _localizedValues[locale.languageCode]['order_order_hasGrap'];

  get order_order_frozenBalance =>
      _localizedValues[locale.languageCode]['order_order_frozenBalance'];

  get order_order_totalProfit =>
      _localizedValues[locale.languageCode]['order_order_totalProfit'];

  get order_order_total =>
      _localizedValues[locale.languageCode]['order_order_total'];

  get order_order_success =>
      _localizedValues[locale.languageCode]['order_order_success'];

  get order_order_fail =>
      _localizedValues[locale.languageCode]['order_order_fail'];

  get order_order_successRate =>
      _localizedValues[locale.languageCode]['order_order_successRate'];

  static WalletLocalizations of(BuildContext context) {
    return Localizations.of(context, WalletLocalizations);
  }
}
