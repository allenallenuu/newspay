import 'package:flutter/material.dart';

import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/payment_method_info.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';

class HomeEditCard extends StatefulWidget {
  static String tag = "HomeEditCard";
  final PaymentMethodListModel paymentMethodModel;

  HomeEditCard({Key key, @required this.paymentMethodModel})
      : super(key: key);
  @override
  _HomeEditCardState createState() => _HomeEditCardState();
}

class _HomeEditCardState extends State<HomeEditCard> {
  PaymentMethodListModel _paymentMethodModel;

  TextEditingController cardNameCtrl ;
  TextEditingController cardNumsCtrl ;
  TextEditingController cardTypesCtrl;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool canToucn = true;
  @override
  void initState() {
    super.initState();
    _paymentMethodModel = widget.paymentMethodModel;
    cardNumsCtrl =
        TextEditingController(text: _paymentMethodModel.bankNumber);
    cardNameCtrl =
        TextEditingController(text: _paymentMethodModel.payee);
    cardTypesCtrl =
        TextEditingController(text: _paymentMethodModel.bankName);
  }

  @override
  void dispose() {
    cardNumsCtrl.dispose();
    cardNameCtrl.dispose();
    cardTypesCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    canToucn = true;

    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).homeEditCard,)),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                  ),
                  _getPhoneInput(cardNameCtrl, WalletLocalizations.of(context).homeCardName, WalletLocalizations.of(context).homeCardNameTip),
                  Divider(height: 1, indent: 15,endIndent: 15,),
                  SizedBox(
                    height: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                  ),
                  _getPhoneInput(cardNumsCtrl, WalletLocalizations.of(context).homeCardNums, WalletLocalizations.of(context).homeCardNumsTip),
                  Divider(height: 1, indent: 15,endIndent: 15,),

                  _getPhoneInput(cardTypesCtrl, WalletLocalizations.of(context).homeCardTypes, WalletLocalizations.of(context).homeCardTypesTip),
                  Divider(height: 1, indent: 15,endIndent: 15,),
                  SizedBox(height: 30),
                  _getDataInfo(),
                ],
              )),
        ));
  }
  ///修改银行卡
  Widget _getDataInfo() {
    return new Card(
      color: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: Colors.red)
      ),
      elevation: 1.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CustomRaiseButton(
          context: context,
          hasRow: false,
          title: WalletLocalizations.of(context).publicButtonOK,
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: clickBtn(context),
        ),
      ),
    );
  }
  Function clickBtn(BuildContext context) {
    if (canToucn == false) return () {};

    return () {
      String bankCardNumber = this.cardNumsCtrl.text;
      String bankCardName = this.cardTypesCtrl.text;
      String bankName = this.cardNameCtrl.text;

      if (bankCardNumber.length == 0 || bankCardNumber == null) {
        Tools.showToast(
            _scaffoldKey,
            WalletLocalizations.of(context).homeCardNumsTip);
        return;
      }
      if (bankCardName.length == 0 || bankCardName == null) {
        Tools.showToast(
            _scaffoldKey,
            WalletLocalizations.of(context).homeCardTypesTip);
        return;
      }
      if (bankName.length == 0 || bankName == null) {
        Tools.showToast(
            _scaffoldKey,
            WalletLocalizations.of(context).homeCardNameTip);
        return;
      }

      canToucn = false;
      // Show loading animation.
      Tools.loadingAnimation(context);
      Future result = NetConfig.post(context, NetConfig.UpdatePaymentMethod, {
        'bankNumber': bankCardNumber,
        'payee': bankCardName,
        'bankName': bankName,
        'id': _paymentMethodModel.id.toString(),
      }, errorCallback: (msg) {
        canToucn = true;
        Tools.showToast(_scaffoldKey,msg.toString());
      });

      result.then((data) {
        if (NetConfig.checkData(data)) {
          canToucn = true;
          Navigator.pop(context);
          Navigator.pop(context,true);
        }else{
          Navigator.pop(context);
        }
      });
    };
  }

  Widget _getPhoneInput(
      TextEditingController controller, String titleText, String hitText) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      height: 64.0,
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(left: 12.0),
              height: 64.0,
              child: Center(
                child: Text(titleText),
              ),
            ),
            new Container(
                height: 50.0,
                width: 180,
                margin: EdgeInsets.only(right: 10),
                child: new Center(
                    child: new Container(
                      height: 50.0,
                      child: new TextField(
                        controller: controller,
                        maxLines: 1,
                        maxLength: 11,
                        maxLengthEnforced: true,
                        style: new TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: new InputDecoration(
                            hintText: hitText,
                            counterText: '',
                            border: InputBorder.none,
                            hintStyle: new TextStyle(

                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
