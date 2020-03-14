import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';

class HomePageAvoiding extends StatefulWidget {
  static String tag = 'HomeAvoiding';

  @override
  HomePageAvoidingState createState() => HomePageAvoidingState();
}

class HomePageAvoidingState extends State<HomePageAvoiding> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(WalletLocalizations.of(context).homePageAgentAvoiding),
      ),
      body: Center(
          child:
          SingleChildScrollView(child:
          Container(
        padding: EdgeInsets.all(10),
        child: Text(
            '平台政策和会员行为规范 \n •	在抢到单子的过程中，发现收到钱后，在上图的收款单列表里， 核对订单信息，确认收款。但在15-20 分钟之内没有及时确认收款的，系统将禁止抢单至少30分钟，第二次发现禁止一天，第三次发现禁止15天。超过三次而且态度不端正者直接解封合作关系 ！\n•	误点了确认收款必须第一时间向客服反应。客服尽力帮你们找回，做单时一定要保持头脑是清醒状态，不要在疲劳后饮酒后不自控的情况下做单。\n•	付款方任何留言都不要回复！禁止给付款方留言！如有违反，被平台发现，平台将封冻你的所有资金。\n•	最后，祝福大家做单愉快，财源滚滚！\n•\n•\n•\n•\n•	代理奖惩：\n•	A：奖励规则\n•	直接收益：平台设置了代理模式，当你抢单成功时，你会根据自己的代理比例获得相应的代理收益，代理收益会直接实时到账，进入你的现余额；\n•	直推收益：分享好友，创建自己的团队，也可以从自己的团队中获得更多的收益。分享时设置的下级比例为下级抢单成功时获取的代理收益比例，（你的代理比例—下级的代理比例）*下级抢单的金额即为下级为你赚取的收益；\n•	团队收益：扩大团队可获得更多的团队收益。\n•	B：惩罚方法\n•	1：每位代理必须要求下级抢单人员务必遵守平台的抢单规则，如果出现下级跑单的行为有义务配合平台客服联系下级追回款项。（如果该款项无法追回，将扣除代理该笔款项10%的费用作为补偿）\n•	2：必须要求下级会员收到款项及时确定，如果出现多收款或者少收款的情况，第一时间联系客服处理。\n•\n•\n•\n•	关于我们：\n•	一款可以赚钱的APP，只需要添加银行卡并进行抢单收款，就可以为您产生收益。\n•	钱包金额\n•	余额是指您账户上的现金额，是您充值和收益的总额。\n•	打码量\n•	为了平台正常运转使用，当您充值的时候，平台会按比例增加您的应打码量，您抢单确认成功总额大于充值金额的70%时，您可以提现。\n•	冻结金额\n•	提现的时候，为了防止提现与抢单冲突，会把提现的押金金额暂时冻结起来，剩下的金额可用来抢单;抢单成功时，也会把部分金额放入冻结金额中。\n•	充值\n•	充值到系统提供的对应银行卡账户，审核通过后，会存到您押金中。'),
      ))),
    );
  }
}
