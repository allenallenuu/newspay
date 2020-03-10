import 'package:meta/meta.dart';

class PaymentMethodListModel extends BaseInfo {

  //用户id
  String userid;

  //支付方式
  int id;

  //银行名称
  String bankName;

  //银行卡号
  String bankNumber;

  //银行卡号姓名
  String payee;

  //类型
  int paymentMethod;



  PaymentMethodListModel(
      {String name,
        @required this.userid,
        @required this.id,
        @required this.bankName,
      @required this.bankNumber,
      @required this.payee,
      @required this.paymentMethod})
      : super(name: name);
}

///订单充值
class SellOrder extends BaseInfo{
  double price = 0.0;
  double balance = 0.0;
  double sellNum = 0.0;
  double minimum = 0.0;

  SellOrder(
      {
        String name,
        @required this.price,
        @required this.balance,
        @required this.sellNum,
        @required this.minimum
      }
      );
}


class BaseInfo {
  //名称
  String name;

  BaseInfo({this.name});
}
