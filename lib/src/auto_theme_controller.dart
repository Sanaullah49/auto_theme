import 'package:flutter/material.dart';

import 'theme_generator.dart';

/// Holds the original theme, the generated opposite theme, and the active mode.
class AutoThemeController extends ChangeNotifier {
  AutoThemeController({
    required ThemeData theme,
    ThemeData? oppositeTheme,
    ThemeMode initialMode = ThemeMode.system,
  }) : _themeMode = initialMode {
    _pair = ThemeGenerator.generatePair(theme, oppositeTheme: oppositeTheme);
  }

  late AutoThemePair _pair;
  ThemeMode _themeMode;

  ThemeData get originalTheme => _pair.source;

  ThemeData get generatedTheme => _pair.generated;

  ThemeData get lightTheme => _pair.light;

  ThemeData get darkTheme => _pair.dark;

  bool get sourceIsLight => _pair.sourceIsLight;

  ThemeMode get themeMode => _themeMode;

  bool get isSystem => _themeMode == ThemeMode.system;

  bool get isLightMode => _themeMode == ThemeMode.light;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) {
      return;
    }
    _themeMode = mode;
    notifyListeners();
  }

  void setLight() => setThemeMode(ThemeMode.light);

  void setDark() => setThemeMode(ThemeMode.dark);

  void setSystem() => setThemeMode(ThemeMode.system);

  void toggle() {
    setThemeMode(
      _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  void updateTheme(ThemeData theme, {ThemeData? oppositeTheme}) {
    _pair = ThemeGenerator.generatePair(theme, oppositeTheme: oppositeTheme);
    notifyListeners();
  }

  void regenerate() {
    _pair = ThemeGenerator.generatePair(_pair.source);
    notifyListeners();
  }
}
