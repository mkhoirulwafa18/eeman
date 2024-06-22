import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/extensions/dialog_extension.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';

part '../state/murattal_state.dart';

class MurattalCubit extends Cubit<MurattalState> {
  MurattalCubit() : super(const MurattalInitial([]));

  AudioPlayer player = AudioPlayer();
  late ConcatenatingAudioSource playlist;
  bool errorAlreadyShowed = false;

  void init(BuildContext context, Surah surah) {
    emit(MurattalLoading());
    final audioFileName = List.generate(surah.numberOfVerses ?? 1, (index) {
      final verseNumber = index + 1;
      return AudioSource.uri(
        Uri.parse(
          '$baseAudioUrl/${surah.number.toString().padLeft(3, '0')}${verseNumber.toString().padLeft(3, '0')}.mp3',
        ),
      );
    });

    // Add Bismillah audio if not surah 1
    if (surah.number != 1) {
      audioFileName.insert(0, AudioSource.uri(Uri.parse('$baseAudioUrl/001001.mp3')));
    }

    playlist = ConcatenatingAudioSource(
      shuffleOrder: DefaultShuffleOrder(),
      children: audioFileName,
    );
    emit(MurattalLoaded(audioFileName, player, playlist));

    // Catching errors during playback (e.g. lost network connection)
    player.playbackEventStream.listen(
      (event) {
        if (event.processingState == ProcessingState.completed) {
          emit(MurattalLoaded(audioFileName, player, playlist));
        }
      },
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

      context.showAppDialog(
        title: l10n.internetNeeded,
        content: Text(
          l10n.internetNeededDesc,
          style: context.bodyMedium,
        ),
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
      await player.play();
      await player.stop();
    } on PlayerException catch (e) {
      if (e.message.toString() == 'Source error') {
        context.showAppDialog(
          title: context.l10n.internetNeeded,
          content: Text(
            context.l10n.internetNeededDesc,
            style: context.bodyMedium,
          ),
        );
      }
    }
  }

  Future<void> pause(BuildContext context) async {
    try {
      if (player.playing) {
        emit(MurattalPaused());
        await player.pause();
      } else {
        throw PlayerException(0, 'Source error');
      }
    } on PlayerException catch (e) {
      if (e.message.toString() == 'Source error') {
        context.showAppDialog(
          title: context.l10n.internetNeeded,
          content: Text(
            context.l10n.internetNeededDesc,
            style: context.bodyMedium,
          ),
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
