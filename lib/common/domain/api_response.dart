// class ApiResponse {
//   ApiResponse({this.code, this.status, this.data});

//   ApiResponse.fromJson(Map<String, dynamic> json) {
//     code = json['code'] as int?;
//     status = json['status'] as String?;
//     if (json['data'] != null) {
//       data = <PrayerTimeData>[];
//       // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
//       json['data'].forEach((v) {
//         data!.add(PrayerTimeData.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }
//   int? code;
//   String? status;
//   List<PrayerTimeData>? data;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['code'] = code;
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class ApiResponse {
  const ApiResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory ApiResponse.success({dynamic data, String? message}) {
    return ApiResponse(success: true, data: data, message: message);
  }

  factory ApiResponse.error(String message) {
    return ApiResponse(success: false, message: message);
  }

  /// Generic API Response Model.
  final bool success;
  final dynamic data;
  final String? message;
}
