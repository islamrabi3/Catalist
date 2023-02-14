class UserDashboardModel {
  String? message;
  int? code;
  Data? data;

  UserDashboardModel({this.message, this.code, this.data});

  UserDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<MainDashboardModules>? mainDashboardModules;

  Data({this.mainDashboardModules});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['mainDashboardModules'] != null) {
      mainDashboardModules = <MainDashboardModules>[];
      json['mainDashboardModules'].forEach((v) {
        mainDashboardModules!.add(MainDashboardModules.fromJson(v));
      });
    }
  }
}

class MainDashboardModules {
  int? id;
  String? slaname;
  String? imagePath;

  MainDashboardModules({this.id, this.slaname, this.imagePath});

  MainDashboardModules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slaname = json['slaname'];
    imagePath = json['imagePath'];
  }
}
