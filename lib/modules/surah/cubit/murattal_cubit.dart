// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';

part 'murattal_state.dart';

class MurattalCubit extends Cubit<MurattalState> {
  MurattalCubit() : super(const MurattalInitial([]));

  AudioPlayer player = AudioPlayer();
  late ConcatenatingAudioSource playlist;
  List<AudioSource> audioFileName = [];
  bool errorAlreadyShowed = false;

  void init(BuildContext context, int indexSurah, int totalAyat) {
    emit(MurattalLoading());
    final a = '${'0' * (3 - indexSurah.toString().length)}$indexSurah';
    final b = List.generate(
      totalAyat,
      (index) => '${'0' * (3 - index.toString().length)}${index + 1}',
      growable: false,
    );

    if (indexSurah != 1) {
      audioFileName.add(
        AudioSource.uri(
          Uri.parse('$baseAudioUrl/001001.mp3'),
        ),
      );
    }
    for (final e in b) {
      audioFileName.add(
        AudioSource.uri(
          Uri.parse('$baseAudioUrl/$a$e.mp3'),
        ),
      );
    }
    playlist = ConcatenatingAudioSource(
      shuffleOrder: DefaultShuffleOrder(),
      children: audioFileName,
    );
    emit(MurattalLoaded(audioFileName, player, playlist));
    // Catching errors during playback (e.g. lost network connection)
    player.playbackEventStream.listen(
      (event) {},
      onError: (Object e) {
        onErrorAudioPlaying(context, e);
      },
    );
  }

  Future<void> onErrorAudioPlaying(BuildContext context, Object e) async {
    final internet = await checkInternetConnection();
    final l10n = context.l10n;
    if (!internet && !errorAlreadyShowed) {
      errorAlreadyShowed = true;
      showMyDialog(
        context,
        l10n.internetNeeded,
        l10n.internetNeededDesc,
      );
    }
    if (e is PlayerException) {
      debugPrint('Error code: ${e.code}');
      debugPrint('Error message: ${e.message}');
    } else {
      debugPrint('An error occurred: $e');
    }
  }

  Future<void> play(BuildContext context) async {
    try {
      final internet = await checkInternetConnection();
      if (internet && !player.playing) {
        await player.setAudioSource(
          playlist,
          initialIndex: 0,
          initialPosition: Duration.zero,
        );
      } else {
        if (!internet) throw PlayerException(0, 'Source error');
      }

      emit(MurattalPlaying());
      debugPrint('PLaayyWEEssdddd');

      debugPrint(state.toString());
      await player.play();
    } on PlayerException catch (e) {
      if (e.message.toString() == 'Source error') {
        showMyDialog(
          context,
          context.l10n.internetNeeded,
          context.l10n.internetNeededDesc,
        );
      }
    }
  }

  Future<void> pause(BuildContext context) async {
    try {
      if (player.playing) {
        emit(MurattalPaused());
        debugPrint('PAUuuusseEdddD');
        debugPrint(state.toString());
        await player.pause();
      } else {
        throw PlayerException(0, 'Source error');
      }
    } on PlayerException catch (e) {
      if (e.message.toString() == 'Source error') {
        showMyDialog(
          context,
          context.l10n.internetNeeded,
          context.l10n.internetNeededDesc,
        );
      }
    }
  }

  void dispose() {
    player
      ..stop()
      ..dispose();
  }
}
