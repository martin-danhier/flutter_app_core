import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app.dart';
import 'package:flutter_app_core/core/navigation_data.dart';
import 'package:flutter_app_core/core/theme.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// A classic navigation style. The app has a root page, from which it is
/// possible to push new routes. This is the default navigation style of Flutter.
///
/// The RootedNavigation provides a compatibility between Cupertino and Material
/// widgets, it is based on flutter_platform_widgets.
class RootedNavigation extends NavigationData {
  final Widget home;
  final String title;
  final Locale locale;
  final Locale Function(List<Locale>, Iterable<Locale>)
      localeListResolutionCallback;
  final Locale Function(Locale, Iterable<Locale>) localeResolutionCallback;
  final Iterable<LocalizationsDelegate> localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final bool checkerboardOffscreenLayers;
  final Key key;
  final Key widgetKey;
  final Key navigatorKey;
  final bool checkerboardRasterCacheImages;
  final bool debugShowCheckedModeBanner;
  final List<NavigatorObserver> navigatorObservers;
  final String Function(BuildContext) onGenerateTitle;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowMaterialGrid;
  final MaterialAppData Function(BuildContext) android;
  final CupertinoAppData Function(BuildContext) ios;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final Route<dynamic> Function(RouteSettings) onGenerateRoute;
  final Route<dynamic> Function(RouteSettings) onUnknownRoute;
  final bool debugShowWidgetInspector;
  final Function(BuildContext, Widget) builder;
  final ExtendedThemeData theme;
  final Map<String, ExtendedThemeData> themes;
  final String defaultTheme;

  RootedNavigation({
    this.home,
    this.title = '',
    this.locale,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.key,
    this.widgetKey,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.onGenerateTitle,
    this.android,
    this.ios,
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowWidgetInspector = false,
    this.debugShowCheckedModeBanner = true,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute = '/',
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.defaultTheme,
    this.theme,
    this.themes,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null);

  @override
  Future navigateTo(String route) {
    // TODO: implement navigateTo
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SharedApp(
      locale: locale,
      // platformType: PlatformProvider.of(context).platform == TargetPlatform.iOS
      //     ? PlatformType.cupertino
      //     : PlatformType.material,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      key: key,
      navigatorKey: navigatorKey,
      navigatorObservers: navigatorObservers,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      onGenerateTitle: onGenerateTitle,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowMaterialGrid: debugShowMaterialGrid,
      routes: routes,
      initialRoute: initialRoute,
      home: home,
      title: title,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      debugShowWidgetInspector: debugShowWidgetInspector,
      builder: builder,
      themes: themes,
      theme: theme,
      defaultTheme: defaultTheme,
    );
  }
}
