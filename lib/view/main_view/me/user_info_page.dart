import 'dart:async';

/// User Info page.
/// [author] tt
/// [time] 2019-3-29

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/view/main_view/me/update_nick_name.dart';
import 'package:wpay_app/view/welcome/start_login.dart';
import 'package:wpay_app/view_model/state_lib.dart';

import 'package:wpay_app/tools/WebTools.dart';

class UserInfoPage extends StatefulWidget {
  static String tag = "UserInfoPage";

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>
    implements OnFileUploadListenerWeb {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('1'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Ink(
              // Avatar
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text('1'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    kIsWeb ? _avatar_web() : _avatar(),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
                onTap: () {
                  _bottomSheet();
                },
              ),
            ),
            Divider(height: 0, indent: 15),
            Ink(
              // nick name
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text('1'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      GlobalInfo.userInfo.nickname,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(UpdateNickName.tag);
                },
              ),
            ),
            Divider(height: 0, indent: 15),
            Ink(

              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text('1'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '1',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
                onTap: () {

                },
              ),
            ),
            Divider(height: 0, indent: 15),
            Ink(
              // nick name
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text('1'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      GlobalInfo.currVersionCode.toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
//            Divider(height: 0, indent: 15),

//            SizedBox(height: 10),
//            Ink(
//              // delete account button
//              color: AppCustomColor.themeBackgroudColor,
//              child: ListTile(
//                title: Text(
//                  WalletLocalizations.of(context).userInfoPageButton,
//                  textAlign: TextAlign.center,
//                  style: TextStyle(color: Colors.red),
//                ),
//                onTap: () {
//                  _deleteUser();
//                },
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  @override
  onFileUploadCompleteWeb(List<int> file) {
    NetConfig.changeUserFaceWeb(file, errorCallback: () {
      Tools.showToast(
          _scaffoldKey,'1');
    }, callback: (data) {
      if (NetConfig.checkData(data)) {
        GlobalInfo.userInfo.faceUrl = data; // change locally data.
        setState(() {});
      }
    });
  }

  /// Delete current user
  void _deleteUser() {
    showDialog(
        context: context,
        // barrierDismissible: false,  // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('1'),
            content:
                Text('1'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    '1'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('1'),
                onPressed: () {
                  GlobalInfo.clear();
                  Future<SharedPreferences> prefs =
                      SharedPreferences.getInstance();
                  prefs.then((share) {
                    share.clear();
                    Navigator.of(context).pushNamed(StartLoginPage.tag);
                  });
                },
              )
            ],
          );
        });
  }

  ///
  void _bottomSheet() {
    if (kIsWeb) {
      WebTools.startWebFilePicker(this);
    } else {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text(
                      '1'),
                  onTap: () {
                    _getImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text(
                      '1'),
                  onTap: () {
                    _getImage(ImageSource.camera);
                  },
                ),
              ],
            );
          });
    }
  }

  ///
  _getImage(ImageSource myImageSource) async {
    var image = await ImagePicker.pickImage(source: myImageSource);

    // compress image
    var dir = await path_provider.getTemporaryDirectory();
    var targetPath = dir.absolute.path + "/temp.png";

    Future response = Tools.compressImage(image, targetPath);
    response.then((imgCompressed) {
      print('==> GET FILE = $imgCompressed');

      NetConfig.changeUserFace(imgCompressed, errorCallback: () {
        Tools.showToast(_scaffoldKey, 'Update avatar fail!');
      }, callback: (data) {
        if (NetConfig.checkData(data)) {
          GlobalInfo.userInfo.faceUrl = data; // change locally data.
          setState(() {});
        }
      });
    });

    Navigator.pop(context);
  }

  /// Show user avatar
  Widget _avatar() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Tools.networkImage(GlobalInfo.userInfo.faceUrl,
          width: 35, height: 35),
    );
  }

  Widget _avatar_web() {
    if (GlobalInfo.userInfo.faceUrl == null ||
        GlobalInfo.userInfo.faceUrl == "") {
      return Image.asset(
        'assets/omni-logo.png',
        width: 35,
        height: 35,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: WebTools.networkImageWeb(
            NetConfig.imageHost + GlobalInfo.userInfo.faceUrl, width:35.0, height:35.0),
      );
    }
  }
}
