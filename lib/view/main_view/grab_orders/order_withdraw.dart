import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/model/BalanceModel.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class OrderWithdraw extends StatefulWidget {
  static String tag = 'OrderWithdraw';

  @override
  _OrderWithdrawState createState() => _OrderWithdrawState();
}

class _OrderWithdrawState extends State<OrderWithdraw> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BalanceModel _balanceModel;
  TextEditingController controllerAmount,
      controllerBank,
      controllerName,
      controllerCard;

  @override
  void initState() {
    super.initState();
    controllerAmount = TextEditingController();
    controllerBank = TextEditingController();
    controllerName = TextEditingController();
    controllerCard = TextEditingController();
    getWithdraw();
  }

  @override
  void dispose() {
    super.dispose();
    controllerAmount.dispose();
    controllerBank.dispose();
    controllerName.dispose();
    controllerCard.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppCustomColor.themeBackgroudGrayColor,
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(WalletLocalizations.of(context).my_page_menu_withdrawal),
        ),
        body: _balanceModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _withdrawInfo(),
                    _amountInput(),
                    myCardView(),
                    submitView()
                  ],
                ),
              ));
  }

  Widget _withdrawInfo() {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Color(0xffF34545), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cardInfoItem(
              WalletLocalizations.of(context).withdraw_balance,
              _balanceModel == null ? '' : _balanceModel.balance.toString()),
        ],
      ),
    );
  }

  Widget _cardInfoItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: 5,),
        Text(content,
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _amountInput() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            WalletLocalizations.of(context).withdraw_amount,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          inputItemView('￥', '', controllerAmount)
        ],
      ),
    );
  }

  Widget inputItemView(
      String title, String hint, TextEditingController control) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
              height: 50.0,
              child: TextField(
                controller: control,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                maxLength: 11,
                maxLengthEnforced: true,
                style: new TextStyle(color: Colors.black, fontSize: 18.0),
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    counterText: '',
                    hintStyle: new TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    )),
              )),
        )
      ],
    );
  }

  Widget myCardView() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          inputItemView(
              WalletLocalizations.of(context).order_recharge_my_bank,
              WalletLocalizations.of(context).order_recharge_input_bank,
              controllerBank),
          Divider(),
          inputItemView(
              WalletLocalizations.of(context).order_recharge_my_name,
              WalletLocalizations.of(context).order_recharge_input_name,
              controllerName),
          Divider(),
          inputItemView(
              WalletLocalizations.of(context).order_recharge_my_card,
              WalletLocalizations.of(context).withdraw_input_card,
              controllerCard),
        ],
      ),
    );
  }

  Widget submitView() {
    return InkWell(
      onTap: () {
        submitCard();
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 20,
            left: 40,
            right: 40,
          ),
          padding: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: Color(0xffF34545),
              borderRadius: BorderRadius.circular(90)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(WalletLocalizations.of(context).order_recharge_submit,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          )),
    );
  }

  void getWithdraw() {
    Future future =
        NetConfig.post(context, NetConfig.balanceList, {}, timeOut: 10,errorCallback: (msg) {

          Tools.showToast(_scaffoldKey, msg);
        });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        _balanceModel = BalanceModel(
          balance: double.parse(data['balance'].toString()),
          totalBalance: double.parse(data['totalBalance'].toString()),
          frozenBalance: double.parse(data['frozenBalance'].toString()),
          totalProfit: double.parse(data['totalProfit'].toString()),
          id: data['id'],
          uid: data['uid'],
        );
      }
      setState(() {});
    });
  }

  void submitCard() {
    if (controllerAmount.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_amount);
      return;
    }
    if (controllerBank.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_bank);
      return;
    }
    if (controllerCard.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_card);
      return;
    }
    if (controllerName.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_name);
      return;
    }
    Tools.loadingAnimation(context);
    Future future = NetConfig.post(
        context,
        NetConfig.withDraw,
        {
          'withdrawCoin': controllerAmount.text,
          'payee': controllerName.text,
          'bankNumber': controllerCard.text,
          'bankName': controllerBank.text
        },
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {}
      Navigator.of(context).pop();
      setState(() {});
    });
  }
}
