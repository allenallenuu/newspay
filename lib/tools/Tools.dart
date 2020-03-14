import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/tools/key_config.dart';
import 'package:qiangdan_app/tools/net_config.dart';
import 'package:qiangdan_app/tools/wave_loading/wave.dart';

import 'package:qiangdan_app/view/welcome/start_login.dart';

class Tools {
  /** 返回当前时间戳 */
  static bool getCurrRunningMode() {
    return bool.fromEnvironment("dart.vm.product");
  }

  static String getCurrMoneyFlag() {
    if (GlobalInfo.currencyUnit == KeyConfig.usd) {
      return '\$ ';
    } else {
      return '\￥ ';
    }
  }

  static void noLoginPush( BuildContext context) {
    if (context != null) {
      Navigator.of(context).pushNamed(StartLoginPage.tag);
    }
  }

  static String formatPercent(String n) {
    return (Decimal.parse(n) * Decimal.parse('100')).toString() + "%";
  }

  ///
  static Future<File> compressImage(File file, String targetPath,
      {int minWidth = 100, int minHeight = 100}) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: minWidth,
      minHeight: minHeight,
    );
    return result;
  }

  ///生成md5
  static String convertMD5Str(String data) {
    return md5
        .convert(Utf8Encoder()
            .convert(md5.convert(Utf8Encoder().convert(data)).toString()))
        .toString();
  }

  /** 返回当前时间戳 */
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  /** 复制到剪粘板 */
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  static copyAddress(String value) {
    if (kIsWeb) {
      WebTools.copyToClipboardHack(value);
    } else {
      Clipboard.setData(new ClipboardData(text: value));
    }
  }

  static showToast(GlobalKey<ScaffoldState> _scaffoldKey, String msg,
      {Toast toastLength = Toast.LENGTH_SHORT}) {
    if (kIsWeb) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
      );
    }
  }

  /// get image path
  static String imagePath(final String text,
      {String scaleType = "@2x", String suffix = "png"}) {
    scaleType = scaleType == null ? '' : scaleType;
    suffix = suffix == null ? 'png' : suffix;
    return 'assets/' + text + scaleType + '.' + suffix;
  }

  ///
  static void saveStringKeyValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  ///
  static Future<String> getStringKeyValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// loading Animation
  static void loadingAnimation(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button to dismiss dialog.
        builder: (BuildContext context) {
          return Container(
            child: SpinKitWaveLoading(type: SpinKitWaveTypeLoading.start),
          );

          // return Center(child:CircularProgressIndicator());
        });
  }

  /// Get image from network.
  static Widget networkImage(String url,
      {String defaultImage = 'assets/omni-logo.png',
      double width = 90,
      double height = 90,
      BoxFit fit}) {
    if (fit == null) {
      fit = BoxFit.fitHeight;
    }

    if (url == null || url == "") {
      return Image.asset(
        defaultImage,
        width: width,
        height: height,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: NetConfig.imageHost + url,
        placeholder: (context, url) => new Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: width,
        height: height,
        fit: fit,
      );
    }
  }
}
