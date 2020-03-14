import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiangdan_app/tools/Tools.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qiangdan_app/l10n/WalletLocalizations.dart';
import 'package:qiangdan_app/model/global_model.dart';
import 'package:qiangdan_app/tools/WebTools.dart';
import 'package:qiangdan_app/tools/app_data_setting.dart';

//收款页面
class ShareReceivePage extends StatefulWidget {
  static String tag = "ShareReceivePage";

  ShareReceivePage({
    Key key,
  }) : super(key: key);

  @override
  _ShareReceivePageState createState() => _ShareReceivePageState();
}

class _shareModel {
  String webRegisterUrl;
  String invitationCode;
  double minEarningsRatio;
  double maxEarningsRatio;

  _shareModel({
    @required this.webRegisterUrl,
    @required this.invitationCode,
    @required this.minEarningsRatio,
    @required this.maxEarningsRatio,
  });
}

class _ShareReceivePageState extends State<ShareReceivePage> {
  final _key = new GlobalKey<ScaffoldState>();

  _shareModel _model = null;

  String shareAddress = null;
  String currentRate = null;

  @override
  void initState() {
    super.initState();
    getRanage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(WalletLocalizations.of(context).my_page_server_share),
        ),
        key: _key,
        backgroundColor: AppCustomColor.themeBackgroudColor,
        body: _model == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : this.body());
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        Image.asset(
          Tools.imagePath('share_receive_bg'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  WalletLocalizations.of(context).share_code,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _model.invitationCode,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5495E6)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                shareAddress == null
                                    ? Container(
                                        width: 200,
                                        height: 200,
                                        padding: EdgeInsets.only(
                                            left: 50,
                                            right: 50,
                                            top: 80,
                                            bottom: 80),
                                        color: Color(0xffFFEEEB),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF34545),
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: InkWell(
                                            onTap: () {
                                              _setRatioRange();
                                            },
                                            child: Text(
                                              WalletLocalizations.of(context)
                                                  .share_rate,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : QrImage(
                                        data: shareAddress,
                                        size: 200.0,
                                        foregroundColor: Colors.black,
                                        padding: EdgeInsets.all(20),
                                        version: 7,
                                        //字符串很长的时候要加
                                        onError: (ex) {
                                          print("[QR] ERROR - $ex");
                                        },
                                      ),
                                shareAddress == null
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        alignment: Alignment.center,
                                        height: 40,
                                        child: AutoSizeText(
                                          shareAddress,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                          minFontSize: 8,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ))),
              currentRate == null ? Container() : _rateInfo()
            ],
          ),
        ),
      ],
    );
  }

  TextEditingController _rateController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasClearIcon = false;
  FocusNode _nodeText = FocusNode();

  void _setRatioRange() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button to dismiss dialog.
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              WalletLocalizations.of(context).share_rate,
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              _inputRate(),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  WalletLocalizations.of(context).share_range +
                      ":  " +
                      _model.minEarningsRatio.toString() +
                      '~' +
                      _model.maxEarningsRatio.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
              // TextFormField
              SizedBox(
                height: 10,
              ),
              Row(
                // Two buttons.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _btnCancel(),
                  SizedBox(
                    width: 30,
                  ),
                  _btnConfirm(),
                ],
              )
            ],
          );
        });
  }

  Widget _inputRate() {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Form(
        key: _formKey,
        autovalidate: true,
        onChanged: () {
          // print('==> VAL --> ${_nameController.text}');
          if (_rateController.text.trim().length == 0) {
            _hasClearIcon = false;
          } else {
            _hasClearIcon = true;
          }

          // name max length = 10
          // if (_nameController.text.trim().length > 10) {
          //   _nameController.text = _nameController.text.substring(0, 10);
          // }

          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _rateController,
            focusNode: _nodeText,
            maxLength: 10,
            // autofocus: true,
            validator: (val) => _validate(val),
            decoration: InputDecoration(
              hintText: WalletLocalizations.of(context).share_agent_rate,
              hintStyle: TextStyle(fontSize: 14),
              suffixIcon: _hasClearIcon
                  ? IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.highlight_off, color: Colors.grey),
                      onPressed: () {
                        _rateController.clear();
                      },
                    )
                  : null,
            ),
          ),
        ),
      );
    });
  }

  String _validate(String val) {
    if (val == null || val.trim().length == 0) {
      return WalletLocalizations.of(context).homePageAgentInputRatio;
    } else {
      return null;
    }
  }

  ///
  Widget _btnCancel() {
    return InkWell(
      child: Text(
        WalletLocalizations.of(context).createNewAddress_Cancel,
        style: TextStyle(color: Colors.grey[600], fontSize: 16),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  ///
  Widget _btnConfirm() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Color(0xffF34545), borderRadius: BorderRadius.circular(90)),
        child: Text(
          WalletLocalizations.of(context).common_btn_confirm,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      onTap: () {
        if (_rateController.text.isEmpty) {
          setRangeError();
          return;
        }

        var mDouble = double.tryParse(_rateController.text.toString());
        if (mDouble != null) {
          if (mDouble is double) {
            if (mDouble >= _model.minEarningsRatio &&
                mDouble <= _model.maxEarningsRatio) {
              currentRate = mDouble.toString();
              _setRangeSuccess();
            } else {
              setRangeError();
            }
          }
        } else {
          setRangeError();
        }
      },
    );
  }

  Widget _rateInfo() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  WalletLocalizations.of(context).share_rate_unit,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(currentRate,
                    style: TextStyle(fontSize: 16, color: Colors.orange))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Tools.imagePath('share_set_rate_bg')),
                    ),
                  ),
                  child: Text(
                    WalletLocalizations.of(context).share_rate,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Tools.imagePath('share_copy_bg')),
                      ),
                    ),
                    child: Text(WalletLocalizations.of(context).share_copy,
                        style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () {
                    Tools.copyAddress(shareAddress);
                    Tools.showToast(
                        _key,
                        WalletLocalizations.of(context)
                            .order_recharge_tips_copy);
                  },
                )
              ],
            )
          ]),
    );
  }

  void setRangeError() {
    Tools.showToast(
        _key, WalletLocalizations.of(context).share_range_inout_error);
  }

  void _setRangeSuccess() {
    shareAddress = _model.webRegisterUrl +
        '?shareCode=' +
        _model.invitationCode +
        '&shareRato=' +
        currentRate;
    setState(() {
      Navigator.of(context).pop();
    });
  }

  void getRanage() {
    Future future = NetConfig.post(context, NetConfig.shareRatioRanage, {},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_key, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        _model = _shareModel(
            webRegisterUrl: data['webRegisterUrl'],
            invitationCode: data['invitationCode'],
            minEarningsRatio: data['minEarningsRatio'],
            maxEarningsRatio: data['maxEarningsRatio']);
      }
      setState(() {});
    });
  }
}
