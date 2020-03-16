/// Update Nick Name page.
/// [author] tt
/// [time] 2019-5-5

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wpay_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class UpdateNickName extends StatefulWidget {
  static String tag = 'UpdateNickName';
  @override
  _UpdateNickNameState createState() => _UpdateNickNameState();
}

class _UpdateNickNameState extends State<UpdateNickName> {

  bool _hasClearIcon = false;
  FocusNode _nodeNickName = FocusNode();
  TextEditingController _nickNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nodeNickName.addListener(() {
      if (_nodeNickName.hasFocus) { // get focus
        if (_nickNameController.text.trim().length == 0) {
          _hasClearIcon = false;
        } else {
          _hasClearIcon = true;
        }
      } else {
        _hasClearIcon = false;
      }
      setState(() {});
    });

    _nickNameController.text = GlobalInfo.userInfo.nickname;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        title: Text('1'),
      ),

      body: FormKeyboardActions(
        actions: _actions(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _inputNewNickName(),

              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: CustomRaiseButton( // Next button.
                  context: context,
                  hasRow: false,
                  title: '1',
                  titleColor: Colors.white,
                  color: AppCustomColor.btnConfirm,
                  callback: () {
                    _onSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  ///
  List<KeyboardAction> _actions() {
    List<KeyboardAction> _actions = <KeyboardAction> [
      KeyboardAction(
        focusNode: _nodeNickName,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      )
    ];

    return _actions;
  }

  ///
  Widget _inputNewNickName() {

    return Form(
      key: _formKey,
      autovalidate: true,
      onChanged: () {
        // print('==> VAL --> ${_nameController.text}');
        if (_nickNameController.text.trim().length == 0) {
          _hasClearIcon = false;
        } else {
          _hasClearIcon = true;
        }

        // nick name max length = 12
        // if (_nickNameController.text.trim().length > 12) {
        //   _nickNameController.text = _nickNameController.text.substring(0, 12);
        // }

        setState(() { });
      },
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: TextFormField(
          controller:  _nickNameController,
          focusNode:   _nodeNickName,
          maxLength: 30,
          autofocus: true,
          validator: (val) => _validate(val),
          decoration: InputDecoration(
            hintText: '1',
            // hintStyle: TextStyle(fontSize: 14),
            suffixIcon: _hasClearIcon ? 
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.highlight_off, color: Colors.grey),
                onPressed: () { _nickNameController.clear(); },
              ) : null,
          ),
        ),
      ),
    );
  }
  
  /// validate new nick name
  String _validate(String val) {
    if (val == null || val.trim().length == 0) {
      return '1';
    } else {
      return null;
    }
  }

  /// update nick name
  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Tools.loadingAnimation(context);
      /// submit new nick name to server
      Future response = NetConfig.post(context,NetConfig.updateUserNickname, {
        'nickname': _nickNameController.text,
      });

      response.then((data) {
        if (NetConfig.checkData(data)) {
          setState(() {
            GlobalInfo.userInfo.nickname = _nickNameController.text; // change locally data.
            Navigator.of(context).pop();
          });
        }
      });
    } 
  }
}
