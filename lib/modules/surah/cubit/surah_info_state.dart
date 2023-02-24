part of 'surah_info_cubit.dart';

abstract class SurahInfoState extends Equatable {
  const SurahInfoState();

  @override
  List<Object> get props => [];
}

class SurahInfoInitial extends SurahInfoState {
  const SurahInfoInitial({
    required this.ayatSurah,
    required this.tafsirSurah,
    required this.title,
    required this.numberSurah,
    required this.translation,
    required this.revelation,
    required this.totalAyat,
    required this.indexLastSurah,
    required this.indexLastAyah,
  });
  final List<Verse> ayatSurah;
  final Tafsir tafsirSurah;
  final String title;
  final int numberSurah;
  final String translation;
  final Type revelation;
  final int totalAyat;
  final int indexLastSurah;
  final int indexLastAyah;
  @override
  List<Object> get props => [
        ayatSurah,
        tafsirSurah,
        title,
        numberSurah,
        translation,
        revelation,
        totalAyat,
        indexLastSurah,
        indexLastAyah
      ];
}

class SurahInfoLoaded extends SurahInfoInitial {
  const SurahInfoLoaded({
    required super.ayatSurah,
    required super.tafsirSurah,
    required super.title,
    required super.numberSurah,
    required super.translation,
    required super.revelation,
    required super.totalAyat,
    required super.indexLastSurah,
    required super.indexLastAyah,
  });

  @override
  List<Object> get props => [
        ayatSurah,
        tafsirSurah,
        title,
        numberSurah,
        translation,
        revelation,
        totalAyat,
        indexLastSurah,
        indexLastAyah
      ];
}
