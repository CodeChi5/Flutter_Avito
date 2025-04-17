import 'package:flutter/material.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode mode;
  const ThemeChanged(this.mode);
}
