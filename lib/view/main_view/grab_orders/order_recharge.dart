import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:image_picker/image_picker.dart';
import 'package:wpay_app/model/OrderRechargeModel.dart';
import 'package:wpay_app/tools/WebTools.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class OrderRecharge extends StatefulWidget {
  static String tag = 'OrderRecharge';

  @override
  _OrderRechargeState createState() => _OrderRechargeState();
}

class _OrderRechargeState extends State<OrderRecharge>
    implements OnFileUploadListenerWeb {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String imageUrl = null;
  OrderRechargeModel _model;
  TextEditingController controllerAmount,
      controllerBank,
      controllerName,
      controllerCard;

  @override
  void initState() {
    super.initState();
    controllerAmount = TextEditingController();
    controllerBank = TextEditingController();
    controllerName = TextEditingController();
    controllerCard = TextEditingController();
    getBankInfo();
  }

  @override
  void dispose() {
    super.dispose();
    controllerAmount.dispose();
    controllerBank.dispose();
    controllerName.dispose();
    controllerCard.dispose();
  }

  @override
  onFileUploadCompleteWeb(List<int> file) {
    Tools.loadingAnimation(context);
    NetConfig.updateImageWeb(NetConfig.updateVoucher, 'file', '', file,
        errorCallback: () {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_voucher_error);
    }, callback: (data) {
      Navigator.of(context).pop();
      if (NetConfig.checkData(data)) {
        // change locally data.
        imageUrl = data;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppCustomColor.themeBackgroudGrayColor,
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(WalletLocalizations.of(context).my_page_menu_recharge),
        ),
        body: _model == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _cardInfo(),
                    _amountInput(),
                    myCardView(),
                    updateVoucher(),
                    submitView()
                  ],
                ),
              ));
  }

  Widget _cardInfo() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Color(0xffF34545), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cardInfoItem(
              WalletLocalizations.of(context).order_recharge_payee_name,
              _model == null ? '' : _model.payee),
          _cardInfoItem(
              WalletLocalizations.of(context).order_recharge_payee_account,
              _model == null ? '' : _model.bankNumber),
          _cardInfoItem(
              WalletLocalizations.of(context).order_recharge_payee_bank,
              _model == null ? '' : _model.bankName),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Tools.copyAddress(_model.payee +
                      '  ' +
                      _model.bankNumber +
                      '  ' +
                      _model.bankName);
                  Tools.showToast(_scaffoldKey,
                      WalletLocalizations.of(context).order_recharge_tips_copy);
                },
                child: Text(
                  WalletLocalizations.of(context).order_recharge_copy,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _cardInfoItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(content,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _amountInput() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            WalletLocalizations.of(context).order_recharge_amount,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          inputItemView(true, '￥', '', controllerAmount)
        ],
      ),
    );
  }

  Widget inputItemView(
      bool isBold, String title, String hint, TextEditingController control) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
              height: 50.0,
              child: TextField(
                controller: control,
                maxLines: 1,
                maxLengthEnforced: true,
                style: new TextStyle(color: Colors.black, fontSize: 18.0),
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    counterText: '',
                    hintStyle: new TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    )),
              )),
        )
      ],
    );
  }

  Widget myCardView() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          inputItemView(
              false,
              WalletLocalizations.of(context).order_recharge_my_bank,
              WalletLocalizations.of(context).order_recharge_input_bank,
              controllerBank),
          Divider(),
          inputItemView(
              false,
              WalletLocalizations.of(context).order_recharge_my_name,
              WalletLocalizations.of(context).order_recharge_input_name,
              controllerName),
          Divider(),
          inputItemView(
              false,
              WalletLocalizations.of(context).order_recharge_my_card,
              WalletLocalizations.of(context).order_recharge_input_card,
              controllerCard),
        ],
      ),
    );
  }

  Widget submitView() {
    return InkWell(
      onTap: () {
        submitCard();
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 10),
          padding: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: Color(0xffF34545),
              borderRadius: BorderRadius.circular(90)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(WalletLocalizations.of(context).order_recharge_submit,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          )),
    );
  }

  //上传凭证
  Widget updateVoucher() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            WalletLocalizations.of(context).order_recharge_voucher,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.black),
          ),
          Divider(),
          Row(
            children: <Widget>[
              imageUrl == null
                  ? Container()
                  : kIsWeb ? _avatar_web() : _avatar(),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _bottomSheet();
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: new BoxDecoration(
                      border:
                          new Border.all(color: Color(0xffE9E9E9), width: 0.5)),
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getBankInfo() {
    Future future = NetConfig.post(context, NetConfig.golbalCard, {},
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        List _list = data;
        _model = OrderRechargeModel(
            payee: _list[0]['payee'],
            bankNumber: _list[0]['bankNumber'],
            bankBranch: _list[0]['bankBranch'],
            bankName: _list[0]['bankName']);
      }
      setState(() {});
    });
  }

  void submitCard() {
    if (controllerAmount.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_amount);
      return;
    }
    if (controllerBank.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_bank);
      return;
    }
    if (controllerCard.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_card);
      return;
    }
    if (controllerName.text.isEmpty) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_input_name);
      return;
    }
    if (imageUrl == null) {
      Tools.showToast(_scaffoldKey,
          WalletLocalizations.of(context).order_recharge_update_voucher);
      return;
    }
    Tools.loadingAnimation(context);
    Future future = NetConfig.post(
        context,
        NetConfig.recharge,
        {
          'payee': _model.payee,
          'bankName': _model.bankName,
          'bankBranch': _model.bankBranch,
          'bankNumber': _model.bankNumber,
          'num': controllerAmount.text,
          'transferAccountName': controllerName.text,
          'userBankNumber': controllerCard.text,
          'userBankName': controllerBank.text,
          'rechangeImg': imageUrl,
        },
        timeOut: 10, errorCallback: (msg) {
      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        Tools.showToast(_scaffoldKey,
            WalletLocalizations.of(context).order_recharge_success);
      }
      Navigator.of(context).pop();
      setState(() {});
    });
  }

  //图片上传
  void _bottomSheet() {

    FocusScope.of(context).requestFocus(new FocusNode());
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
                      WalletLocalizations.of(context).imagePickerBottomSheet_1),
                  onTap: () {
                    _getImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text(
                      WalletLocalizations.of(context).imagePickerBottomSheet_2),
                  onTap: () {
                    _getImage(ImageSource.camera);
                  },
                ),
              ],
            );
          });
    }
  }

  _getImage(ImageSource myImageSource) async {
    var image = await ImagePicker.pickImage(source: myImageSource);

    // compress image
    var dir = await path_provider.getTemporaryDirectory();
    var targetPath = dir.absolute.path + "/temp.png";

    Future response =
        Tools.compressImage(image, targetPath, minHeight: 1920, minWidth: 1080);
    response.then((imgCompressed) {
      print('==> GET FILE = $imgCompressed');
      Tools.loadingAnimation(context);
      NetConfig.updateImage(NetConfig.updateVoucher, 'file', '', imgCompressed,
          errorCallback: () {
        Tools.showToast(_scaffoldKey, 'Update avatar fail!');
      }, callback: (data) {
            Navigator.of(context).pop();
        if (NetConfig.checkData(data)) {
          imageUrl = data; // change locally data.
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
      child: Tools.networkImage(imageUrl, width: 70, height: 70),
    );
  }

  Widget _avatar_web() {
    if (imageUrl == null || imageUrl == "") {
      return Image.asset(
        'assets/logo@2x.png',
        width: 70,
        height: 70,
      );
    } else {
      return WebTools.networkImageWeb(NetConfig.imageHost + imageUrl,
          width: 70.0, height: 70.0);
    }
  }
}
