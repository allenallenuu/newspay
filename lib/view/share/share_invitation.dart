
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/model/share_invitation_info.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';
import 'package:qiangdan_app/view/share/share_invitation_extract.dart';
import 'package:qiangdan_app/view/share/share_invitation_list.dart';
import 'package:qiangdan_app/view/share/share_receive_page.dart';
import 'package:qiangdan_app/view/widgets/custom_raise_button_widget.dart';
import 'package:qiangdan_app/view_model/main_model.dart';

class ShareInvitation extends StatefulWidget {
  static String tag = "ShareInvitation";

  @override
  _ShareInvitationState createState() => _ShareInvitationState();
}

class _ShareInvitationState extends State<ShareInvitation>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
//      _shareInvitationListInfoes = stateModel.getShareInvitationList(context);

      return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text('1'),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ShareInvitationList();
                  }));
                },
                child: Text('1'),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          body: Text('分享'));
    });
  }

  ///转存到账户
  Widget _saveView() {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        child: CustomRaiseButton(
            context: context,
            hasRow: false,
            title: '1',
            titleColor: Colors.white,
            color: AppCustomColor.btnConfirm,
            callback: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ShareInvitationExtract();
              })).then((value) {
                if (value) {
                  setState(() {});
                }
              });
            }));
  }

  ///代理邀请
  Widget _shareView() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: CustomRaiseButton(
        context: context,
        hasRow: false,
        title: '1',
        titleColor: Colors.white,
        color: AppCustomColor.btnConfirm,
        callback: () {
          var address = kIsWeb
              ? GlobalInfo.userInfo.webShareAddress == null
                  ? ''
                  : GlobalInfo.userInfo.webShareAddress
              : GlobalInfo.userInfo.appShareAddress == null
                  ? ''
                  : GlobalInfo.userInfo.appShareAddress;
          ShareReceiveModel model = ShareReceiveModel(shareAddress: address);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ShareReceivePage(shareReceiveModel: model);
          }));
        },
      ),
    );
  }
}
