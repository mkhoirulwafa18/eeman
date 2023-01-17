import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
import 'package:quran_app/themes/app_themes.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc()
      : super(ThemesState(themeData: appThemeData[AppThemes.lightTheme]!)) {
    on<ThemesEvent>((event, emit) {
      if (event is ThemeChanged) {
        emit.call(ThemesState(themeData: appThemeData[event.theme]!));
      }
    });
  }
}
