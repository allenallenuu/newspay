import 'package:flutter/material.dart';

import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/tools/net_config.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';

class HomeAddCard extends StatefulWidget {
  static String tag = "HomeAddCard";

  @override
  _HomeAddCardState createState() => _HomeAddCardState();
}

class _HomeAddCardState extends State<HomeAddCard> {
  TextEditingController cardNameCtrl = TextEditingController(text: "");
  TextEditingController cardNumsCtrl = TextEditingController(text: "");
  TextEditingController cardTypesCtrl = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool canToucn = true;

  @override
  Widget build(BuildContext context) {
    canToucn = true;

    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppCustomColor.themeBackgroudColor,
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
                  _getContextInput(cardNameCtrl, WalletLocalizations.of(context).homeCardName, WalletLocalizations.of(context).homeCardNameTip),
                  Divider(height: 1, indent: 15,endIndent: 15,),
                  SizedBox(
                    height: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                  ),
                  _getContextInput(cardNumsCtrl, WalletLocalizations.of(context).homeCardNums, WalletLocalizations.of(context).homeCardNumsTip),
                  Divider(height: 1, indent: 15,endIndent: 15,),

                  _getContextInput(cardTypesCtrl, WalletLocalizations.of(context).homeCardTypes, WalletLocalizations.of(context).homeCardTypesTip),
                  Divider(height: 1, indent: 15,endIndent: 15,),
                  SizedBox(height: 30),
                  _getDataInfo(),
                ],
              )),
        ));
  }
  ///添加银行卡
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
        Future result = NetConfig.post(context, NetConfig.AddPaymentMethod, {
          'bankNumber': bankCardNumber,
          'payee': bankCardName,
          'bankName': bankName
        }, errorCallback: (msg) {
          canToucn = true;
          Tools.showToast(_scaffoldKey,msg.toString());
        });

        result.then((data) {
          if (NetConfig.checkData(data)) {
            Tools.showToast(_scaffoldKey,WalletLocalizations.of(context).order_add_success);
            canToucn = true;
            Navigator.pop(context);
            Navigator.pop(context,true);
          }else{
            Navigator.pop(context);
          }
        });
    };
  }

  Widget _getContextInput(
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
              width: 100.0,
              alignment: Alignment.centerLeft,
              child: Text(titleText),
            ),
            SizedBox(width: 10,),
            Expanded(child:  new Container(
                height: 50.0,
                margin: EdgeInsets.only(right: 10),
                child: new Center(
                    child: new Container(
                      height: 50.0,
                      child: new TextField(
                        controller: controller,
                        maxLines: 1,
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
                    ))),)
           ,
          ],
        ),
      ),
    );
  }

}
