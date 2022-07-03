
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/StringsConst.dart';

const String base_url = "https://myzoo.asia/api";



class ApiClient {
  static final Dio dio = Dio();
  static final ApiClient _instance = ApiClient._internal();
  static ApiClient get instance => _instance;
  String baseUrl = StringsConst.BASEURL;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  static init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.baseUrl = base_url;
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers = {
    //  HttpHeaders.acceptHeader: "application/json",
      //HttpHeaders.acceptHeader: "application/json",
     "Keydata": 8741214584542,
      //HttpHeaders.contentTypeHeader: "application/json",
      if (prefs.getString("token") != null)
        "Authorization": "Bearer ${prefs.getString("token")}",
    };
    dio.interceptors
        .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
  }

  Future get({required String url, Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(baseUrl+url, queryParameters: params);
      print("my response is ${response.data}");
      return response.data;
    } on DioError {
      return null;
    }
  }

  Future post({required String url, Map<String, dynamic>? body}) async {
    print("workin post 01");
    var formData = FormData.fromMap({
    'mobile_number': '01782084390',
    'password': "12345678",});
    try {
      print("workin post 02");
      final response = await dio.post(baseUrl+url, data: formData,);
      print("my response is ${response.data}");
      return response.data;
    } on DioError {
      return null;
    }
  }

  Future put({required String url, Map<String, dynamic>? body}) async {
    try {
      final response = await dio.put(url, data: body);
      return response.data;
    } on DioError {
      return null;
    }
  }

  Future delete({required String url, Map<String, dynamic>? body}) async {
    try {
      final response = await dio.delete(url, data: body);
      return response.data;
    } on DioError {
      return null;
    }
  }



  Future requestWithFile(
      {required String url,
        Map<String, dynamic>? body,
        required List<File> files}) async {
    try {
      FormData formData = FormData.fromMap(body ?? {});
      for (File file in files) {
        formData.files.add(MapEntry(
            "file",
            await MultipartFile.fromFile(file.path,
                filename: file.path.split("/").last)));
      }
      final response = await dio.post(url, data: formData);
      return response.data;
    } on DioError {
      return null;
    }
  }
}