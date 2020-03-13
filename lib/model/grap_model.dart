import 'package:flutter/cupertino.dart';

class GrapModel {
  bool grapType;
  double balance;
  String errorMessage;
  double grapNum;
  int orderNum;
  double earningsRatio;
  double grapRatio;
  List<GrapListModel> orderlist;

  GrapModel({
    @required this.grapType,
    @required this.balance,
    @required this.errorMessage,
    @required this.grapNum,
    @required this.orderNum,
    @required this.grapRatio,
    @required this.orderlist,
    @required this.earningsRatio
  });
}

class GrapListModel {
  // id
  int id;

  // 用户id
  int uid;

  //单号
  String grabOrder;

  // 1:抢单成功，待确认；2:用户确认，交易完成
  int grabStatus;

  //金额
  double grabAmount;

  //创建时间
  String created;

  //修改时间
  String updated;

  //备注
  String remarks;

  GrapListModel({
    @required this.id,
    @required this.uid,
    @required this.grabOrder,
    @required this.grabStatus,
    @required this.grabAmount,
    @required this.created,
    @required this.updated,
    @required this.remarks,
});
}
