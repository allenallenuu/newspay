import 'package:flutter/material.dart';

class BalanceModel extends BaseInfo {
  int uid;
  double balance;
  double totalBalance;
  double totalProfit;
  double frozenBalance;
  int id;

  BalanceModel({
    String name,
    @required this.balance,
    @required this.totalBalance,
    @required this.frozenBalance,
    @required this.id,
    @required this.uid,
    @required this.totalProfit,
  }) : super(name: name);
}

class BaseInfo {
  //名称
  String name;

  BaseInfo({this.name});
}
