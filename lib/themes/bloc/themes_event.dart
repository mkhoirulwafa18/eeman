part of 'themes_bloc.dart';

@immutable
abstract class ThemesEvent extends Equatable {}

class ThemeChanged extends ThemesEvent {
  ThemeChanged({required this.theme});

  final AppThemes theme;

  @override
  List<Object?> get props => [theme];
}
