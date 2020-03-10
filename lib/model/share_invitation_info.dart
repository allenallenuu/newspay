import 'package:meta/meta.dart';

///分享列表
class ShareInvitationListModelItem extends BaseInfo {
  String id;

  String nickname;

  String faceUrl;

  double coinSum;

  double agencyCoinSum;

  int agencyLevel;

  double totalCoin;

  ShareInvitationListModelItem({
    String name,
    @required this.totalCoin,
    @required this.id,
    @required this.nickname,
    @required this.faceUrl,
    @required this.coinSum,
    @required this.agencyCoinSum,
    @required this.agencyLevel,
  }) : super(name: name);
}

class ShareInvitationListModel extends BaseInfo {
  double totalCoin;
  List<ShareInvitationListModelItem> data;

  ShareInvitationListModel(
      {String name, @required this.totalCoin, @required this.data})
      : super(name: name);
}

/// 可用余额
class ShareInvitationAvailable extends BaseInfo {
  double shareCoin;
  double totalCoin;
  double withdrawCoin;
  int success;
  String error;

  ShareInvitationAvailable(
      {String name,
      @required this.shareCoin,
      @required this.totalCoin,
      @required this.withdrawCoin,
      @required this.success,
      this.error})
      : super(name: name);
}

///代理比例
class ShareAgentScale extends BaseInfo {
  int level;
  double scale1 = 0.00;
  double scale2 = 0.00;
  double scale3 = 0.00;
  double secondScale1 = 0.00;
  double secondScale2 = 0.00;
  int id1;
  int id2;
  int id3;
  int secondId1;
  int secondId2;

  ShareAgentScale({
    String name,
    @required this.level,
    @required this.scale1,
    @required this.scale2,
    @required this.scale3,
    @required this.secondScale1,
    @required this.secondScale2,
    @required this.id1,
    @required this.id2,
    @required this.id3,
    @required this.secondId1,
    @required this.secondId2,
  }) : super(name: name);
}

///提现记录
class ShareInvitationRecord extends BaseInfo {
  String userId;
  double withdrawCoin;
  int status;
  String withdrawTime;

  ShareInvitationRecord(
      {String name,
      @required this.userId,
      @required this.withdrawCoin,
      @required this.status,
      @required this.withdrawTime})
      : super(name: name);
}

class ShareReceiveModel extends BaseInfo {
  String shareAddress;

  ShareReceiveModel({String name, @required this.shareAddress})
      : super(name: name);
}

class BaseInfo {
  //名称
  String name;

  BaseInfo({this.name});
}
