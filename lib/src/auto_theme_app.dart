import 'package:flutter/material.dart';

import 'auto_theme_controller.dart';

/// Strategy used to handle colors that are hardcoded directly in widgets
/// instead of coming from ThemeData.
enum HardcodedColorStrategy {
  /// Only theme-driven colors are translated.
  none,

  /// Applies an app-wide color filter when the opposite mode is active.
  ///
  /// This is best-effort and can affect images and branded assets.
  colorFilter,
}

class _AutoThemeScope extends InheritedNotifier<AutoThemeController> {
  const _AutoThemeScope({
    required AutoThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static AutoThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_AutoThemeScope>();
    assert(
      scope != null,
      'No AutoThemeApp found in context. Wrap your app with AutoThemeApp.',
    );
    return scope!.notifier!;
  }

  static AutoThemeController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AutoThemeScope>()
        ?.notifier;
  }
}

/// Wraps your app and automatically provides a generated opposite theme.
class AutoThemeApp extends StatefulWidget {
  const AutoThemeApp({
    super.key,
    this.theme,
    this.oppositeTheme,
    this.initialThemeMode = ThemeMode.system,
    this.hardcodedColorStrategy = HardcodedColorStrategy.none,
    this.hardcodedColorFilterStrength = 1,
    this.builder,
    this.child,
  }) : _title = '',
       _navigatorKey = null,
       _home = null,
       _routes = const <String, WidgetBuilder>{},
       _initialRoute = null,
       _onGenerateRoute = null,
       _onUnknownRoute = null,
       _navigatorObservers = const <NavigatorObserver>[],
       _locale = null,
       _localizationsDelegates = null,
       _supportedLocales = const <Locale>[Locale('en', 'US')],
       _debugShowCheckedModeBanner = true,
       _showPerformanceOverlay = false,
       _showSemanticsDebugger = false,
       _debugShowMaterialGrid = false,
       _scrollBehavior = null,
       _themeAnimationDuration = kThemeAnimationDuration,
       _themeAnimationCurve = Curves.linear,
       _isMaterialApp = false,
       assert(
         builder != null || child != null,
         'Provide either builder or child.',
       );

  const AutoThemeApp.materialApp({
    super.key,
    this.theme,
    this.oppositeTheme,
    this.initialThemeMode = ThemeMode.system,
    this.hardcodedColorStrategy = HardcodedColorStrategy.none,
    this.hardcodedColorFilterStrength = 1,
    String title = '',
    GlobalKey<NavigatorState>? navigatorKey,
    Widget? home,
    Map<String, WidgetBuilder> routes = const <String, WidgetBuilder>{},
    String? initialRoute,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
    bool debugShowCheckedModeBanner = true,
    bool showPerformanceOverlay = false,
    bool showSemanticsDebugger = false,
    bool debugShowMaterialGrid = false,
    ScrollBehavior? scrollBehavior,
    Duration themeAnimationDuration = kThemeAnimationDuration,
    Curve themeAnimationCurve = Curves.linear,
  }) : builder = null,
       child = null,
       _title = title,
       _navigatorKey = navigatorKey,
       _home = home,
       _routes = routes,
       _initialRoute = initialRoute,
       _onGenerateRoute = onGenerateRoute,
       _onUnknownRoute = onUnknownRoute,
       _navigatorObservers = navigatorObservers,
       _locale = locale,
       _localizationsDelegates = localizationsDelegates,
       _supportedLocales = supportedLocales,
       _debugShowCheckedModeBanner = debugShowCheckedModeBanner,
       _showPerformanceOverlay = showPerformanceOverlay,
       _showSemanticsDebugger = showSemanticsDebugger,
       _debugShowMaterialGrid = debugShowMaterialGrid,
       _scrollBehavior = scrollBehavior,
       _themeAnimationDuration = themeAnimationDuration,
       _themeAnimationCurve = themeAnimationCurve,
       _isMaterialApp = true;

  /// Source theme. If omitted, a default light Material 3 theme is used.
  final ThemeData? theme;
  final ThemeData? oppositeTheme;
  final ThemeMode initialThemeMode;
  final HardcodedColorStrategy hardcodedColorStrategy;

  /// Blend factor between identity (0) and full fallback filter (1).
  ///
  /// Used only when [hardcodedColorStrategy] is [HardcodedColorStrategy.colorFilter].
  final double hardcodedColorFilterStrength;
  final Widget Function(
    BuildContext context,
    ThemeData lightTheme,
    ThemeData darkTheme,
    ThemeMode themeMode,
  )?
  builder;
  final Widget? child;

  final String _title;
  final GlobalKey<NavigatorState>? _navigatorKey;
  final Widget? _home;
  final Map<String, WidgetBuilder> _routes;
  final String? _initialRoute;
  final RouteFactory? _onGenerateRoute;
  final RouteFactory? _onUnknownRoute;
  final List<NavigatorObserver> _navigatorObservers;
  final Locale? _locale;
  final Iterable<LocalizationsDelegate<dynamic>>? _localizationsDelegates;
  final Iterable<Locale> _supportedLocales;
  final bool _debugShowCheckedModeBanner;
  final bool _showPerformanceOverlay;
  final bool _showSemanticsDebugger;
  final bool _debugShowMaterialGrid;
  final ScrollBehavior? _scrollBehavior;
  final Duration _themeAnimationDuration;
  final Curve _themeAnimationCurve;
  final bool _isMaterialApp;

  static AutoThemeController of(BuildContext context) {
    return _AutoThemeScope.of(context);
  }

  static AutoThemeController? maybeOf(BuildContext context) {
    return _AutoThemeScope.maybeOf(context);
  }

  @override
  State<AutoThemeApp> createState() => _AutoThemeAppState();
}

class _AutoThemeAppState extends State<AutoThemeApp> {
  late final AutoThemeController _controller;
  late ThemeData _sourceTheme;

  @override
  void initState() {
    super.initState();
    _sourceTheme = _resolveSourceTheme(widget.theme);
    _controller = AutoThemeController(
      theme: _sourceTheme,
      oppositeTheme: widget.oppositeTheme,
      initialMode: widget.initialThemeMode,
    );
  }

  @override
  void didUpdateWidget(covariant AutoThemeApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme ||
        oldWidget.oppositeTheme != widget.oppositeTheme) {
      _sourceTheme = _resolveSourceTheme(widget.theme);
      _controller.updateTheme(
        _sourceTheme,
        oppositeTheme: widget.oppositeTheme,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AutoThemeScope(
      controller: _controller,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          late final Widget appChild;

          if (widget._isMaterialApp) {
            appChild = MaterialApp(
              title: widget._title,
              navigatorKey: widget._navigatorKey,
              home: widget._home,
              routes: widget._routes,
              initialRoute: widget._initialRoute,
              onGenerateRoute: widget._onGenerateRoute,
              onUnknownRoute: widget._onUnknownRoute,
              navigatorObservers: widget._navigatorObservers,
              theme: _controller.lightTheme,
              darkTheme: _controller.darkTheme,
              themeMode: _controller.themeMode,
              locale: widget._locale,
              localizationsDelegates: widget._localizationsDelegates,
              supportedLocales: widget._supportedLocales,
              debugShowCheckedModeBanner: widget._debugShowCheckedModeBanner,
              showPerformanceOverlay: widget._showPerformanceOverlay,
              showSemanticsDebugger: widget._showSemanticsDebugger,
              debugShowMaterialGrid: widget._debugShowMaterialGrid,
              scrollBehavior: widget._scrollBehavior,
              themeAnimationDuration: widget._themeAnimationDuration,
              themeAnimationCurve: widget._themeAnimationCurve,
            );
          } else if (widget.builder != null) {
            appChild = Builder(
              builder: (innerContext) {
                return widget.builder!(
                  innerContext,
                  _controller.lightTheme,
                  _controller.darkTheme,
                  _controller.themeMode,
                );
              },
            );
          } else {
            appChild = widget.child!;
          }

          if (widget.hardcodedColorStrategy !=
              HardcodedColorStrategy.colorFilter) {
            return appChild;
          }

          final shouldApplyFilter = _shouldApplyHardcodedColorFilter(context);
          if (!shouldApplyFilter) {
            return appChild;
          }

          final sourceBrightness = _controller.sourceIsLight
              ? Brightness.light
              : Brightness.dark;
          final filter = _buildHardcodedColorFilter(
            sourceBrightness: sourceBrightness,
            strength: widget.hardcodedColorFilterStrength,
          );

          return ColorFiltered(colorFilter: filter, child: appChild);
        },
      ),
    );
  }

  ThemeData _resolveSourceTheme(ThemeData? sourceTheme) {
    if (sourceTheme != null) {
      return sourceTheme;
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        brightness: Brightness.light,
      ),
    );
  }

  bool _shouldApplyHardcodedColorFilter(BuildContext context) {
    final sourceBrightness = _controller.sourceIsLight
        ? Brightness.light
        : Brightness.dark;
    final activeBrightness = _effectiveBrightness(context);
    return sourceBrightness != activeBrightness;
  }

  Brightness _effectiveBrightness(BuildContext context) {
    switch (_controller.themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        final mediaQuery = MediaQuery.maybeOf(context);
        if (mediaQuery != null) {
          return mediaQuery.platformBrightness;
        }
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }

  ColorFilter _buildHardcodedColorFilter({
    required Brightness sourceBrightness,
    required double strength,
  }) {
    const identity = <double>[
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];

    const lightToDark = <double>[
      -0.78,
      -0.04,
      -0.04,
      0,
      225,
      -0.04,
      -0.78,
      -0.04,
      0,
      225,
      -0.04,
      -0.04,
      -0.78,
      0,
      225,
      0,
      0,
      0,
      1,
      0,
    ];

    const darkToLight = <double>[
      -0.9,
      -0.02,
      -0.02,
      0,
      245,
      -0.02,
      -0.9,
      -0.02,
      0,
      245,
      -0.02,
      -0.02,
      -0.9,
      0,
      245,
      0,
      0,
      0,
      1,
      0,
    ];

    final target = sourceBrightness == Brightness.light
        ? lightToDark
        : darkToLight;
    final t = strength.clamp(0.0, 1.0);
    final matrix = List<double>.generate(
      identity.length,
      (index) => identity[index] + (target[index] - identity[index]) * t,
    );
    return ColorFilter.matrix(matrix);
  }
}
