

import 'package:meta/meta.dart';

class balanceModel  {
//钱包帐号地址
String uid;
String created;
String order;
String remark;
double amount;
int type;

balanceModel({

@required this.created,
@required this.order,
@required this.remark,
@required this.uid,
@required this.amount,
@required this.type,

}) ;
}