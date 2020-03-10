import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qiangdan_app/view/welcome/start_login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainStateModel stateModel = null;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        centerTitle: false,
        title: Image.asset(
          Tools.imagePath('logo'),
          fit: BoxFit.fitHeight,
          height: 30,
        ),
        actions: <Widget>[
          GlobalInfo.userInfo.loginToken == null
              ? FlatButton(
                  // records button
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                            '1',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 5,),
                        Image.asset(Tools.imagePath('login'),width: 30,height: 30,fit: BoxFit.fill,)
                      ],
                    ),
                  ),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pushNamed(StartLoginPage.tag);
                  },
                )
              : SizedBox(),
        ],
      ),
      body: Text('主页'),
    );
  }

  bool canTouchAdd = true;


  showSnackBar(String content) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(content)));
  }
}
