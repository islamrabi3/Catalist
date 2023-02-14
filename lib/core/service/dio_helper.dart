import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DioHelper {
  static Dio? dio;

  static dioInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://csupervisionapi.catalist-me.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // post method

  static Future<Response> sendDataToApi(
      {required String endPoint,
      Map<String, dynamic>? requestedData,
      String? token}) async {
    return await dio!.post(
      endPoint,
      data: requestedData,
    );
  }

  // get Data From Api

  static Future<Response> getDataFromApi(
      String endPoint, Map<String, dynamic> queries) async {
    return await dio!.get(endPoint, queryParameters: queries);
  }
}
