import 'package:flutter/material.dart';

import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';

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
                  _getPhoneInput(cardNameCtrl, '持卡人', '请输入持卡人信息'),
                  Divider(height: 1, indent: 15,endIndent: 15,),
                  SizedBox(
                    height: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                  ),
                  _getPhoneInput(cardNumsCtrl, '银行卡号', '请输入银行卡号'),
                  Divider(height: 1, indent: 15,endIndent: 15,),

                  _getPhoneInput(cardTypesCtrl, '卡类型', '请输入开户行'),
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
          title: '确定',
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
            '请输入银行卡号');
        return;
      }
      if (bankCardName.length == 0 || bankCardName == null) {
        Tools.showToast(
            _scaffoldKey,
           '请输入银行卡类型');
        return;
      }
      if (bankName.length == 0 || bankName == null) {
        Tools.showToast(
            _scaffoldKey,
            '请输入持卡人');
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
