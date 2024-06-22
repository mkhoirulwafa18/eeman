import 'package:equatable/equatable.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';

abstract class LastReadState extends Equatable {
  const LastReadState();

  @override
  List<Object> get props => [];
}

class LastReadLoaded extends LastReadState {
  const LastReadLoaded(this.verse);
  final Verse verse;

  @override
  List<Object> get props => [verse];
}

class LastReadNotSet extends LastReadState {
  const LastReadNotSet({this.message});
  final String? message;

  @override
  List<Object> get props => [message ?? ''];
}
