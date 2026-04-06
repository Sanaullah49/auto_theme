import 'package:flutter/material.dart';

import 'auto_theme_controller.dart';

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
    required this.theme,
    this.oppositeTheme,
    this.initialThemeMode = ThemeMode.system,
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
    required this.theme,
    this.oppositeTheme,
    this.initialThemeMode = ThemeMode.system,
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

  final ThemeData theme;
  final ThemeData? oppositeTheme;
  final ThemeMode initialThemeMode;
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

  @override
  void initState() {
    super.initState();
    _controller = AutoThemeController(
      theme: widget.theme,
      oppositeTheme: widget.oppositeTheme,
      initialMode: widget.initialThemeMode,
    );
  }

  @override
  void didUpdateWidget(covariant AutoThemeApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme ||
        oldWidget.oppositeTheme != widget.oppositeTheme) {
      _controller.updateTheme(
        widget.theme,
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
          if (widget._isMaterialApp) {
            return MaterialApp(
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
          }

          if (widget.builder != null) {
            return Builder(
              builder: (innerContext) {
                return widget.builder!(
                  innerContext,
                  _controller.lightTheme,
                  _controller.darkTheme,
                  _controller.themeMode,
                );
              },
            );
          }

          return widget.child!;
        },
      ),
    );
  }
}
