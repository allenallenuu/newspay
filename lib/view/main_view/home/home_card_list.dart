import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:wpay_app/l10n/WalletLocalizations.dart';
import 'package:wpay_app/model/payment_method_info.dart';
import 'package:wpay_app/tools/Tools.dart';
import 'package:wpay_app/tools/app_data_setting.dart';
import 'package:wpay_app/tools/net_config.dart';
import 'package:wpay_app/view/main_view/home/home_edit_card.dart';
import 'package:wpay_app/view_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeCardList extends StatefulWidget {
  static String tag = "HomeCardList";

  @override
  _HomeCardListState createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MainStateModel stateModel = null;
  List<PaymentMethodListModel> paymentMethodInfoes;
  List<PaymentMethodListModel> _paymentMethodInfoes;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  void _onRefresh({int type = 0}) {
    if (type == 1) {
      paymentMethodInfoes = null;
      setState(() {});
    }
    stateModel.setPaymentMethodInfoes(null, rightNow: true);
    paymentMethodInfoes = stateModel.getPaymentMethodInfoes(context);
    if (type == 0) {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (stateModel == null) {
      stateModel = MainStateModel().of(context);
      stateModel.setPaymentMethodInfoes(null);
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: ScopedModelDescendant<MainStateModel>(
          builder: (context, child, model) {
        paymentMethodInfoes = stateModel.getPaymentMethodInfoes(context);
        print(paymentMethodInfoes);
        if (paymentMethodInfoes == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (paymentMethodInfoes.length == 0) {
          return Center(
              child: GestureDetector(
                  onTap: () {
                    this._onRefresh(type: 1);
                  },
                  child: Text(WalletLocalizations.of(context).common_tips_no_data_refresh)));
        }

        _paymentMethodInfoes = [];
        for (var node in paymentMethodInfoes) {
          _paymentMethodInfoes.add(node);
        }

        return refreshView();
      }),
    );
  }

  RefreshController _refreshController;

  Widget refreshView() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
          releaseText:
              WalletLocalizations.of(context).pull_to_refresh_releaseText,
          refreshingText:
              WalletLocalizations.of(context).pull_to_refresh_refreshingText,
          completeText:
              WalletLocalizations.of(context).pull_to_refresh_completeText,
          idleText: WalletLocalizations.of(context).pull_to_refresh_idleText),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
          itemCount: _paymentMethodInfoes.length,
          itemBuilder: (BuildContext context, int index) {
            PaymentMethodListModel dataInfo = _paymentMethodInfoes[index];
            return Container(
                margin: EdgeInsets.only(top: 10),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1)),
                child: InkWell(
                  onTap: () {
//                    this.onClickItem(index);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    elevation: 1.6,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 5,
                                        ),
                                        child: Image.asset(
                                          dataInfo.paymentMethod == 0
                                              ? Tools.imagePath(
                                                  'icon_yinhangka')
                                              : dataInfo.paymentMethod == 1
                                                  ? Tools.imagePath(
                                                      'icon_zhifubao')
                                                  : Tools.imagePath(
                                                      'icon_weixin'),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: AutoSizeText(
                                                WalletLocalizations.of(context).homeCard,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: AutoSizeText(
                                                dataInfo.bankName.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: AutoSizeText(
                                          dataInfo.paymentMethod == 0
                                              ? (dataInfo.bankNumber.length >
                                                      13)
                                                  ? dataInfo.bankNumber
                                                      .replaceRange(
                                                          6,
                                                          dataInfo.bankNumber
                                                                  .length -
                                                              6,
                                                          '...')
                                                  : dataInfo.bankNumber
                                              : dataInfo.payee == null
                                                  ? ""
                                                  : dataInfo.payee,
                                          minFontSize: 9,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 23,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ));
          }),
    );
  }

  //点击item
  void onClickItem(int mainIndex) {
    PaymentMethodListModel clickPaymentMethod = _paymentMethodInfoes[mainIndex];
    if (clickPaymentMethod.paymentMethod == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return HomeEditCard(
          paymentMethodModel: clickPaymentMethod,
        );
      })).then((value) {
        if (value != null && value) {
          this._onRefresh(type: 1);
        }
      });
    }
  }
}
