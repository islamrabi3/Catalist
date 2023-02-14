import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/core/globals.dart';
import 'package:supervisor/core/service/cache_helper.dart';
import 'package:supervisor/core/service/dio_helper.dart';
import 'package:supervisor/core/service/location_model.dart';
import 'package:supervisor/model/attendance_model.dart';
import 'package:supervisor/model/team_dashboard_model.dart';
import 'package:supervisor/model/user_dashboard.dart';
import 'package:supervisor/model/user_model.dart';
import 'package:supervisor/screens/attendance_screen.dart';
import 'package:supervisor/screens/team_dashboard.dart';
import 'package:supervisor/screens/user_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStats> {
  AppCubit() : super(InitState());

  static BlocProvider get(BuildContext context) => BlocProvider.of(context);

  // image picker method

  File? file;

  Future<void> getEmployeeImage({ImageSource? imageSource}) async {
    final image = await ImagePicker().pickImage(source: imageSource!);
    emit(AppLoadingState());
    if (image != null) {
      file = File(image.path);
      emit(AppSuccessState());
    } else {
      print('No Image Selected');
      emit(AppErrorState());
    }
  }

  //get current location
  double? latitude;
  double? longitude;
  getCurrentLocation() {
    emit(AppLocationLoadingState());
    LocationModel.getLocationMethod().then((value) {
      latitude = value!.latitude;
      longitude = value.longitude;
      emit(AppLocationSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(AppLocationErrorState());
    });
  }
// empty token

  Future<void> tokenEmpty() async {
    CacheHelper.prefs!.remove('token');
    emit(AppSuccessState());
  }

  // login Method
  UserModel? userModel;
  Future<UserModel> loginMethod(
      {required String name,
      required String password,
      required int langID,
      BuildContext? context}) async {
    try {
      emit(AppPostMethodLoadingState());
      var response = await DioHelper.sendDataToApi(
          endPoint: 'api/SupervisorLogin/Login',
          requestedData: {
            'userName': name,
            'password': password,
            'langID': langID
          });
      globalLangId = langID;
      userModel = UserModel.fromJson(response.data);

      CacheHelper.prefs!.setString(
          'token', '${userModel!.data!.userData!.tokens!.accessToken}');
      CacheHelper.prefs!.setInt('landID', langID);
      emit(AppPostMethodSuccessState());
      return Future.value(userModel);
    } catch (e) {
      throw e.toString();
    }
  }

  // send Check in Data
  Future<Response> sendCheckInData({
    int? userId,
    double? userLatitude,
    double? userLongitude,
    String? photoPath,
    String? comment,
  }) async {
    try {
      emit(AppLoadingState());
      var response = await DioHelper.sendDataToApi(
          endPoint: 'api/User/InsertUserCheckIn',
          requestedData: {
            "userID": userId,
            "userLatitude": userLatitude ?? 0,
            "userLongitude": userLongitude ?? 0,
            "photoPath": "Images/Supervisor/Supervisor/$photoPath",
            "comment": comment
          });
      globalUserId = userId!;
      CacheHelper.prefs!.setInt('userID', userId);
      emit(AppSuccessState());
      return Future.value(response);
    } catch (e) {
      throw e.toString();
    }
  }

  // bottom navigation screens list /
  List<Map<String, dynamic>> screens = [
    {'title': 'User Dashboard', 'screen': const UserDashboard()},
    {'title': 'Team Dashboard', 'screen': const TeamScreen()},
    {'title': 'Attendance Filtration', 'screen': AttendanceScreen()},
  ];

  // Screen Titles

  int currentScreenIndex = 0;
  // toggle screen method
  screenToggle(int index) {
    currentScreenIndex = index;
    emit(AppSuccessState());
  }

  // get user Dashboard data

  UserDashboardModel? userDashboardModel;

  Future<UserDashboardModel> getUserDashboardData() async {
    try {
      emit(AppErrorState());
      var response = await DioHelper.getDataFromApi(
          'api/Supervisors/MainDashboard', {
        'UserId': globalUserId ?? 7,
        'LangId': CacheHelper.prefs!.getInt('landID') ?? 1
      });
      userDashboardModel = UserDashboardModel.fromJson(response.data);

      emit(AppSuccessState());
      return Future.value(userDashboardModel);
    } catch (e) {
      emit(AppErrorState());
      throw e.toString();
    }
  }

// get team DashBoard Data
  TeamDashboardModel? teamDashboardModel;

  Future<TeamDashboardModel> getTeamDashboardData() async {
    try {
      emit(AppErrorState());
      var response = await DioHelper.getDataFromApi(
          'api/Supervisors/TeamDashboard',
          {'UserId': globalUserId ?? 7, 'LangId': globalLangId});
      teamDashboardModel = TeamDashboardModel.fromJson(response.data);
      // print(response.data);
      emit(AppSuccessState());
      return Future.value(teamDashboardModel);
    } catch (e) {
      emit(AppErrorState());
      throw e.toString();
    }
  }

  // Attendace Post Method

  AttendanceModel? attendanceModel;
  Future<AttendanceModel> getAttendanceMethod({
    int? pageNumber,
    int? pageSize,
    List? childIds,
    List? roleIds,
    String? startDate,
    String? endDate,
    int? userId,
  }) async {
    try {
      emit(AttendanceMethodLoadingState());
      var response = await DioHelper.sendDataToApi(
          endPoint: 'api/Supervisors/TeamAttendance',
          requestedData: {
            "pageNumber": pageNumber,
            "pageSize": pageSize,
            "childIDs": [],
            "roleIDs": [],
            "startDate": "2023-02-03T16:52:45.638Z",
            "endDate": "2023-02-03T16:52:45.638Z",
            "userID": userId
          });

      attendanceModel = AttendanceModel.fromJson(response.data);
      emit(AttendanceMethodSuccessState());
      return Future.value(attendanceModel);
    } catch (e) {
      emit(AttendanceMethodErrorState());
      throw e.toString();
    }
  }
}
