import 'package:auto_size_text/auto_size_text.dart';

/// Wallet Addresses List page.
/// [author] tt
/// [time] 2019-4-25

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class PaymentMethodBankCardAdd extends StatefulWidget {
  static String tag = "PaymentMethodBankCardAdd";

  @override
  _PaymentMethodAddState createState() => _PaymentMethodAddState();
}

class _PaymentMethodAddState extends State<PaymentMethodBankCardAdd> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _bank_card_number_validate = false;
  bool _bank_card_name_validate = false;
  bool _bank_name_validate = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController controllerBankCardNumber;
  TextEditingController controllerBankCardName;
  TextEditingController controllerBankName;

  FocusNode _nodeTextBankCardNumber = FocusNode();
  FocusNode _nodeTextBankCardName = FocusNode();
  FocusNode _nodeTextBankName = FocusNode();

  @override
  void initState() {
    super.initState();
    controllerBankCardNumber = TextEditingController();
    controllerBankCardName = TextEditingController();
    controllerBankName = TextEditingController();
  }

  @override
  void dispose() {
    controllerBankCardNumber.dispose();
    controllerBankCardName.dispose();
    controllerBankName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    canToucn = true;

    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
            '1'),
      ),
      body:
      Builder(
        builder: (BuildContext context) {
          return FormKeyboardActions(
              actions: _keyboardActions(),
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Form(key: _formKey, child: this.buildBody(context))));
        },
      ),
    );
  }

  List<KeyboardAction> _keyboardActions() {
    List<KeyboardAction> actions = <KeyboardAction>[
      KeyboardAction(
          focusNode: _nodeTextBankCardNumber,
          closeWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          )),
      KeyboardAction(
          focusNode: _nodeTextBankCardName,
          closeWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          )),
      KeyboardAction(
          focusNode: _nodeTextBankName,
          closeWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          )),
    ];
    return actions;
  }

  Widget buildBody(BuildContext context) {
    var inputBankCardNumber = TextField(
      // content
      controller: controllerBankCardNumber,
      decoration: InputDecoration(
        labelText:
            '1',
        errorText: _bank_card_number_validate
            ? '1'
            : null,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),
      maxLines: 1,
      keyboardType: TextInputType.number,
      obscureText: false,
      focusNode: _nodeTextBankCardNumber,
      onChanged: (val) {
        setState(() {
          this.clickBankCardNumber();
        });
      },
    );

    ///input pin
    var inputBankCardName = TextField(
      // content
      controller: controllerBankCardName,
      decoration: InputDecoration(
        labelText: '1',
        errorText: _bank_card_name_validate
            ? '1'
            : null,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),
      maxLines: 1,
      keyboardType: TextInputType.text,
      focusNode: _nodeTextBankCardName,
      onChanged: (val) {
        setState(() {
          this.clickBankCardName();
        });
      },
    );
    /**
     * PIN confirm
     */
    var inputBankName = TextField(
      // content
      controller: controllerBankName,
      decoration: InputDecoration(
        labelText: '1',
        errorText: _bank_name_validate
            ? '1'
            : null,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),

      maxLines: 1,
      keyboardType: TextInputType.text,
      focusNode: _nodeTextBankName,
      onChanged: (val) {
        setState(() {
          this.clickBankName();
        });
      },
    );
    var body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: inputBankName,
        ),
        Divider(
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: inputBankCardNumber,
        ),
        Divider(
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: inputBankCardName,
        ),
        Divider(
          height: 0,
        ),
        SizedBox(
          height: 20,
        ),
        CustomRaiseButton(
          // Next button.
          context: context,
          hasRow: false,
          title: '1',
          titleColor: Colors.white,
          color: AppCustomColor.btnConfirm,
          callback: clickBtn(context),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
    return body;
  }

  Function clickBankCardNumber() {
    if (this.controllerBankCardNumber.text.isEmpty) {
      _bank_card_number_validate = true;
    } else {
      _bank_card_number_validate = false;
    }
  }

  Function clickBankCardName() {
    if (this.controllerBankCardName.text.isEmpty) {
      _bank_card_name_validate = true;
    } else {
      _bank_card_name_validate = false;
    }
  }

  Function clickBankName() {
    if (this.controllerBankName.text.isEmpty) {
      _bank_name_validate = true;
    } else {
      _bank_name_validate = false;
    }
  }

  bool canToucn = true;

  Function clickBtn(BuildContext context) {
    if (canToucn == false) return () {};

    return () {
      String bankCardNumber = this.controllerBankCardNumber.text;
      String bankCardName = this.controllerBankCardName.text;
      String bankName = this.controllerBankName.text;
      setState(() {
        if (bankCardNumber.isEmpty) {
          _bank_card_number_validate = true;
        } else {
          _bank_card_number_validate = false;
        }

        if (bankCardName.isEmpty) {
          _bank_card_name_validate = true;
        } else {
          _bank_card_name_validate = false;
        }

        if (bankName.isEmpty) {
          _bank_name_validate = true;
        } else {
          _bank_name_validate = false;
        }
      });

      if (_bank_card_number_validate == false &&
          _bank_card_name_validate == false &&
          _bank_name_validate == false) {
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
      }
    };
  }
}
