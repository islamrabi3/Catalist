class AttendanceModel {
  String? message;
  int? code;
  Data? data;

  AttendanceModel({this.message, this.code, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<DataList>? dataList;
  int? totalCount;

  Data({this.dataList, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dataList'] != null) {
      dataList = <DataList>[];
      json['dataList'].forEach((v) {
        dataList!.add(DataList.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }
}

class DataList {
  int? id;
  String? userName;
  String? fullName;
  String? attendance;
  String? imgUrl;
  ActionType? actionType;
  String? checkInDate;

  DataList(
      {this.id,
      this.userName,
      this.fullName,
      this.attendance,
      this.imgUrl,
      this.actionType,
      this.checkInDate});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    attendance = json['attendance'];
    imgUrl = json['imgUrl'];
    actionType = json['actionType'] != null
        ? ActionType.fromJson(json['actionType'])
        : null;
    checkInDate = json['checkInDate'];
  }
}

class ActionType {
  dynamic id;
  dynamic value;
  dynamic color;

  ActionType({this.id, this.value, this.color});

  ActionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    color = json['color'];
  }
}
