import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/share_invitation_info.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view_model/main_model.dart';

class ShareInvitationList extends StatefulWidget {
  static String tag = "ShareInvitationList";

  @override
  _ShareInvitationListState createState() => _ShareInvitationListState();
}

class _ShareInvitationListState extends State<ShareInvitationList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ///分享记录列表
  List<ShareInvitationRecord> _shareInvitationListInfoes;
  MainStateModel stateModel = null;

  @override
  Widget build(BuildContext context) {


    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {

      return Scaffold(
        key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            title: Text(
                '1'),
          ),
          body: body());
    });
  }

  Widget body() {
    return getContent();
  }

  Widget getContent() {
    if (this._shareInvitationListInfoes == null) {
      return Center(child: CircularProgressIndicator());
    } else if (this._shareInvitationListInfoes.length == 0) {
      return Center(
          child: GestureDetector(
        child: Text('1'),
        onTap: () {

          setState(() {});
        },
      ));
    } else {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: _shareInvitationList(),
        ),
      );
    }
  }

  /// wallet address list
  List<Widget> _shareInvitationList() {
    print('==> recharge record amount = ${_shareInvitationListInfoes.length}');

    // list tile
    List<Widget> _list = List();

    for (int i = 0; i < _shareInvitationListInfoes.length; i++) {
      _list.add(_shareInvitationItem(_shareInvitationListInfoes[i]));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  ///
  Widget _shareInvitationItem(ShareInvitationRecord shareInvitationData) {
    return Ink(
        color: AppCustomColor.themeBackgroudColor,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: AutoSizeText(
                'ID:' + shareInvitationData.userId.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: AutoSizeText(
                shareInvitationData.withdrawTime.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: AutoSizeText(
                '1' +
                    ':' +
                    shareInvitationData.withdrawCoin.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            shareInvitationData.status == 0
                ? Container(
                    child: AutoSizeText(
                    '1',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold),
                    minFontSize: 10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
                : shareInvitationData.status == 1
                    ? Container(
                        child: AutoSizeText(
                        '1',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                    : Container(
                        child: AutoSizeText(
                       '1',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
          ],
        ));
  }
}
