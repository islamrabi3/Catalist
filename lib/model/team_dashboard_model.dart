class TeamDashboardModel {
  String? message;
  int? code;
  Data? data;

  TeamDashboardModel({this.message, this.code, this.data});

  TeamDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<TeamDashboardModules>? teamDashboardModules;

  Data({this.teamDashboardModules});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['teamDashboardModules'] != null) {
      teamDashboardModules = <TeamDashboardModules>[];
      json['teamDashboardModules'].forEach((v) {
        teamDashboardModules!.add(TeamDashboardModules.fromJson(v));
      });
    }
  }
}

class TeamDashboardModules {
  int? id;
  String? slaname;
  String? imagePath;

  TeamDashboardModules({this.id, this.slaname, this.imagePath});

  TeamDashboardModules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slaname = json['slaname'];
    imagePath = json['imagePath'];
  }
}
