import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wpay_app/model/payment_method_info.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class PaymentMethodModel extends Model {
  List<PaymentMethodListModel> _paymentMethodInfoes;

  SellOrder _sellOrderModel;

  PaymentMethodListModel _currPaymentMethodInfo;

  PaymentMethodListModel get currPaymentMethodInfo {
    return _currPaymentMethodInfo;
  }

  setPaymentMethodInfoes(List<PaymentMethodListModel> info,
      {bool rightNow = false}) {
    if (rightNow) {
      this._paymentMethodInfoes = info;
    } else {
      if (info == null && _loadLastTime != null) {
        var now = DateTime.now();
        var duration = now.difference(_loadLastTime);
        if (duration.inSeconds > 15) {
          this._paymentMethodInfoes = null;
        }
      } else {
        this._paymentMethodInfoes = info;
      }
    }
  }

  DateTime _loadLastTime = null;

  List<PaymentMethodListModel> getPaymentMethodInfoes(BuildContext context) {
    if (this._paymentMethodInfoes == null) {
      Future future = NetConfig.post(
          context, NetConfig.GetPaymentMethodList, {},
          timeOut: 10);
      future.then((data) {
        if (NetConfig.checkData(data)) {
          print('GetPaymentMethodList = $data');
          this._paymentMethodInfoes = [];
          _loadLastTime = DateTime.now();

          List list = data;
          for (int i = 0; i < list.length; i++) {
            PaymentMethodListModel info = PaymentMethodListModel(
                userid: list[i]['userid'],
                id: list[i]['id'],
                bankName: list[i]['bankName'],
                bankNumber: list[i]['bankNumber'],
                payee: list[i]['payee'],
                paymentMethod: list[i]['paymentMethod']);
            this._paymentMethodInfoes.add(info);
          }
          notifyListeners();
        } else {
          this._paymentMethodInfoes = [];
          notifyListeners();
        }
      });
    }

    return this._paymentMethodInfoes;
  }

  //获取单价
//  SellOrder getServiceUnit(BuildContext context, String propertyId) {
//    if (this._sellOrderModel == null) {
//      Future future = NetConfig.post(
//          context, NetConfig.GetServiceFee, {'propertyId': propertyId},
//          timeOut: 10);
//      future.then((data) {
//        if (NetConfig.checkData(data)) {
//          _loadLastTime = DateTime.now();
//
//          _sellOrderModel = SellOrder(
//              price: data['price'],
//              balance: data['balance'],
//              sellNum: data['sellNum'],
//              minimum: data['minimum']);
//
//          notifyListeners();
//        }
//      });
//    }
//    return this._sellOrderModel;
//  }

  setInit() {
    setPaymentMethodInfoes(null, rightNow: true);
    _sellOrderModel = null;
  }
}
