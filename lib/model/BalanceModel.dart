import 'package:flutter/material.dart';

class BalanceModel extends BaseInfo {
  int uid;
  double balance;
  double totalBalance;
  double totalProfit;
  double frozenBalance;
  bool withdrawPwd;
  int id;

  BalanceModel({
    String name,
    @required this.balance,
    @required this.totalBalance,
    @required this.frozenBalance,
    @required this.id,
    @required this.uid,
    @required this.withdrawPwd,
    @required this.totalProfit,
  }) : super(name: name);
}
////余额
//private Double balance;
////冻结
//private Double frozenBalance;
////应打码
//private Double grapNum;
////已打码
//private Double hasGrapNum;
////自己总代理收益
//private Double totalProfit;
////订单总数
//private Integer totalNum;
////订单成功数
//private Integer successNum;
////订单异常数
//private Integer failNum;
////订单成功率 已乘100
//private Double successRate;

class TradingDataModel extends BaseInfo {
  int uid;
  double balance;
  double frozenBalance;
  double grapNum;
  double totalProfit;
  double hasGrapNum;
  int totalNum;
  int successNum;
  int failNum;
  double successRate;

  TradingDataModel({
    String name,
    @required this.balance,
    @required this.frozenBalance,
    @required this.grapNum,
    @required this.totalProfit,
    @required this.hasGrapNum,
    @required this.successRate,
    @required this.totalNum,
    @required this.successNum,
    @required this.failNum,
    @required this.uid,
  }) : super(name: name);
}
class BaseInfo {
  //名称
  String name;

  BaseInfo({this.name});
}
