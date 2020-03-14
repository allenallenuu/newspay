class UserInfo {
  String userId;
  String cellphone;
  String loginToken;
  String faceUrl;
  String nickname;
  String uid;
  double virtualCoinAmount;

  String appDownloadAddress;

  String webShareAddress;
  String webShareCode = null;
  String webShareRatio = null;

  FPUserInfo fpUserInfo;

  UserInfo(
      {this.userId,
      this.cellphone,
      this.faceUrl,
      this.nickname,
      this.virtualCoinAmount,
      this.uid,
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
