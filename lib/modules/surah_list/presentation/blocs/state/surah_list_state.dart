import 'package:equatable/equatable.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';

abstract class SurahListState extends Equatable {
  const SurahListState();
  @override
  List<Object?> get props => [];
}

class SurahListInitial extends SurahListState {}

class SurahListLoading extends SurahListState {}

class SurahListError extends SurahListState {
  const SurahListError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class SurahListLoaded extends SurahListState {
  const SurahListLoaded({required this.surahList, required this.searchResult});
  final List<Surah> surahList;
  final List<Surah> searchResult;

  @override
  List<Object> get props => [surahList, searchResult];
}
