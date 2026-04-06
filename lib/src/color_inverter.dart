import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Retunes colors so a light theme can become dark and a dark theme can become
/// light while preserving the original hue as much as possible.
class ColorInverter {
  const ColorInverter._();

  static bool isLight(Color color) => color.computeLuminance() >= 0.5;

  static bool isThemeLight(ThemeData theme) {
    if (theme.colorScheme.brightness == Brightness.light) {
      return true;
    }
    if (theme.colorScheme.brightness == Brightness.dark) {
      return false;
    }
    return isLight(theme.scaffoldBackgroundColor);
  }

  static Color invertBackgroundColor(
    Color color, {
    required bool sourceIsLight,
  }) {
    return _retone(
      color,
      sourceIsLight: sourceIsLight,
      darkMin: 0.07,
      darkMax: 0.14,
      lightMin: 0.94,
      lightMax: 0.985,
      darkSaturationFactor: 0.35,
      lightSaturationFactor: 0.65,
    );
  }

  static Color invertSurfaceColor(
    Color color, {
    required bool sourceIsLight,
    bool lifted = false,
  }) {
    final darkMin = lifted ? 0.16 : 0.12;
    final darkMax = lifted ? 0.28 : 0.2;
    final lightMin = lifted ? 0.9 : 0.96;
    final lightMax = lifted ? 0.985 : 0.995;

    return _retone(
      color,
      sourceIsLight: sourceIsLight,
      darkMin: darkMin,
      darkMax: darkMax,
      lightMin: lightMin,
      lightMax: lightMax,
      darkSaturationFactor: 0.45,
      lightSaturationFactor: 0.75,
    );
  }

  static Color invertAccentColor(Color color, {required bool sourceIsLight}) {
    return _retone(
      color,
      sourceIsLight: sourceIsLight,
      darkMin: 0.58,
      darkMax: 0.76,
      lightMin: 0.28,
      lightMax: 0.48,
      darkSaturationFactor: 1.08,
      lightSaturationFactor: 0.96,
    );
  }

  static Color invertTextColor(Color color, {required bool sourceIsLight}) {
    final luminance = color.computeLuminance();
    final alpha = _alpha255(color);

    if (sourceIsLight && luminance < 0.18) {
      return Colors.white.withAlpha(_scaledAlpha(alpha, 0.92));
    }

    if (!sourceIsLight && luminance > 0.82) {
      return Colors.black.withAlpha(_scaledAlpha(alpha, 0.9));
    }

    return _retone(
      color,
      sourceIsLight: sourceIsLight,
      darkMin: 0.82,
      darkMax: 0.97,
      lightMin: 0.06,
      lightMax: 0.2,
      darkSaturationFactor: 0.35,
      lightSaturationFactor: 0.35,
    );
  }

  static Color invertNeutralColor(Color color, {required bool sourceIsLight}) {
    return _retone(
      color,
      sourceIsLight: sourceIsLight,
      darkMin: 0.28,
      darkMax: 0.42,
      lightMin: 0.58,
      lightMax: 0.82,
      darkSaturationFactor: 0.3,
      lightSaturationFactor: 0.3,
    );
  }

  static Color bestOnColor(Color background, {int alpha = 0xFF}) {
    final white = Colors.white.withAlpha(alpha);
    final black = Colors.black.withAlpha(alpha);
    return contrastRatio(white, background) >= contrastRatio(black, background)
        ? white
        : black;
  }

  static Color ensureContrast(
    Color foreground,
    Color background, {
    double minimumRatio = 4.5,
  }) {
    if (contrastRatio(foreground, background) >= minimumRatio) {
      return foreground;
    }

    final hsl = HSLColor.fromColor(foreground);
    final shouldLighten = !isLight(background);
    var lightness = hsl.lightness;

    for (var i = 0; i < 20; i++) {
      lightness = shouldLighten
          ? math.min(1.0, lightness + 0.05)
          : math.max(0.0, lightness - 0.05);
      final candidate = hsl
          .withLightness(lightness)
          .toColor()
          .withAlpha(_alpha255(foreground));
      if (contrastRatio(candidate, background) >= minimumRatio) {
        return candidate;
      }
    }

    return bestOnColor(background, alpha: _alpha255(foreground));
  }

  static double contrastRatio(Color foreground, Color background) {
    final fg = foreground.computeLuminance() + 0.05;
    final bg = background.computeLuminance() + 0.05;
    return fg > bg ? fg / bg : bg / fg;
  }

  static Color _retone(
    Color color, {
    required bool sourceIsLight,
    required double darkMin,
    required double darkMax,
    required double lightMin,
    required double lightMax,
    double darkSaturationFactor = 1,
    double lightSaturationFactor = 1,
  }) {
    final hsl = HSLColor.fromColor(color);
    final normalized = sourceIsLight ? 1 - hsl.lightness : hsl.lightness;
    final min = sourceIsLight ? darkMin : lightMin;
    final max = sourceIsLight ? darkMax : lightMax;
    final saturationFactor = sourceIsLight
        ? darkSaturationFactor
        : lightSaturationFactor;

    final lightness = min + normalized.clamp(0.0, 1.0) * (max - min);
    final saturation = (hsl.saturation * saturationFactor).clamp(0.0, 1.0);

    return hsl
        .withLightness(lightness)
        .withSaturation(saturation)
        .toColor()
        .withAlpha(_alpha255(color));
  }

  static int _scaledAlpha(int alpha, double factor) {
    return (alpha * factor).round().clamp(0, 255);
  }

  static int _alpha255(Color color) {
    return (color.a * 255.0).round().clamp(0, 255);
  }
}
