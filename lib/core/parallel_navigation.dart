import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app.dart';
import 'package:flutter_app_core/core/navigation_data.dart';
import 'package:flutter_app_core/core/theme.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

export 'package:flutter_inner_drawer/inner_drawer.dart'
    show InnerDrawerAnimation, InnerDrawerPosition;

/// With a parallel navigation style, there is no actual root page.
/// There is a list of root pages accessible from a side menu.
/// Opening a specific page from the side menu won't keep the root page
/// in the stack. It is then possible to push new pages.
class ParallelNavigation extends NavigationData {
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
  final Route<dynamic> Function(RouteSettings) onGenerateRoute;
  final Route<dynamic> Function(RouteSettings) onUnknownRoute;
  final bool debugShowWidgetInspector;
  final Function(BuildContext, Widget) builder;
  final ExtendedThemeData theme;
  final Map<String, ExtendedThemeData> themes;
  final String defaultTheme;
  final String initialRoute;

  ParallelNavigation({
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
    @required this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.defaultTheme,
    @required this.initialRoute,
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
  Widget build(BuildContext context) {
    PlatformType platform = PlatformProvider.of(context).isCupertino
        ? PlatformType.cupertino
        : PlatformType.material;

    return SharedApp(
      platformType: platform,
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
      onGenerateTitle: onGenerateTitle,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowMaterialGrid: debugShowMaterialGrid,
      routes: routes,
      home: _SidebarManager(
        platform: platform,
        routes: routes,
        initialRoute: initialRoute,
      ),
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

/// Contains the settings of the [Drawer] used with material.
class MaterialDrawerSettings {
  /// The z-coordinate at which to place this drawer relative to its parent.
  ///
  /// This controls the size of the shadow below the drawer.
  ///
  /// Defaults to 16, the appropriate elevation for drawers. The value is always non-negative.
  final double elevation;

  /// The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to [MaterialLocalizations.drawerLabel].
  ///
  /// See also:
  ///
  /// - [SemanticsConfiguration.namesRoute], for a description of how this value is used.
  final String semanticLabel;

  /// Key of the [Drawer] object
  final Key drawerKey;

  const MaterialDrawerSettings({
    this.elevation = 16.0,
    this.semanticLabel,
    this.drawerKey,
  }) : assert(elevation != null && elevation >= 0.0);
}

/// Contains the settings of the [InnerDrawer] used with ios.
///
/// The used package is this one: https://pub.dev/packages/flutter_inner_drawer
class CupertinoDrawerSettings {
  /// static, linear, quadratic
  final InnerDrawerAnimation animationType;

  /// Does a tap outside of the drawer close it ?
  final bool onTapClose;

  /// Called whenever the drawer is opened/closed
  final void Function(bool) onDrawerToggled;

  /// Offset drawer width; default 0.4
  final double offset;

  /// Allow to swipe to open the drawer
  final bool swipe;

  /// Color of gradient
  final Color colorTransition;

  /// BoxShadows of scaffold opened
  final List<BoxShadow> boxShadow;

  /// Key of the [InnerDrawer] object
  final Key drawerKey;

  /// Position of the drawer
  final InnerDrawerPosition position;

  const CupertinoDrawerSettings({
    this.animationType = InnerDrawerAnimation.quadratic,
    this.onTapClose = true,
    this.onDrawerToggled,
    this.offset,
    this.swipe = true,
    this.colorTransition,
    this.boxShadow,
    this.drawerKey,
    this.position = InnerDrawerPosition.start,
  })  : assert(animationType != null),
        assert(position != null);
}

/// Handles the display and navigation of the drawer.
/// 
/// - Uses a [Drawer] with material and a [InnerDrawer] with cupertino
/// - Generates the drawer from TODO
class _SidebarManager extends StatefulWidget {
  final PlatformType platform;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final CupertinoDrawerSettings Function() cupertino;
  final MaterialDrawerSettings Function() material;

  const _SidebarManager({
    this.platform = PlatformType.material,
    @required this.routes,
    @required this.initialRoute,
    this.cupertino,
    this.material,
  }) : assert(platform != null);

  @override
  _SidebarManagerState createState() => _SidebarManagerState();
}

/// State of the [_SidebarManager]
class _SidebarManagerState extends State<_SidebarManager> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.routes[widget.initialRoute](context);

    switch (widget.platform) {
      case PlatformType.cupertino:
        return _buildCupertino(child);
      default:
        return _buildMaterial(child);
    }
  }

  /// Builds the drawer content that is common between platforms
  Widget _buildDrawerContent() {
    return Container();
  }

  /// Returns the given [MaterialDrawerSettings], or use the default one if null
  MaterialDrawerSettings _getMaterialSettings() =>
      widget.material?.call() ?? const MaterialDrawerSettings();

  /// Builds a material [Drawer] around the child
  Widget _buildMaterial(Widget child) {
    MaterialDrawerSettings settings = _getMaterialSettings();

    return Scaffold(
      body: child,
      drawer: Drawer(
        child: _buildDrawerContent(),
        elevation: settings.elevation,
        semanticLabel: settings.semanticLabel,
        key: settings.drawerKey,
      ),
    );
  }

  /// Returns the given [CupertinoDrawerSettings], or use the default one if null
  CupertinoDrawerSettings _getCupertinoSettings() =>
      widget.cupertino?.call() ?? const CupertinoDrawerSettings();

  /// Builds the [InnerDrawer] around the child
  ///
  /// https://pub.dev/packages/flutter_inner_drawer
  Widget _buildCupertino(Widget child) {
    CupertinoDrawerSettings settings = _getCupertinoSettings();

    return InnerDrawer(
      child: _buildDrawerContent(),
      animationType: settings.animationType,
      onTapClose: settings.onTapClose,
      innerDrawerCallback: settings.onDrawerToggled,
      scaffold: child,
      offset: settings.offset,
      swipe: settings.swipe,
      colorTransition: settings.colorTransition,
      boxShadow: settings.boxShadow,
      key: settings.drawerKey,
      position: settings.position,
    );
  }
}
