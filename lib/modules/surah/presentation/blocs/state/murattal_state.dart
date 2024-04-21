part of '../cubit/murattal_cubit.dart';

abstract class MurattalState extends Equatable {
  const MurattalState();

  @override
  List<Object> get props => [];
}

class MurattalInitial extends MurattalState {
  const MurattalInitial(this.data);

  final List<AudioSource> data;
  @override
  List<Object> get props => [data];
}

class MurattalLoading extends MurattalState {}

class MurattalPlaying extends MurattalState {}

class MurattalPaused extends MurattalState {}

class MurattalLoaded extends MurattalInitial {
  const MurattalLoaded(super.data, this.player, this.playlist);
  final AudioPlayer player;
  final ConcatenatingAudioSource playlist;
}

class MurattalError extends MurattalInitial {
  const MurattalError(super.data, this.error);

  final String error;
}
