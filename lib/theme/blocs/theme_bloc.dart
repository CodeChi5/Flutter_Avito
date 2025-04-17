import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/theme/blocs/theme_event.dart' as event;
import 'package:myapp/theme/blocs/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<event.ThemeEvent, ThemeState> {
  final SharedPreferences prefs;
  static const String _themeKey = 'theme_mode';

  ThemeBloc({required this.prefs}) : super(const ThemeInitial()) {
    on<event.ThemeChanged>(_onThemeChanged);
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      final themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
      emit(ThemeChanged(themeMode));
    }
  }

  void _onThemeChanged(event.ThemeChanged event, Emitter<ThemeState> emit) {
    emit(ThemeChanged(event.mode));
    prefs.setString(_themeKey, event.mode.toString());
  }
}
