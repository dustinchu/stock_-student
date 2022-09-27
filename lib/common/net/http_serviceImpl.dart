import 'package:dio/dio.dart';

import 'app_dio.dart';
import 'http_service.dart';

const BASE_URL = "https://clean.storewp.site";
const API_KEY = "Y0p6EXujqm50f2TneYVSLSMKGLley6bnnYsClHj5";
const LOGIN_URL = "/api/v1/auth/login";

class HttpServiceImpl implements HttpService {
  var dio = AppDio.getInstance();

  @override
  Future<Response> LoginPost(String username, String password) async {
    Response response;
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
    };
    FormData formData = FormData.fromMap(body);
    response = await dio.post("/login", data: formData);

    return response;
  }

  @override
  Future<Response> RegisterPost(
      String username, String password, String email) async {
    Response response;
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
      "email": email
    };
    FormData formData = new FormData.fromMap(body);
    response = await dio.post("/register", data: formData);

    return response;
  }
}
