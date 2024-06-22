// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

// ignore_for_file: constant_identifier_names, inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:convert';

List<Surah> surahFromJson(String str) => List<Surah>.from(
      json.decode(str).map((surah) => Surah.fromJson(surah as Map<String, dynamic>)) as Iterable<dynamic>,
    );

String surahToJson(List<Surah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surah {
  Surah({
    this.number,
    this.sequence,
    this.numberOfVerses,
    this.name,
    this.revelation,
    this.tafsir,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json['number'] as int,
        sequence: json['sequence'] as int,
        numberOfVerses: json['numberOfVerses'] as int,
        name: json['name'] == null ? null : Name.fromJson(json['name'] as Map<String, dynamic>),
        revelation: json['revelation'] == null ? null : Revelation.fromJson(json['revelation'] as Map<String, dynamic>),
        tafsir: json['tafsir'] == null ? null : Tafsir.fromJson(json['tafsir'] as Map<String, dynamic>),
      );
  int? number;
  int? sequence;
  int? numberOfVerses;
  Name? name;
  Revelation? revelation;
  Tafsir? tafsir;

  Map<String, dynamic> toJson() => {
        'number': number,
        'sequence': sequence,
        'numberOfVerses': numberOfVerses,
        'name': name?.toJson(),
        'revelation': revelation?.toJson(),
        'tafsir': tafsir?.toJson(),
      };
}

class Name {
  Name({
    this.short,
    this.long,
    this.transliteration,
    this.translation,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        short: json['short'] as String,
        long: json['long'] as String,
        transliteration: json['transliteration'] == null
            ? null
            : Translation.fromJson(json['transliteration'] as Map<String, dynamic>),
        translation:
            json['translation'] == null ? null : Translation.fromJson(json['translation'] as Map<String, dynamic>),
      );
  String? short;
  String? long;
  Translation? transliteration;
  Translation? translation;

  Map<String, dynamic> toJson() => {
        'short': short,
        'long': long,
        'transliteration': transliteration?.toJson(),
        'translation': translation?.toJson(),
      };
}

class Translation {
  Translation({
    this.en,
    this.id,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json['en'] as String,
        id: json['id'] as String,
      );
  String? en;
  String? id;

  Map<String, dynamic> toJson() => {
        'en': en,
        'id': id,
      };
}

class Revelation {
  Revelation({
    this.arab,
    this.en,
    this.id,
  });

  factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: arabValues.map[json['arab']],
        en: enValues.map[json['en']],
        id: idValues.map[json['id']],
      );
  Arab? arab;
  En? en;
  Id? id;

  Map<String, dynamic> toJson() => {
        'arab': arabValues.reverse[arab],
        'en': enValues.reverse[en],
        'id': idValues.reverse[id],
      };
}

enum Arab { ARAB, EMPTY }

final arabValues = EnumValues({'مدينة': Arab.ARAB, 'مكة': Arab.EMPTY});

enum En { MECCAN, MEDINAN }

final enValues = EnumValues({'Meccan': En.MECCAN, 'Medinan': En.MEDINAN});

enum Id { MADANIYYAH, MAKKIYYAH }

final idValues = EnumValues({'Madaniyyah': Id.MADANIYYAH, 'Makkiyyah': Id.MAKKIYYAH});

class Tafsir {
  Tafsir({
    this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: json['id'] as String,
      );
  String? id;

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    // ignore: join_return_with_assignment
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
