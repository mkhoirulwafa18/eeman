part of 'surah_info_cubit.dart';

abstract class SurahInfoState extends Equatable {
  const SurahInfoState();

  @override
  List<Object> get props => [];
}

class SurahInfoInitial extends SurahInfoState {
  const SurahInfoInitial({
    required this.ayatSurah,
    required this.title,
    required this.numberSurah,
    required this.translation,
    required this.revelation,
    required this.totalAyat,
    required this.lastReadAyat,
  });
  final List<Verse> ayatSurah;
  final String title;
  final int numberSurah;
  final String translation;
  final Type revelation;
  final int totalAyat;
  final int lastReadAyat;
  @override
  List<Object> get props => [
        ayatSurah,
        title,
        numberSurah,
        translation,
        revelation,
        totalAyat,
        lastReadAyat
      ];
}

class SurahInfoLoaded extends SurahInfoInitial {
  const SurahInfoLoaded({
    required super.ayatSurah,
    required super.title,
    required super.numberSurah,
    required super.translation,
    required super.revelation,
    required super.totalAyat,
    required super.lastReadAyat,
  });
}
