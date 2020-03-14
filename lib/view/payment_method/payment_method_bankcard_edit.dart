import 'package:auto_size_text/auto_size_text.dart';

/// Wallet Addresses List page.
/// [author] tt
/// [time] 2019-4-25

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/payment_method_info.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class PaymentMethodBankCardEdit extends StatefulWidget {
  static String tag = "PaymentMethodBankCardEdit";

  final PaymentMethodListModel paymentMethodModel;

  PaymentMethodBankCardEdit({Key key, @required this.paymentMethodModel})
      : super(key: key);

  @override
  _PaymentMethodEditState createState() => _PaymentMethodEditState();
}

class _PaymentMethodEditState extends State<PaymentMethodBankCardEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PaymentMethodListModel _paymentMethodModel;
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
    _paymentMethodModel = widget.paymentMethodModel;
    controllerBankCardNumber =
        TextEditingController(text: _paymentMethodModel.bankNumber);
    controllerBankCardName =
        TextEditingController(text: _paymentMethodModel.payee);
    controllerBankName =
        TextEditingController(text: _paymentMethodModel.bankName);
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
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('1'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => true,
                      child: AlertDialog(
                        title: Center(
                            child: Text('1')),
                        actions: <Widget>[
                          new FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: new Text('1')),
                          new FlatButton(
                              onPressed: () => onDeleClickItem(),
                              child: new Text('1'))
                        ],
                      ),
                    );
                  });
            },
            child: Text('1'),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Builder(
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
        border: InputBorder.none,
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
        border: InputBorder.none,
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),
      maxLines: 1,
      keyboardType: TextInputType.number,
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
        border: InputBorder.none,
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),

      maxLines: 1,
      keyboardType: TextInputType.number,
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
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: inputBankName,
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
        Future result = NetConfig.post(context, NetConfig.UpdatePaymentMethod, {
          'bankNumber': bankCardNumber,
          'payee': bankCardName,
          'bankName': bankName,
          'id': _paymentMethodModel.id.toString(),
        }, errorCallback: (msg) {
          canToucn = true;
          Tools.showToast(_scaffoldKey, msg.toString());
        });

        result.then((data) {
          if (NetConfig.checkData(data)) {
            setState(() {});
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        });
      }
    };
  }

  void onDeleClickItem() {
    Navigator.pop(context);
    Tools.loadingAnimation(context);
    Future result = NetConfig.post(context, NetConfig.DelePaymentMethod,
        {"id": _paymentMethodModel.id.toString()}, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg.toString());
    });
    result.then((data) {
      if (NetConfig.checkData(data)) {
        Navigator.pop(context);
        Navigator.pop(context, true);
        setState(() {});
      } else {
        Navigator.pop(context);
      }
    });
  }
}
