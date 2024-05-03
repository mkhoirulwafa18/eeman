import 'dart:convert';

List<DoaDaily> doaDailyFromJson(String str) => List<DoaDaily>.from(
      // ignore: avoid_dynamic_calls
      json
              .decode(str)
              // ignore: inference_failure_on_untyped_parameter
              .map((doa) => DoaDaily.fromJson(doa as Map<String, dynamic>))
          as Iterable<dynamic>,
    );

String doaDailyToJson(List<DoaDaily> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoaDaily {
  DoaDaily({
    this.id,
    this.title,
    this.arabic,
    this.latin,
    this.translation,
  });

  factory DoaDaily.fromJson(Map<String, dynamic> json) => DoaDaily(
        id: json['id'] as int?,
        title: json['title'] as String?,
        arabic: json['arabic'] as String?,
        latin: json['latin'] as String?,
        translation: json['translation'] as String?,
      );

  int? id;
  String? title;
  String? arabic;
  String? latin;
  String? translation;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'arabic': arabic,
        'latin': latin,
        'translation': translation,
      };
}
