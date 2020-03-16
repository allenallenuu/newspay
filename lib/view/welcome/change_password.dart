import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/welcome/forget_account.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class ChangePassword extends StatefulWidget {
  var typeSet;

  ChangePassword({Key key, this.typeSet}) : super(key: key);
  static String tag = "ChangePassword";

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasOriginalFocus = false;
  bool _hasPasswdFocus = false;
  bool _hasNewPasswdFocus = false;
  FocusNode _nodeOriginal = FocusNode();
  FocusNode _nodePasswd = FocusNode();
  FocusNode _nodeNewPasswd = FocusNode();
  TextEditingController originalCtrl = TextEditingController(text: "");
  TextEditingController passwdCtrl = TextEditingController(text: "");
  TextEditingController newPasswdCtrl = TextEditingController(text: "");


  @override
  void initState() {
    _nodeOriginal.addListener(() {
      if (_nodeOriginal.hasFocus) { // get focus
        _hasOriginalFocus = true;
        _hasPasswdFocus = false;
        _hasNewPasswdFocus = false;
      }
      setState(() {});
    });
    _nodePasswd.addListener(() {
      if (_nodePasswd.hasFocus) { // get focus
        _hasPasswdFocus = true;
        _hasOriginalFocus = false;
        _hasNewPasswdFocus = false;

      }
      setState(() {});
    });
    _nodeNewPasswd.addListener(() {
      if (_nodeNewPasswd.hasFocus) { // get focus
        _hasNewPasswdFocus = true;
        _hasOriginalFocus = false;
        _hasPasswdFocus = false;

      }
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    originalCtrl.dispose();
    passwdCtrl.dispose();
    newPasswdCtrl.dispose();
  }



  Widget _getPhoneInput(bool fcousIs,String selectImgae,String unSelectImage,TextEditingController controller,FocusNode focusNodes,String hitText, bool isCode) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22)),
        border: new Border.all(width: 1, color: fcousIs ? Color.fromRGBO(243, 69, 69,1) : Color.fromRGBO(222, 222, 222,1)),
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Container(
                padding: new EdgeInsets.only(left: 24.0),
                child: new Center(
                  child: new Image.asset(
                    Tools.imagePath(fcousIs ? selectImgae : unSelectImage),
                    gaplessPlayback:true,
                    width: 19.0,
                    height: 24.0,
                  ),
                )),
            new Expanded(
                child: new Container(
                    height: 50.0,
                    padding: new EdgeInsets.only(left: 10.0),
                    child: new Center(
                        child: new Container(
                          height: 50.0,
                          child: new TextField(
                            controller: controller,
                            focusNode:   focusNodes,
                            maxLines: 1,
                            maxLength: 11,
                            maxLengthEnforced: true,
                            style:
                            new TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: new InputDecoration(
                                hintText: hitText,
                                counterText: '',
                                border: InputBorder.none,
                                hintStyle: new TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                )),
                          ),
                        )))),
          ],
        ),
      ),
    );
  }
  ///修改密码
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
          title: WalletLocalizations.of(context).startPageForgetPasswordButton,
          titleColor: Colors.white,
          titleSize: 18.0,
          callback: () {
            var originalNums = originalCtrl.text;
            var passwdNums = passwdCtrl.text;
            var newPasswdNums = newPasswdCtrl.text;

            if (originalNums.length == 0 || originalNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPagePasswordInput);
              return;
            }
            if (passwdNums.length == 0 || passwdNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPagePasswordInput);
              return;
            }
            if (newPasswdNums.length == 0 || newPasswdNums == null) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPagePasswordInput);
              return;
            }
            if (newPasswdNums != passwdNums) {
              Tools.showToast(
                  _scaffoldKey,
                  WalletLocalizations.of(context).startPageNoEqual);
              return;
            }


            _onSubmit();
//            _loginActionByPwd(originalCtrl.text, passwdCtrl.text);
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).startPageForgetPasswordButton),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _getPhoneInput(_hasOriginalFocus,'login_password_select','login_password_unselect',originalCtrl,_nodeOriginal,WalletLocalizations.of(context)
                .startPageOriginalPassInputs,false),
            SizedBox(height: 24),

            _getPhoneInput(_hasPasswdFocus,'login_password_select','login_password_unselect',passwdCtrl,_nodePasswd,WalletLocalizations.of(context)
                .startPagePwdError,false),
            SizedBox(height: 24),

            _getPhoneInput(_hasNewPasswdFocus,'login_password_select','login_password_unselect',newPasswdCtrl,_nodeNewPasswd,WalletLocalizations.of(context)
                .startPageNewPasswordInput,false),
            SizedBox(
              height: 24,
            ),

            _getDataInfo(),

          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    var originalNums = originalCtrl.text;
    var passwdNums = passwdCtrl.text;

    Future result = NetConfig.post(context, NetConfig.updateUserPassword, {
      'newPsw': passwdNums,
      'oldPsw': originalNums
    }, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });
    result.then((data) {
      print('updateUserPassword = $data');

        Navigator.of(context).pop();
    });
  }
}
