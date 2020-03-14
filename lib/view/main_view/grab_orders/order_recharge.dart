import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wpay_app/model/OrderRechargeModel.dart';
import 'package:wpay_app/tools/WebTools.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class OrderRecharge extends StatefulWidget {
  static String tag = 'OrderRecharge';

  @override
  _OrderRechargeState createState() => _OrderRechargeState();
}

class _OrderRechargeState extends State<OrderRecharge> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrderRechargeModel _model;
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
    getBankInfo();
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
          title: Text(WalletLocalizations.of(context).my_page_menu_recharge),
        ),
        body: _model == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _cardInfo(),
                    _amountInput(),
                    myCardView(),
                    submitView()
                  ],
                ),
              ));
  }

  Widget _cardInfo() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Color(0xffF34545), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cardInfoItem(
              WalletLocalizations.of(context).order_recharge_payee_name,
              _model == null ? '' : _model.payee),
          _cardInfoItem(
              WalletLocalizations.of(context).order_recharge_payee_account,
              _model == null ? '' : _model.bankNumber),
          _cardInfoItem(
              WalletLocalizations.of(context).order_recharge_payee_bank,
              _model == null ? '' : _model.bankName),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Tools.copyAddress(_model.payee +
                      '  ' +
                      _model.bankNumber +
                      '  ' +
                      _model.bankName);
                  Tools.showToast(_scaffoldKey,
                      WalletLocalizations.of(context).order_recharge_tips_copy);
                },
                child: Text(
                  WalletLocalizations.of(context).order_recharge_copy,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _cardInfoItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(content,
            style: TextStyle(
                fontSize: 18,
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
            WalletLocalizations.of(context).order_recharge_amount,
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
              WalletLocalizations.of(context).order_recharge_input_card,
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

  void getBankInfo() {
    Future future = NetConfig.post(context, NetConfig.golbalCard, {},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        List _list = data;
        _model = OrderRechargeModel(
            payee: _list[0]['payee'],
            bankNumber: _list[0]['bankNumber'],
            bankBranch: _list[0]['bankBranch'],
            bankName: _list[0]['bankName']);
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
        NetConfig.recharge,
        {
          'payee': _model.payee,
          'bankName': _model.bankName,
          'bankBranch': _model.bankBranch,
          'bankNumber': _model.bankNumber,
          'num': controllerAmount.text,
          'transferAccountName': controllerName.text,
          'userBankNumber': controllerCard.text,
          'userBankName': controllerBank.text
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
