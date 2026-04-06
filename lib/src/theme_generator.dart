import 'package:flutter/material.dart';

import 'color_inverter.dart';

/// A source/generated theme pair.
@immutable
class AutoThemePair {
  const AutoThemePair({
    required this.source,
    required this.generated,
    required this.sourceIsLight,
  });

  final ThemeData source;
  final ThemeData generated;
  final bool sourceIsLight;

  ThemeData get light => sourceIsLight ? source : generated;

  ThemeData get dark => sourceIsLight ? generated : source;
}

/// Generates the opposite theme from a single [ThemeData].
class ThemeGenerator {
  const ThemeGenerator._();

  static AutoThemePair generatePair(
    ThemeData source, {
    ThemeData? oppositeTheme,
  }) {
    final sourceIsLight = ColorInverter.isThemeLight(source);

    return AutoThemePair(
      source: source,
      generated: oppositeTheme ?? _generateTheme(source, sourceIsLight),
      sourceIsLight: sourceIsLight,
    );
  }

  static ThemeData generateOpposite(ThemeData source) {
    return generatePair(source).generated;
  }

  static ThemeData _generateTheme(ThemeData source, bool sourceIsLight) {
    final targetBrightness = sourceIsLight ? Brightness.dark : Brightness.light;
    final generatedScheme = _generateColorScheme(
      source.colorScheme,
      sourceIsLight,
    );

    final scaffoldBackgroundColor = ColorInverter.invertBackgroundColor(
      source.scaffoldBackgroundColor,
      sourceIsLight: sourceIsLight,
    );

    final baseTheme = ThemeData(
      useMaterial3: source.useMaterial3,
      brightness: targetBrightness,
      colorScheme: generatedScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: ColorInverter.invertSurfaceColor(
        source.canvasColor,
        sourceIsLight: sourceIsLight,
      ),
      cardColor: ColorInverter.invertSurfaceColor(
        source.cardColor,
        sourceIsLight: sourceIsLight,
        lifted: true,
      ),
      dividerColor: ColorInverter.invertNeutralColor(
        source.dividerColor,
        sourceIsLight: sourceIsLight,
      ),
      disabledColor: ColorInverter.invertNeutralColor(
        source.disabledColor,
        sourceIsLight: sourceIsLight,
      ),
      focusColor: ColorInverter.invertAccentColor(
        source.focusColor,
        sourceIsLight: sourceIsLight,
      ),
      highlightColor: ColorInverter.invertNeutralColor(
        source.highlightColor,
        sourceIsLight: sourceIsLight,
      ),
      hintColor: ColorInverter.invertNeutralColor(
        source.hintColor,
        sourceIsLight: sourceIsLight,
      ),
      hoverColor: ColorInverter.invertNeutralColor(
        source.hoverColor,
        sourceIsLight: sourceIsLight,
      ),
      shadowColor: source.shadowColor,
      splashColor: ColorInverter.invertNeutralColor(
        source.splashColor,
        sourceIsLight: sourceIsLight,
      ),
      unselectedWidgetColor: ColorInverter.invertNeutralColor(
        source.unselectedWidgetColor,
        sourceIsLight: sourceIsLight,
      ),
      applyElevationOverlayColor: source.applyElevationOverlayColor,
      materialTapTargetSize: source.materialTapTargetSize,
      pageTransitionsTheme: source.pageTransitionsTheme,
      platform: source.platform,
      scrollbarTheme: source.scrollbarTheme,
      splashFactory: source.splashFactory,
      typography: source.typography,
      visualDensity: source.visualDensity,
      extensions: source.extensions.values,
    );

    return baseTheme.copyWith(
      appBarTheme: _invertAppBarTheme(
        source.appBarTheme,
        baseTheme.appBarTheme,
        sourceIsLight,
        generatedScheme,
      ),
      bottomNavigationBarTheme: _invertBottomNavigationBarTheme(
        source.bottomNavigationBarTheme,
        sourceIsLight,
        generatedScheme,
      ),
      bottomSheetTheme: _invertBottomSheetTheme(
        source.bottomSheetTheme,
        baseTheme.bottomSheetTheme,
        sourceIsLight,
      ),
      cardTheme: _invertCardTheme(
        source.cardTheme,
        baseTheme.cardTheme,
        sourceIsLight,
      ),
      checkboxTheme: _invertCheckboxTheme(source.checkboxTheme, sourceIsLight),
      chipTheme: _invertChipTheme(
        source.chipTheme,
        baseTheme.chipTheme,
        sourceIsLight,
        generatedScheme,
      ),
      dialogTheme: _invertDialogTheme(
        source.dialogTheme,
        baseTheme.dialogTheme,
        sourceIsLight,
      ),
      dividerTheme: _invertDividerTheme(
        source.dividerTheme,
        baseTheme.dividerTheme,
        sourceIsLight,
      ),
      drawerTheme: _invertDrawerTheme(
        source.drawerTheme,
        baseTheme.drawerTheme,
        sourceIsLight,
      ),
      elevatedButtonTheme: _invertButtonTheme(
        source.elevatedButtonTheme,
        sourceIsLight,
      ),
      filledButtonTheme: _invertFilledButtonTheme(
        source.filledButtonTheme,
        sourceIsLight,
      ),
      floatingActionButtonTheme: _invertFabTheme(
        source.floatingActionButtonTheme,
        baseTheme.floatingActionButtonTheme,
        sourceIsLight,
      ),
      iconButtonTheme: _invertIconButtonTheme(
        source.iconButtonTheme,
        sourceIsLight,
      ),
      iconTheme: _invertIconTheme(
        source.iconTheme,
        baseTheme.iconTheme,
        sourceIsLight,
        generatedScheme.onSurfaceVariant,
      ),
      inputDecorationTheme: _invertInputDecorationTheme(
        source.inputDecorationTheme,
        baseTheme.inputDecorationTheme,
        sourceIsLight,
        generatedScheme,
      ),
      listTileTheme: _invertListTileTheme(
        source.listTileTheme,
        baseTheme.listTileTheme,
        sourceIsLight,
      ),
      navigationBarTheme: _invertNavigationBarTheme(
        source.navigationBarTheme,
        sourceIsLight,
      ),
      outlinedButtonTheme: _invertOutlinedButtonTheme(
        source.outlinedButtonTheme,
        sourceIsLight,
      ),
      popupMenuTheme: _invertPopupMenuTheme(
        source.popupMenuTheme,
        baseTheme.popupMenuTheme,
        sourceIsLight,
      ),
      primaryIconTheme: _invertIconTheme(
        source.primaryIconTheme,
        baseTheme.primaryIconTheme,
        sourceIsLight,
        generatedScheme.onPrimary,
      ),
      primaryTextTheme: _invertTextTheme(
        source.primaryTextTheme,
        baseTheme.primaryTextTheme,
        sourceIsLight,
        generatedScheme.primary,
        generatedScheme.onPrimary,
      ),
      progressIndicatorTheme: _invertProgressIndicatorTheme(
        source.progressIndicatorTheme,
        baseTheme.progressIndicatorTheme,
        sourceIsLight,
      ),
      radioTheme: _invertRadioTheme(source.radioTheme, sourceIsLight),
      sliderTheme: _invertSliderTheme(
        source.sliderTheme,
        baseTheme.sliderTheme,
        sourceIsLight,
      ),
      snackBarTheme: _invertSnackBarTheme(
        source.snackBarTheme,
        baseTheme.snackBarTheme,
        sourceIsLight,
      ),
      switchTheme: _invertSwitchTheme(source.switchTheme, sourceIsLight),
      tabBarTheme: _invertTabBarTheme(
        source.tabBarTheme,
        baseTheme.tabBarTheme,
        sourceIsLight,
      ),
      textButtonTheme: _invertTextButtonTheme(
        source.textButtonTheme,
        sourceIsLight,
      ),
      textTheme: _invertTextTheme(
        source.textTheme,
        baseTheme.textTheme,
        sourceIsLight,
        generatedScheme.surface,
        generatedScheme.onSurface,
      ),
      tooltipTheme: _invertTooltipTheme(
        source.tooltipTheme,
        baseTheme.tooltipTheme,
        sourceIsLight,
      ),
    );
  }

  static ColorScheme _generateColorScheme(
    ColorScheme source,
    bool sourceIsLight,
  ) {
    final targetBrightness = sourceIsLight ? Brightness.dark : Brightness.light;
    final primary = ColorInverter.invertAccentColor(
      source.primary,
      sourceIsLight: sourceIsLight,
    );
    final secondary = ColorInverter.invertAccentColor(
      source.secondary,
      sourceIsLight: sourceIsLight,
    );
    final tertiary = ColorInverter.invertAccentColor(
      source.tertiary,
      sourceIsLight: sourceIsLight,
    );
    final error = ColorInverter.invertAccentColor(
      source.error,
      sourceIsLight: sourceIsLight,
    );
    final surface = ColorInverter.invertSurfaceColor(
      source.surface,
      sourceIsLight: sourceIsLight,
    );

    final base = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: targetBrightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );

    return base.copyWith(
      primary: primary,
      onPrimary: ColorInverter.bestOnColor(primary),
      secondary: secondary,
      onSecondary: ColorInverter.bestOnColor(secondary),
      tertiary: tertiary,
      onTertiary: ColorInverter.bestOnColor(tertiary),
      error: error,
      onError: ColorInverter.bestOnColor(error),
      surface: surface,
      onSurface: ColorInverter.ensureContrast(
        ColorInverter.invertTextColor(
          source.onSurface,
          sourceIsLight: sourceIsLight,
        ),
        surface,
      ),
      onSurfaceVariant: ColorInverter.ensureContrast(
        ColorInverter.invertTextColor(
          source.onSurfaceVariant,
          sourceIsLight: sourceIsLight,
        ),
        base.surfaceContainerHighest,
      ),
      outline: ColorInverter.invertNeutralColor(
        source.outline,
        sourceIsLight: sourceIsLight,
      ),
      outlineVariant: ColorInverter.invertNeutralColor(
        source.outlineVariant,
        sourceIsLight: sourceIsLight,
      ),
      inverseSurface: source.surface,
      onInverseSurface: source.onSurface,
      inversePrimary: source.primary,
      surfaceTint: primary,
    );
  }

  static TextTheme _invertTextTheme(
    TextTheme source,
    TextTheme fallback,
    bool sourceIsLight,
    Color background,
    Color fallbackColor,
  ) {
    TextStyle? resolveStyle(TextStyle? sourceStyle, TextStyle? fallbackStyle) {
      final baseStyle = sourceStyle ?? fallbackStyle;
      if (baseStyle == null) {
        return null;
      }

      final transformedColor = baseStyle.color != null
          ? ColorInverter.ensureContrast(
              ColorInverter.invertTextColor(
                baseStyle.color!,
                sourceIsLight: sourceIsLight,
              ),
              background,
            )
          : fallbackColor;

      return baseStyle.copyWith(color: transformedColor);
    }

    return TextTheme(
      displayLarge: resolveStyle(source.displayLarge, fallback.displayLarge),
      displayMedium: resolveStyle(source.displayMedium, fallback.displayMedium),
      displaySmall: resolveStyle(source.displaySmall, fallback.displaySmall),
      headlineLarge: resolveStyle(source.headlineLarge, fallback.headlineLarge),
      headlineMedium: resolveStyle(
        source.headlineMedium,
        fallback.headlineMedium,
      ),
      headlineSmall: resolveStyle(source.headlineSmall, fallback.headlineSmall),
      titleLarge: resolveStyle(source.titleLarge, fallback.titleLarge),
      titleMedium: resolveStyle(source.titleMedium, fallback.titleMedium),
      titleSmall: resolveStyle(source.titleSmall, fallback.titleSmall),
      bodyLarge: resolveStyle(source.bodyLarge, fallback.bodyLarge),
      bodyMedium: resolveStyle(source.bodyMedium, fallback.bodyMedium),
      bodySmall: resolveStyle(source.bodySmall, fallback.bodySmall),
      labelLarge: resolveStyle(source.labelLarge, fallback.labelLarge),
      labelMedium: resolveStyle(source.labelMedium, fallback.labelMedium),
      labelSmall: resolveStyle(source.labelSmall, fallback.labelSmall),
    );
  }

  static IconThemeData _invertIconTheme(
    IconThemeData source,
    IconThemeData fallback,
    bool sourceIsLight,
    Color fallbackColor,
  ) {
    final color = source.color != null
        ? ColorInverter.invertTextColor(
            source.color!,
            sourceIsLight: sourceIsLight,
          )
        : fallback.color ?? fallbackColor;

    return source.copyWith(color: color);
  }

  static AppBarThemeData _invertAppBarTheme(
    AppBarThemeData source,
    AppBarThemeData fallback,
    bool sourceIsLight,
    ColorScheme scheme,
  ) {
    final backgroundColor = source.backgroundColor != null
        ? ColorInverter.invertSurfaceColor(
            source.backgroundColor!,
            sourceIsLight: sourceIsLight,
            lifted: true,
          )
        : fallback.backgroundColor ?? scheme.surface;
    final foregroundColor = source.foregroundColor != null
        ? ColorInverter.ensureContrast(
            ColorInverter.invertTextColor(
              source.foregroundColor!,
              sourceIsLight: sourceIsLight,
            ),
            backgroundColor,
          )
        : ColorInverter.bestOnColor(backgroundColor);

    return source.copyWith(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.surfaceTintColor ?? scheme.surfaceTint,
      iconTheme: _invertIconTheme(
        source.iconTheme ?? fallback.iconTheme ?? const IconThemeData(),
        fallback.iconTheme ?? const IconThemeData(),
        sourceIsLight,
        foregroundColor,
      ),
      actionsIconTheme: _invertIconTheme(
        source.actionsIconTheme ??
            fallback.actionsIconTheme ??
            const IconThemeData(),
        fallback.actionsIconTheme ?? const IconThemeData(),
        sourceIsLight,
        foregroundColor,
      ),
      titleTextStyle: _invertStyle(
        source.titleTextStyle ?? fallback.titleTextStyle,
        sourceIsLight,
        backgroundColor,
        foregroundColor,
      ),
      toolbarTextStyle: _invertStyle(
        source.toolbarTextStyle ?? fallback.toolbarTextStyle,
        sourceIsLight,
        backgroundColor,
        foregroundColor,
      ),
    );
  }

  static CardThemeData _invertCardTheme(
    CardThemeData source,
    CardThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      color: source.color != null
          ? ColorInverter.invertSurfaceColor(
              source.color!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : fallback.color,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.surfaceTintColor,
      shadowColor: source.shadowColor ?? fallback.shadowColor,
    );
  }

  static BottomNavigationBarThemeData _invertBottomNavigationBarTheme(
    BottomNavigationBarThemeData source,
    bool sourceIsLight,
    ColorScheme scheme,
  ) {
    return source.copyWith(
      backgroundColor: source.backgroundColor != null
          ? ColorInverter.invertSurfaceColor(
              source.backgroundColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : null,
      selectedItemColor: source.selectedItemColor != null
          ? ColorInverter.invertAccentColor(
              source.selectedItemColor!,
              sourceIsLight: sourceIsLight,
            )
          : scheme.primary,
      unselectedItemColor: source.unselectedItemColor != null
          ? ColorInverter.invertNeutralColor(
              source.unselectedItemColor!,
              sourceIsLight: sourceIsLight,
            )
          : scheme.onSurfaceVariant,
    );
  }

  static NavigationBarThemeData _invertNavigationBarTheme(
    NavigationBarThemeData source,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      backgroundColor: source.backgroundColor != null
          ? ColorInverter.invertSurfaceColor(
              source.backgroundColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : null,
      indicatorColor: source.indicatorColor != null
          ? ColorInverter.invertAccentColor(
              source.indicatorColor!,
              sourceIsLight: sourceIsLight,
            )
          : null,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : null,
    );
  }

  static BottomSheetThemeData _invertBottomSheetTheme(
    BottomSheetThemeData source,
    BottomSheetThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      backgroundColor: source.backgroundColor != null
          ? ColorInverter.invertSurfaceColor(
              source.backgroundColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : fallback.backgroundColor,
      modalBackgroundColor: source.modalBackgroundColor != null
          ? ColorInverter.invertSurfaceColor(
              source.modalBackgroundColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : fallback.modalBackgroundColor,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.surfaceTintColor,
      dragHandleColor: source.dragHandleColor != null
          ? ColorInverter.invertNeutralColor(
              source.dragHandleColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.dragHandleColor,
    );
  }

  static DialogThemeData _invertDialogTheme(
    DialogThemeData source,
    DialogThemeData fallback,
    bool sourceIsLight,
  ) {
    final backgroundColor = source.backgroundColor != null
        ? ColorInverter.invertSurfaceColor(
            source.backgroundColor!,
            sourceIsLight: sourceIsLight,
            lifted: true,
          )
        : fallback.backgroundColor;

    return source.copyWith(
      backgroundColor: backgroundColor,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.surfaceTintColor,
      titleTextStyle: _invertStyle(
        source.titleTextStyle ?? fallback.titleTextStyle,
        sourceIsLight,
        backgroundColor ?? Colors.transparent,
        fallback.titleTextStyle?.color,
      ),
      contentTextStyle: _invertStyle(
        source.contentTextStyle ?? fallback.contentTextStyle,
        sourceIsLight,
        backgroundColor ?? Colors.transparent,
        fallback.contentTextStyle?.color,
      ),
    );
  }

  static DividerThemeData _invertDividerTheme(
    DividerThemeData source,
    DividerThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      color: source.color != null
          ? ColorInverter.invertNeutralColor(
              source.color!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.color,
    );
  }

  static DrawerThemeData _invertDrawerTheme(
    DrawerThemeData source,
    DrawerThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      backgroundColor: source.backgroundColor != null
          ? ColorInverter.invertSurfaceColor(
              source.backgroundColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : fallback.backgroundColor,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.surfaceTintColor,
      shadowColor: source.shadowColor ?? fallback.shadowColor,
    );
  }

  static ElevatedButtonThemeData _invertButtonTheme(
    ElevatedButtonThemeData source,
    bool sourceIsLight,
  ) {
    return source.style == null
        ? source
        : ElevatedButtonThemeData(
            style: _invertButtonStyle(source.style!, sourceIsLight),
          );
  }

  static FilledButtonThemeData _invertFilledButtonTheme(
    FilledButtonThemeData source,
    bool sourceIsLight,
  ) {
    return source.style == null
        ? source
        : FilledButtonThemeData(
            style: _invertButtonStyle(source.style!, sourceIsLight),
          );
  }

  static FloatingActionButtonThemeData _invertFabTheme(
    FloatingActionButtonThemeData source,
    FloatingActionButtonThemeData fallback,
    bool sourceIsLight,
  ) {
    final backgroundColor = source.backgroundColor != null
        ? ColorInverter.invertAccentColor(
            source.backgroundColor!,
            sourceIsLight: sourceIsLight,
          )
        : fallback.backgroundColor;

    return source.copyWith(
      backgroundColor: backgroundColor,
      foregroundColor: source.foregroundColor != null
          ? ColorInverter.bestOnColor(
              backgroundColor ?? source.foregroundColor!,
            )
          : fallback.foregroundColor,
    );
  }

  static IconButtonThemeData _invertIconButtonTheme(
    IconButtonThemeData source,
    bool sourceIsLight,
  ) {
    return source.style == null
        ? source
        : IconButtonThemeData(
            style: _invertButtonStyle(source.style!, sourceIsLight),
          );
  }

  static InputDecorationThemeData _invertInputDecorationTheme(
    InputDecorationThemeData source,
    InputDecorationThemeData fallback,
    bool sourceIsLight,
    ColorScheme scheme,
  ) {
    final fillColor = source.fillColor != null
        ? ColorInverter.invertSurfaceColor(
            source.fillColor!,
            sourceIsLight: sourceIsLight,
            lifted: true,
          )
        : fallback.fillColor;

    return source.copyWith(
      fillColor: fillColor,
      focusColor: source.focusColor != null
          ? ColorInverter.invertAccentColor(
              source.focusColor!,
              sourceIsLight: sourceIsLight,
            )
          : scheme.primary,
      hoverColor: source.hoverColor != null
          ? ColorInverter.invertNeutralColor(
              source.hoverColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.hoverColor,
      iconColor: source.iconColor != null
          ? ColorInverter.invertNeutralColor(
              source.iconColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.iconColor,
      prefixIconColor: source.prefixIconColor != null
          ? ColorInverter.invertNeutralColor(
              source.prefixIconColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.prefixIconColor,
      suffixIconColor: source.suffixIconColor != null
          ? ColorInverter.invertNeutralColor(
              source.suffixIconColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.suffixIconColor,
      labelStyle: _invertStyle(
        source.labelStyle ?? fallback.labelStyle,
        sourceIsLight,
        fillColor ?? scheme.surface,
        scheme.onSurfaceVariant,
      ),
      hintStyle: _invertStyle(
        source.hintStyle ?? fallback.hintStyle,
        sourceIsLight,
        fillColor ?? scheme.surface,
        scheme.onSurfaceVariant,
      ),
      helperStyle: _invertStyle(
        source.helperStyle ?? fallback.helperStyle,
        sourceIsLight,
        fillColor ?? scheme.surface,
        scheme.onSurfaceVariant,
      ),
      errorStyle: _invertStyle(
        source.errorStyle ?? fallback.errorStyle,
        sourceIsLight,
        fillColor ?? scheme.surface,
        scheme.error,
      ),
      border: _invertInputBorder(
        source.border ?? fallback.border,
        sourceIsLight,
      ),
      enabledBorder: _invertInputBorder(
        source.enabledBorder ?? fallback.enabledBorder,
        sourceIsLight,
      ),
      focusedBorder: _invertInputBorder(
        source.focusedBorder ?? fallback.focusedBorder,
        sourceIsLight,
        colorOverride: scheme.primary,
      ),
      errorBorder: _invertInputBorder(
        source.errorBorder ?? fallback.errorBorder,
        sourceIsLight,
        colorOverride: scheme.error,
      ),
      focusedErrorBorder: _invertInputBorder(
        source.focusedErrorBorder ?? fallback.focusedErrorBorder,
        sourceIsLight,
        colorOverride: scheme.error,
      ),
      disabledBorder: _invertInputBorder(
        source.disabledBorder ?? fallback.disabledBorder,
        sourceIsLight,
      ),
    );
  }

  static ListTileThemeData _invertListTileTheme(
    ListTileThemeData source,
    ListTileThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      tileColor: source.tileColor != null
          ? ColorInverter.invertSurfaceColor(
              source.tileColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : fallback.tileColor,
      selectedTileColor: source.selectedTileColor != null
          ? ColorInverter.invertSurfaceColor(
              source.selectedTileColor!,
              sourceIsLight: sourceIsLight,
              lifted: true,
            )
          : fallback.selectedTileColor,
      textColor: source.textColor != null
          ? ColorInverter.invertTextColor(
              source.textColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.textColor,
      iconColor: source.iconColor != null
          ? ColorInverter.invertNeutralColor(
              source.iconColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.iconColor,
      selectedColor: source.selectedColor != null
          ? ColorInverter.invertAccentColor(
              source.selectedColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.selectedColor,
    );
  }

  static OutlinedButtonThemeData _invertOutlinedButtonTheme(
    OutlinedButtonThemeData source,
    bool sourceIsLight,
  ) {
    return source.style == null
        ? source
        : OutlinedButtonThemeData(
            style: _invertButtonStyle(source.style!, sourceIsLight),
          );
  }

  static PopupMenuThemeData _invertPopupMenuTheme(
    PopupMenuThemeData source,
    PopupMenuThemeData fallback,
    bool sourceIsLight,
  ) {
    final backgroundColor = source.color != null
        ? ColorInverter.invertSurfaceColor(
            source.color!,
            sourceIsLight: sourceIsLight,
            lifted: true,
          )
        : fallback.color;

    return source.copyWith(
      color: backgroundColor,
      surfaceTintColor: source.surfaceTintColor != null
          ? ColorInverter.invertAccentColor(
              source.surfaceTintColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.surfaceTintColor,
      textStyle: _invertStyle(
        source.textStyle ?? fallback.textStyle,
        sourceIsLight,
        backgroundColor ?? Colors.transparent,
        fallback.textStyle?.color,
      ),
    );
  }

  static ProgressIndicatorThemeData _invertProgressIndicatorTheme(
    ProgressIndicatorThemeData source,
    ProgressIndicatorThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      color: source.color != null
          ? ColorInverter.invertAccentColor(
              source.color!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.color,
      linearTrackColor: source.linearTrackColor != null
          ? ColorInverter.invertNeutralColor(
              source.linearTrackColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.linearTrackColor,
      circularTrackColor: source.circularTrackColor != null
          ? ColorInverter.invertNeutralColor(
              source.circularTrackColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.circularTrackColor,
    );
  }

  static RadioThemeData _invertRadioTheme(
    RadioThemeData source,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      fillColor: _mapStatePropertyColor(
        source.fillColor,
        sourceIsLight,
        ColorInverter.invertAccentColor,
      ),
      overlayColor: _mapStatePropertyColor(
        source.overlayColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
    );
  }

  static SliderThemeData _invertSliderTheme(
    SliderThemeData source,
    SliderThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      activeTrackColor: source.activeTrackColor != null
          ? ColorInverter.invertAccentColor(
              source.activeTrackColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.activeTrackColor,
      inactiveTrackColor: source.inactiveTrackColor != null
          ? ColorInverter.invertNeutralColor(
              source.inactiveTrackColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.inactiveTrackColor,
      thumbColor: source.thumbColor != null
          ? ColorInverter.invertAccentColor(
              source.thumbColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.thumbColor,
      overlayColor: source.overlayColor != null
          ? ColorInverter.invertNeutralColor(
              source.overlayColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.overlayColor,
      valueIndicatorColor: source.valueIndicatorColor != null
          ? ColorInverter.invertAccentColor(
              source.valueIndicatorColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.valueIndicatorColor,
      valueIndicatorTextStyle: _invertStyle(
        source.valueIndicatorTextStyle ?? fallback.valueIndicatorTextStyle,
        sourceIsLight,
        source.valueIndicatorColor ??
            fallback.valueIndicatorColor ??
            Colors.transparent,
        fallback.valueIndicatorTextStyle?.color,
      ),
    );
  }

  static SnackBarThemeData _invertSnackBarTheme(
    SnackBarThemeData source,
    SnackBarThemeData fallback,
    bool sourceIsLight,
  ) {
    final backgroundColor = source.backgroundColor != null
        ? ColorInverter.invertSurfaceColor(
            source.backgroundColor!,
            sourceIsLight: sourceIsLight,
            lifted: true,
          )
        : fallback.backgroundColor;

    return source.copyWith(
      backgroundColor: backgroundColor,
      contentTextStyle: _invertStyle(
        source.contentTextStyle ?? fallback.contentTextStyle,
        sourceIsLight,
        backgroundColor ?? Colors.transparent,
        fallback.contentTextStyle?.color,
      ),
      actionTextColor: source.actionTextColor != null
          ? ColorInverter.invertAccentColor(
              source.actionTextColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.actionTextColor,
      closeIconColor: source.closeIconColor != null
          ? ColorInverter.invertNeutralColor(
              source.closeIconColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.closeIconColor,
    );
  }

  static SwitchThemeData _invertSwitchTheme(
    SwitchThemeData source,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      thumbColor: _mapStatePropertyColor(
        source.thumbColor,
        sourceIsLight,
        ColorInverter.invertAccentColor,
      ),
      trackColor: _mapStatePropertyColor(
        source.trackColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
      trackOutlineColor: _mapStatePropertyColor(
        source.trackOutlineColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
      overlayColor: _mapStatePropertyColor(
        source.overlayColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
    );
  }

  static CheckboxThemeData _invertCheckboxTheme(
    CheckboxThemeData source,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      fillColor: _mapStatePropertyColor(
        source.fillColor,
        sourceIsLight,
        ColorInverter.invertAccentColor,
      ),
      checkColor: _mapStatePropertyColor(
        source.checkColor,
        sourceIsLight,
        ColorInverter.invertTextColor,
      ),
      overlayColor: _mapStatePropertyColor(
        source.overlayColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
      side: source.side == null
          ? null
          : _invertBorderSide(source.side!, sourceIsLight),
    );
  }

  static ChipThemeData _invertChipTheme(
    ChipThemeData source,
    ChipThemeData fallback,
    bool sourceIsLight,
    ColorScheme scheme,
  ) {
    final backgroundColor = source.backgroundColor != null
        ? ColorInverter.invertSurfaceColor(
            source.backgroundColor!,
            sourceIsLight: sourceIsLight,
            lifted: true,
          )
        : fallback.backgroundColor ?? scheme.surfaceContainerLow;

    return source.copyWith(
      backgroundColor: backgroundColor,
      selectedColor: source.selectedColor != null
          ? ColorInverter.invertAccentColor(
              source.selectedColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.selectedColor,
      disabledColor: source.disabledColor != null
          ? ColorInverter.invertNeutralColor(
              source.disabledColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.disabledColor,
      labelStyle: _invertStyle(
        source.labelStyle ?? fallback.labelStyle,
        sourceIsLight,
        backgroundColor,
        scheme.onSurface,
      ),
      iconTheme: _invertIconTheme(
        source.iconTheme ?? fallback.iconTheme ?? const IconThemeData(),
        fallback.iconTheme ?? const IconThemeData(),
        sourceIsLight,
        scheme.onSurfaceVariant,
      ),
      side: source.side != null
          ? _invertBorderSide(source.side!, sourceIsLight)
          : fallback.side,
    );
  }

  static TabBarThemeData _invertTabBarTheme(
    TabBarThemeData source,
    TabBarThemeData fallback,
    bool sourceIsLight,
  ) {
    return source.copyWith(
      labelColor: source.labelColor != null
          ? ColorInverter.invertTextColor(
              source.labelColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.labelColor,
      unselectedLabelColor: source.unselectedLabelColor != null
          ? ColorInverter.invertNeutralColor(
              source.unselectedLabelColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.unselectedLabelColor,
      indicatorColor: source.indicatorColor != null
          ? ColorInverter.invertAccentColor(
              source.indicatorColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.indicatorColor,
      overlayColor: _mapStatePropertyColor(
        source.overlayColor ?? fallback.overlayColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
      dividerColor: source.dividerColor != null
          ? ColorInverter.invertNeutralColor(
              source.dividerColor!,
              sourceIsLight: sourceIsLight,
            )
          : fallback.dividerColor,
    );
  }

  static TextButtonThemeData _invertTextButtonTheme(
    TextButtonThemeData source,
    bool sourceIsLight,
  ) {
    return source.style == null
        ? source
        : TextButtonThemeData(
            style: _invertButtonStyle(source.style!, sourceIsLight),
          );
  }

  static TooltipThemeData _invertTooltipTheme(
    TooltipThemeData source,
    TooltipThemeData fallback,
    bool sourceIsLight,
  ) {
    final decoration = source.decoration ?? fallback.decoration;
    final backgroundColor = switch (decoration) {
      final BoxDecoration box => box.color,
      _ => null,
    };
    return source.copyWith(
      decoration: switch (decoration) {
        final BoxDecoration box => box.copyWith(
          color: backgroundColor != null
              ? ColorInverter.invertSurfaceColor(
                  backgroundColor,
                  sourceIsLight: sourceIsLight,
                  lifted: true,
                )
              : null,
        ),
        _ => decoration,
      },
      textStyle: _invertStyle(
        source.textStyle ?? fallback.textStyle,
        sourceIsLight,
        backgroundColor ?? Colors.transparent,
        fallback.textStyle?.color,
      ),
    );
  }

  static ButtonStyle _invertButtonStyle(ButtonStyle style, bool sourceIsLight) {
    return style.copyWith(
      backgroundColor: _mapStatePropertyColor(
        style.backgroundColor,
        sourceIsLight,
        ColorInverter.invertAccentColor,
      ),
      foregroundColor: _mapStatePropertyColor(
        style.foregroundColor,
        sourceIsLight,
        ColorInverter.invertTextColor,
      ),
      overlayColor: _mapStatePropertyColor(
        style.overlayColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
      shadowColor: _mapStatePropertyColor(
        style.shadowColor,
        sourceIsLight,
        ColorInverter.invertNeutralColor,
      ),
      surfaceTintColor: _mapStatePropertyColor(
        style.surfaceTintColor,
        sourceIsLight,
        ColorInverter.invertAccentColor,
      ),
      iconColor: _mapStatePropertyColor(
        style.iconColor,
        sourceIsLight,
        ColorInverter.invertTextColor,
      ),
      side: _mapStatePropertyBorderSide(style.side, sourceIsLight),
    );
  }

  static WidgetStateProperty<Color?>? _mapStatePropertyColor(
    WidgetStateProperty<Color?>? property,
    bool sourceIsLight,
    Color Function(Color color, {required bool sourceIsLight}) transform,
  ) {
    if (property == null) {
      return null;
    }

    return WidgetStateProperty.resolveWith((states) {
      final color = property.resolve(states);
      if (color == null) {
        return null;
      }
      return transform(color, sourceIsLight: sourceIsLight);
    });
  }

  static WidgetStateProperty<BorderSide?>? _mapStatePropertyBorderSide(
    WidgetStateProperty<BorderSide?>? property,
    bool sourceIsLight,
  ) {
    if (property == null) {
      return null;
    }

    return WidgetStateProperty.resolveWith((states) {
      final side = property.resolve(states);
      return side == null ? null : _invertBorderSide(side, sourceIsLight);
    });
  }

  static TextStyle? _invertStyle(
    TextStyle? style,
    bool sourceIsLight,
    Color background,
    Color? fallbackColor,
  ) {
    if (style == null) {
      return null;
    }

    final color = style.color != null
        ? ColorInverter.ensureContrast(
            ColorInverter.invertTextColor(
              style.color!,
              sourceIsLight: sourceIsLight,
            ),
            background,
          )
        : fallbackColor;

    return style.copyWith(color: color);
  }

  static InputBorder? _invertInputBorder(
    InputBorder? border,
    bool sourceIsLight, {
    Color? colorOverride,
  }) {
    if (border == null) {
      return null;
    }

    final side = _invertBorderSide(
      border.borderSide,
      sourceIsLight,
      colorOverride: colorOverride,
    );

    if (border is OutlineInputBorder) {
      return border.copyWith(borderSide: side);
    }
    if (border is UnderlineInputBorder) {
      return border.copyWith(borderSide: side);
    }
    return border;
  }

  static BorderSide _invertBorderSide(
    BorderSide side,
    bool sourceIsLight, {
    Color? colorOverride,
  }) {
    return side.copyWith(
      color:
          colorOverride ??
          ColorInverter.invertNeutralColor(
            side.color,
            sourceIsLight: sourceIsLight,
          ),
    );
  }
}
