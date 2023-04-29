import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF5C11D4);

const List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            'Color index must be >= 0 and < than ${_colorThemes.length}');

  ThemeData darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: _colorThemes[selectedColor]);
  }

  ThemeData lightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: _colorThemes[selectedColor]);
  }
}
