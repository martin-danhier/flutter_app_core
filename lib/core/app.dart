import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_core/core/theme.dart';

// INSPIRED BY THE OFFICIAL MaterialApp ! Most of the code comes from it.
// I cannot extend the class because _MaterialAppState is private
// Copyright goes to the Chromium Team

enum PlatformType { material, cupertino }

class SharedApp extends StatefulWidget {
  final _SharedAppState _state = _SharedAppState();
  final Widget Function(BuildContext, Widget) builder;
  final Widget home;
  final Key navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final Map<String, WidgetBuilder> routes;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final String title;
  final bool debugShowCheckedModeBanner;
  final bool checkerboardRasterCacheImages;
  final bool showPerformanceOverlay;
  final bool debugShowMaterialGrid;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final Map<String, ExtendedThemeData> themes;
  final String defaultTheme;
  final ExtendedThemeData theme;
  final GenerateAppTitle onGenerateTitle;
  final String initialRoute;
  final bool debugShowWidgetInspector;
  final PlatformType platformType;

  bool get isCupertino {
    return this.platformType == PlatformType.cupertino;
  }

  bool get isMaterial {
    return this.platformType == PlatformType.material;
  }

  SharedApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    // this.color,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.debugShowWidgetInspector = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.themes,
    this.defaultTheme,
    this.platformType = PlatformType.material,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        assert(platformType != null, "A 'platformType' is required."),
        assert(
            (theme != null && themes == null && defaultTheme == null) ||
                (theme == null && themes != null && defaultTheme != null) ||
                (theme == null && themes == null && defaultTheme == null),
            "Either provide a unique 'theme' or provide a 'themes' map and a 'defaultTheme'. Don't provide both 'theme' and 'themes', since it would be redundant."),
        assert(themes == null || themes.length > 0,
            "If provided, 'themes' must at least contain one element."),
        assert(
            (themes == null && defaultTheme == null) ||
                themes.containsKey(defaultTheme),
            "'defaultTheme' must be a key in 'themes'."),
        super(key: key);

  @override
  _SharedAppState createState() => _state;

  ExtendedThemeData getTheme() => _state.getTheme();

  String getThemeName() => _state.getThemeName();

  void setTheme(String newTheme) => _state.setTheme(newTheme);
}

class _SharedAppState extends State<SharedApp> {
  HeroController _heroController;
  List<NavigatorObserver> _navigatorObservers;
  String _currentTheme;

  ///copyright chromium team from MaterialApp
  @override
  void initState() {
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
    _updateNavigator();
  }

  ///copyright chromium team from MaterialApp
  @override
  void didUpdateWidget(SharedApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigatorKey != oldWidget.navigatorKey) {
      // If the Navigator changes, we have to create a new observer, because the
      // old Navigator won't be disposed (and thus won't unregister with its
      // observers) until after the new one has been created (because the
      // Navigator has a GlobalKey).
      _heroController = HeroController(createRectTween: _createRectTween);
    }
    _updateNavigator();
  }

  ///copyright chromium team from MaterialApp
  void _updateNavigator() {
    if (widget.home != null ||
        widget.routes.isNotEmpty ||
        widget.onGenerateRoute != null ||
        widget.onUnknownRoute != null) {
      _navigatorObservers =
          List<NavigatorObserver>.from(widget.navigatorObservers)
            ..add(_heroController);
    } else {
      _navigatorObservers = const <NavigatorObserver>[];
    }
  }

  ///made by me :p
  ExtendedThemeData getTheme() {
    // single theme
    if (widget.theme != null)
      return widget.theme;
    // theme map
    else if (widget.defaultTheme != null && widget.themes != null) {
      if (_currentTheme == null) _currentTheme = widget.defaultTheme;
      return widget.themes[_currentTheme];
    }
    // fallback theme
    else
      return ExtendedThemeData.light();
  }

  String getThemeName() {
    if (widget.themes != null)
      return _currentTheme;
    else
      throw Exception('The theme does not have a name.');
  }

  void setTheme(String newTheme) {
    if (widget.themes != null) {
      if (widget.themes.containsKey(newTheme))
        setState(() {
          _currentTheme = newTheme;
        });
      else
        throw Exception("Unknown theme: $newTheme.");
    } else
      throw Exception(
          "To be able to change the theme, you need to provide a 'themes' map and a 'defaultTheme' key.");
  }

  ///copyright chromium team from MaterialApp
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (widget.localizationsDelegates != null)
      yield* widget.localizationsDelegates;
    yield DefaultMaterialLocalizations.delegate;
    yield DefaultCupertinoLocalizations.delegate;
  }

  ///copyright chromium team from MaterialApp
  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = WidgetsApp(
      color: Theme.of(context).accentColor,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      locale: widget.locale,
      localizationsDelegates: _localizationsDelegates,
      localeResolutionCallback: widget.localeResolutionCallback,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      supportedLocales: widget.supportedLocales,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      key: GlobalObjectKey(this),
      home: widget.home != null
          ? Builder(
              builder: (context) => widget.home,
              key: GlobalKey(),
            )
          : null,
      builder: (BuildContext context, Widget child) {
        // Use a light theme, dark theme, or fallback theme.
        return _scroll(
          child: _theme(getTheme(), child),
        );
      },
      navigatorKey: widget.navigatorKey,
      navigatorObservers: _navigatorObservers,
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          widget.isCupertino
              ? CupertinoPageRoute(settings: settings, builder: builder)
              : MaterialPageRoute<T>(settings: settings, builder: builder),
      routes: widget.routes,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      initialRoute: widget.initialRoute,
      inspectorSelectButtonBuilder:
          (BuildContext context, VoidCallback onPressed) {
        return FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: onPressed,
          mini: true,
        );
      },
      debugShowWidgetInspector: widget.debugShowWidgetInspector,
    );

    // Made by the Chromium Team (Material App)
    assert(() {
      if (widget.debugShowMaterialGrid) {
        result = GridPaper(
          color: const Color(0xE0F9BBE0),
          interval: 8.0,
          divisions: 2,
          subdivisions: 1,
          child: result,
        );
      }
      return true;
    }());

    return result;
  }

  Widget _theme(ExtendedThemeData theme, Widget child) {
    return CustomTheme(
      data: theme,
      isMaterialAppTheme: true,
      child: widget.builder != null
          ? Builder(
              builder: (BuildContext context) {
                return widget.builder(context, child);
              },
            )
          : child,
    );
  }

  Widget _scroll({Widget child}) {
    return ScrollConfiguration(
      child: child,
      behavior: widget.isCupertino
          ? _CupertinoScrollBehavior()
          : _MaterialScrollBehavior(),
    );
  }
}

/// copyright chromium team from MaterialApp
class _MaterialScrollBehavior extends ScrollBehavior {
  @override
  TargetPlatform getPlatform(BuildContext context) {
    return Theme.of(context).platform;
  }

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
    }
    return null;
  }
}

/// Made by the Chromium team (CupertinoApp)
class _CupertinoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // Never build any overscroll glow indicators.
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
