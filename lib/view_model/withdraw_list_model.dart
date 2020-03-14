import 'package:meta/meta.dart';

class withdrawModel  {
  //钱包帐号地址
  String uid;
  String created;
  String withdrawCoin;
  String remark;
  int status;

  withdrawModel({

    @required this.created,
    @required this.withdrawCoin,
    @required this.remark,
    @required this.status,
    @required this.uid,
  }) ;
}