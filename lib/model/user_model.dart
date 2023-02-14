class UserModel {
  String? message;
  int? code;
  Data? data;

  UserModel({this.message, this.code, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  UserData? userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
  }
}

class UserData {
  Tokens? tokens;
  Userinfo? userinfo;

  UserData({this.tokens, this.userinfo});

  UserData.fromJson(Map<String, dynamic> json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    userinfo =
        json['userinfo'] != null ? Userinfo.fromJson(json['userinfo']) : null;
  }
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}

class Userinfo {
  int? userId;
  String? userEmail;
  String? fullName;
  String? userTelephone;
  String? photoPath;
  String? agency;
  String? role;
  bool? checkedIn;

  Userinfo(
      {this.userId,
      this.userEmail,
      this.fullName,
      this.userTelephone,
      this.photoPath,
      this.agency,
      this.role,
      this.checkedIn});

  Userinfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userEmail = json['userEmail'];
    fullName = json['fullName'];
    userTelephone = json['userTelephone'];
    photoPath = json['photoPath'];
    agency = json['agency'];
    role = json['role'];
    checkedIn = json['checkedIn'];
  }
}
