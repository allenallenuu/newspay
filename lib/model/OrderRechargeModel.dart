import 'package:flutter/cupertino.dart';

class OrderRechargeModel{
  String payee;
  String bankNumber;
  String bankBranch;
  String bankName;

  OrderRechargeModel({
    @required this.payee,
    @required this.bankNumber,
    @required this.bankBranch,
    @required this.bankName,
});

}