// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:quran_app/common/common.dart';

class HttpNetworkService extends NetworkService {
  HttpNetworkService();

  @override
  String get baseUrl => 'http://api.aladhan.com/v1';

  @override
  Future<ApiResponse> get(String endpoint) async {
    final res = await http.get(Uri.parse('$baseUrl/$endpoint'));
    Map<String, dynamic> result;
    log(res.toString());
    if (res.statusCode == 200) {
      result = jsonDecode(res.body) as Map<String, dynamic>;

      return ApiResponse(
        success: res.statusCode == 200,
        data: result['data'],
        message: result['status'].toString(),
      );
    } else {
      result = jsonDecode(res.body) as Map<String, dynamic>;
      return ApiResponse(
        success: res.statusCode == 200,
        data: result['data'],
        message: result['data'].toString(),
      );
    }
  }
}
