import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiangdan_app/model/BalanceModel.dart';
import 'package:qiangdan_app/view_model/state_lib.dart';

class UserInfoTradingData extends StatefulWidget {
  static String tag = 'UserInfoTradingData';

  @override
  _UserInfoTradingDataState createState() => _UserInfoTradingDataState();
}

class _UserInfoTradingDataState extends State<UserInfoTradingData> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TradingDataModel _balanceModel;

  @override
  void initState() {
    // TODO: implement initState
    getWithdraw();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppCustomColor.themeBackgroudGrayColor,
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(WalletLocalizations.of(context)
              .my_page_server_income),
        ),
        body: _balanceModel == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _withdrawInfo(),
              _tradingDataInfo()
            ],
          ),
        ));
  }

  Widget _withdrawInfo() {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Color(0xffF34545), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cardInfoItem(
              WalletLocalizations.of(context).withdraw_balance,
              _balanceModel == null ? '' : _balanceModel.balance.toString()),
        ],
      ),
    );
  }
  Widget _cardInfoItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: 5,),
        Text(content,
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
  Widget _tradingDataInfo() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 25,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical:18 ),
//            padding: EdgeInsets.only(top: 18,bottom: 18),
            child: Text(WalletLocalizations.of(context)
                .order_order_detail,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
          ),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_grap, _balanceModel.grapNum.toString(),true),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_hasGrap, _balanceModel.hasGrapNum.toString(),true),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_frozenBalance, _balanceModel.frozenBalance.toString(),true),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_totalProfit, _balanceModel.totalProfit.toString(),true),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_total, _balanceModel.totalNum.toString(),false),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_success, _balanceModel.successNum.toString(),false),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_fail, _balanceModel.failNum.toString(),false),
          SizedBox(height: 10,),
          _tradingInfoItem(WalletLocalizations.of(context)
              .order_order_successRate, _balanceModel.successRate.toString(),false),
          SizedBox(height: 10,),


        ],
      ),
    );
  }
  Widget _tradingInfoItem(String title, String content, bool isMoney) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),

        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.only(right: 20),
          child: Text(isMoney ? '￥ ' + content : content,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffF34545),
              fontWeight: FontWeight.bold)),
        ),

      ],
    );
  }
  void getWithdraw() {
    Future future =
    NetConfig.post(context, NetConfig.profitData, {}, timeOut: 10,errorCallback: (msg) {

      Tools.showToast(_scaffoldKey, msg);
    });
    future.then((data) {
      if (NetConfig.checkData(data)) {
        print("profitData======= $data");

        _balanceModel = TradingDataModel(
          balance: double.parse(data['balance'].toString()),
          grapNum: double.parse(data['grapNum'].toString()),
          frozenBalance: double.parse(data['frozenBalance'].toString()),
          totalProfit: double.parse(data['totalProfit'].toString()),
          hasGrapNum: double.parse(data['hasGrapNum'].toString()),
          successRate: double.parse(data['successRate'].toString()),
          totalNum: data['totalNum'],
          successNum: data['successNum'],
          failNum: data['failNum'],

        );

      }else {
        print("profitData2======= $data");

      }
      setState(() {});
    });
  }
}