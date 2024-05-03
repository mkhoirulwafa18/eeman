import 'package:quran_app/common/domain/api_response.dart';

abstract class NetworkService {
  String get baseUrl;

  Future<ApiResponse> get(String endpoint);
}
