import 'package:dio/dio.dart';

abstract class HttpService {
  Future<Response> LoginPost(String username, String password);
}
