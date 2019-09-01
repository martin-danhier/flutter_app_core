import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_core/core/app.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

abstract class NavigationData {
  Widget build(BuildContext context);
  Future<T> navigateTo<T>(String route, {bool pushWholeBranch: true}) {}
}

class NavigationManager<T> {}

/// With a parallel navigation style, there is no actual root page.
/// There is a list of root pages accessible from a side menu.
/// Opening a specific page from the side menu won't keep the root page
/// in the stack. It is then possible to push new pages.
class ParallelNavigation extends NavigationData {
  @override
  Widget build(BuildContext context) {
    return PlatformApp();
  }
}

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
    this.debugShowCheckedModeBanner = true,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute = '/',
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
  Widget build(BuildContext context) {
    return SharedApp(
      platformType: PlatformProvider.of(context).isCupertino
          ? PlatformType.cupertino
          : PlatformType.material,
      locale: locale,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      key: key,
      navigatorKey: navigatorKey,
      navigatorObservers: navigatorObservers,
      
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      // onGenerateTitle: onGenerateTitle,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowMaterialGrid: debugShowMaterialGrid,
      routes: routes,
      // initialRoute: initialRoute,
      home: home,
      builder: (context, widget) => PlatformProvider.of(context).isCupertino
          ? ScrollConfiguration(
              child: widget,
              behavior: _AlwaysCupertinoScrollBehavior(),
            )
          : widget,
      title: title,
      theme: ThemeData.dark(),
    );
  }
}

/// Made by the Chromium team (CupertinoApp)
class _AlwaysCupertinoScrollBehavior extends ScrollBehavior {
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
