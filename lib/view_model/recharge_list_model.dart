import 'package:meta/meta.dart';

class recordModel  {
  //钱包帐号地址
  String uid;
  String created;
  String num;
  String remark;
  int status;

  recordModel({

    @required this.created,
    @required this.num,
    @required this.remark,
    @required this.status,
    @required this.uid,
  }) ;
}