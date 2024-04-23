import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/local_data/last_read_ayah_local_data.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah/data/domain/verse_model.dart';
import 'package:quran_app/modules/surah/presentation/blocs/state/last_read_state.dart';

class LastReadCubit extends Cubit<LastReadState> {
  LastReadCubit() : super(const LastReadNotSet()) {
    init();
  }

  Future<void> init() async {
    final stringData = await locator<LastReadAyahLocalData>().getValue();
    if (stringData != null) {
      final ayah = Verse.fromMap(jsonDecode(stringData) as Map<String, dynamic>);
      emit(LastReadLoaded(ayah));
    } else {
      emit(const LastReadNotSet(message: 'Last Read Not Set'));
    }
  }

  Future<void> setLastRead(BuildContext context, Verse verse) async {
    await locator<LastReadAyahLocalData>().setValue(jsonEncode(verse.toMap()));
    emit(LastReadLoaded(verse));
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.l10n.setLastReadInfo(verse.verseId.toString())),
        ),
      );
  }
}
