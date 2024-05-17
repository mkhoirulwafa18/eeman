// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:equatable/equatable.dart';

class UserPreferences extends Equatable {
  const UserPreferences({
    this.showTranslation = true,
    this.showLatin = true,
    this.arabicFontSize = 24,
    this.translationFontSize = 12,
    this.latinFontSize = 12,
  });
  factory UserPreferences.fromJson(Map<String, dynamic> json) => UserPreferences(
        showTranslation: json['showTranslation'] == null ? true : json['showTranslation'] as bool,
        showLatin: json['showLatin'] == null ? true : json['showLatin'] as bool,
        arabicFontSize: json['arabicFontSize'] == null ? 24 : json['arabicFontSize'] as double,
        translationFontSize: json['translationFontSize'] == null ? 12 : json['translationFontSize'] as double,
        latinFontSize: json['latinFontSize'] == null ? 12 : json['latinFontSize'] as double,
      );

  final bool? showTranslation;
  final bool? showLatin;
  final double? arabicFontSize;
  final double? translationFontSize;
  final double? latinFontSize;

  Map<String, dynamic> toJson() => {
        'showTranslation': showTranslation,
        'showLatin': showLatin,
        'arabicFontSize': arabicFontSize,
        'translationFontSize': translationFontSize,
        'latinFontSize': latinFontSize,
      };

  @override
  List<Object?> get props => [
        showTranslation,
        showLatin,
        arabicFontSize,
        translationFontSize,
        latinFontSize,
      ];
  @override
  String toString() =>
      'UserPreferences{showTranslation: $showTranslation, showLatin: $showLatin, arabicFontSize: $arabicFontSize, translationFontSize: $translationFontSize, latinFontSize: $latinFontSize}';

  UserPreferences copyWith({
    bool? showTranslation,
    bool? showLatin,
    double? arabicFontSize,
    double? translationFontSize,
    double? latinFontSize,
  }) {
    return UserPreferences(
      showTranslation: showTranslation ?? this.showTranslation,
      showLatin: showLatin ?? this.showLatin,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
      translationFontSize: translationFontSize ?? this.translationFontSize,
      latinFontSize: latinFontSize ?? this.latinFontSize,
    );
  }
}
