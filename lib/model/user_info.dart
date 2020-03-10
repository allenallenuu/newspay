
class UserInfo {
  String userId;
  String loginToken;
  String faceUrl;
  String nickname;
  String uid;
  double virtualCoinAmount;
//  String shareUid;
  int level;
  int ifBind; //是否绑定
  String inviteCode; //邀请码
  String appShareAddress;
  String webShareAddress;

  String appShareUid;
  String webShareUid;

  int isReal; //0未申请 1申请中 2通过 3 拒绝
  int isPayPwd; //0没有设置密码 1设置了密码
  int isPwd; //0没有设置密码 1设置了密码

  FPUserInfo fpUserInfo;

  UserInfo(
      {this.isReal,
      this.isPayPwd,
      this.isPwd,
      this.userId,
      this.faceUrl,
      this.nickname,
      this.virtualCoinAmount,
      this.uid,
      this.appShareAddress,
      this.webShareAddress});
}

class FPUserInfo {
  String hyperUsername;
  List<String> addresses;

  FPUserInfo({this.hyperUsername, this.addresses});
}

class CodeModel {
  String img;
  String currency;
  int propertyId;

  CodeModel({this.img, this.currency, this.propertyId});
}
