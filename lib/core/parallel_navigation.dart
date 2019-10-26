import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app.dart';
import 'package:flutter_app_core/core/navigation_data.dart';
import 'package:flutter_app_core/core/theme.dart';
import 'package:flutter_app_core/flutter_app_core.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

export 'package:flutter_inner_drawer/inner_drawer.dart'
    show InnerDrawerAnimation, InnerDrawerDirection;

/// {@macro flutter_app_core.parallelNavigation}
class ParallelNavigation extends NavigationData {
  // SharedApp parameters

  /// {@macro flutter.widgets.widgetsApp.title}
  final String title;

  /// {@macro flutter.widgets.widgetsApp.locale}
  final Locale locale;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  final Locale Function(List<Locale>, Iterable<Locale>)
      localeListResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.localeResolutionCallback}
  final Locale Function(Locale, Iterable<Locale>) localeResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  final Iterable<LocalizationsDelegate> localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  final Iterable<Locale> supportedLocales;

  /// [SharedApp] key
  final Key key;

  /// {@macro flutter.widgets.widgetsApp.navigatorKey}
  final Key navigatorKey;

  /// Raster cache images.
  final bool checkerboardRasterCacheImages;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
  final String Function(BuildContext) onGenerateTitle;

  /// {@macro flutter.widgets.widgetsApp.builder}
  final Function(BuildContext, Widget) builder;

  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowMaterialGrid;
  final bool checkerboardOffscreenLayers;
  final bool debugShowWidgetInspector;

  // mate moi cette documentation 8-)
  /// {@template flutter_app_core.parallelNavigation.routes}
  /// A map that contains the routes names and builders.
  ///
  /// In a parallel navigation, there are several rules and concepts about the routes that you need to understand.
  ///
  /// First, there are two types of routes:
  /// - The **main routes** are the "root pages" that you typically find in the side bar.
  /// They are at the same level and cannot be loaded at the same time. A main route name/address looks like `/page`.
  ///
  /// - The **secondary routes** are the "child pages" that are pushed on top of a main route.
  /// For instance, the secondary route `/page/detail` is pushed on top of the `/page` main route.
  ///
  /// The route names (or addresses) behave like web URLs.
  /// For example, the route `/page1/detail` is the name of a 'detail' route which is the child of the main route 'page1'.
  /// In this case, the `/page1` route must also exist in the map !
  ///
  /// Also, a root can only contain alphanumerical characters, underscores and slashes.
  ///
  ///
  /// **Note**: you cannot provide the `/` route because it is already used by the sidebar manager.
  /// The main purpose of this navigation type is to have a set of several "root" pages at the same level.
  /// If you need a true root page, check out the [RootedNavigation].
  /// If you need to specify the default main route, see the [initialRoute] property.
  /// {@endtemplate}
  final Map<String, WidgetBuilder> routes;

  /// The theme used in the app.
  ///
  /// Use this property to provide a unique, constant theme.
  /// If you want to be able to set several themes (for instance a light and dark mode),
  /// leave this property to null and set [themes] and [defaultTheme] instead.
  final ExtendedThemeData theme;

  /// A map of the themes used in the app.
  ///
  /// Use this property to provide several named themes. (for instance 'light' and 'dark')
  /// You'll then be able to change to theme at runtime with TODO.
  /// If you use this property, you must also provide [defaultTheme] in order to tell the app which theme choose by default.
  ///
  /// If you want to set a unique, constant theme, leave this and [defaultTheme] to null and set [theme] instead.
  final Map<String, ExtendedThemeData> themes;

  /// The name of the default theme. Use this property alongside [themes].
  ///
  /// If you use [theme] to declare a unique theme, you must leave this to null.
  final String defaultTheme;

  // side bar manager parameters
  /// {@template flutter_app_core.parallelNavigation.drawerItems}
  /// A list of all the drawer items.
  /// They will appear in the drawer list, in the given order.
  ///
  /// Typically, for each item you'll set a ``route``, a ``name`` and an ``icon``,
  /// but you can manually build an item with the `drawer` property if you need to.
  /// {@endtemplate}
  final List<DrawerItem> drawerItems;

  /// {@template flutter_app_core.parallelNavigation.initialRoute}
  /// The route built by default by the sidebar manager.
  ///
  /// It is intended to be a main route, but a secondary route works.
  ///
  /// You musn't set '/' as the initialRoute.
  /// {@endtemplate}
  final String initialRoute;

  /// The title of the drawer app bar
  final Widget drawerTitle;

  /// The settings of the material [Drawer] widget
  final MaterialDrawerSettings Function() materialDrawerSettings;

  /// The settings of the cupertino [InnerDrawer] widget.
  ///
  /// The used package is this one: https://pub.dev/packages/flutter_inner_drawer.
  final CupertinoDrawerSettings Function() cupertinoDrawerSettings;

  /// The drawer app bar background color
  final Color drawerBarBackgroundColor;

  /// The key of the [_SidebarManagerState].
  ///
  /// It allows this object to access the methods of the sidebar manager.
  final _sidebarKey = GlobalKey<_SidebarManagerState>();

  /// {@template flutter_app_core.parallelNavigation}
  /// With a parallel navigation style, there is no actual root page.
  /// There is a list of root pages accessible from a side menu.
  ///
  /// The navigation comes with a bunch of tools in order to approach a "instanciate and play" coding style.
  /// With this, you avoid more than 700 lines of code.
  ///
  /// Opening a specific page from the side menu (**main routes**) won't keep the root page
  /// in the stack. It is then possible to push new pages (**secondary routes**).
  ///
  /// You need to provide the routes. See the documentation of the [routes] property.
  /// {@endtemplate}
  ParallelNavigation({
    // SharedApp parameters
    this.title = '',
    this.locale,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.key,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.onGenerateTitle,
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowWidgetInspector = false,
    this.debugShowCheckedModeBanner = true,
    @required this.routes,
    this.builder,
    this.defaultTheme,
    this.theme,
    this.themes,
    // side bar manager parameters
    @required this.initialRoute,
    this.drawerTitle = const Text("Menu"),
    this.cupertinoDrawerSettings,
    this.materialDrawerSettings,
    this.drawerBarBackgroundColor,
    this.drawerItems,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        assert(_debugCheckRouteNames(routes)),
        assert(routes.containsKey(initialRoute),
            'The initial route must exist in the routes map.'),
        assert(
            _debugCheckDrawerItemsRoutes(drawerItems, routes),
            'The routes in the DrawerItem\'s must exist in the routes map. '
            'Otherwise, it is impossible to know which route to build when a drawer item is tapped.');

  /// Check if the routes in each [DrawerItem] exist in the routes map
  static bool _debugCheckDrawerItemsRoutes(
      List<DrawerItem> drawerItems, Map<String, WidgetBuilder> routes) {
    for (var item in drawerItems) {
      if (!routes.containsKey(item.route)) return false;
    }
    return true;
  }

  /// Check the integrity of the names of the routes.
  ///
  /// It is only executed in debug mode to help the programmer to have clean and consistent routes.
  ///
  /// Usually, in flutter, there are no naming rules for the routes. However, the AppCore provides some tools
  /// that assume a determined format. For exemple, it is possible to navigate to a specific route and load the parent route in the navigator.
  static bool _debugCheckRouteNames(Map<String, WidgetBuilder> routes) {
    routes.forEach((route, builder) {
      // test 1: the route name must be longer than 2 characters
      assert(
        route.length >= 2,
        '\'$route\' is too short. '
        'A route name in a parallel navigation must be at least 2 characters long.',
      );
      // test 2: route must only contain / and alphanumerical characters
      assert(
        !RegExp(r'[^\w\/]+').hasMatch(route),
        '\'$route\' contains illegal characters. '
        'A route name can only contain alphanumerical characters, '
        'underscores and slashes : [a-zA-Z0-9_/]',
      );
      // test 3: in a parallel navigation, there are no root page, so all the "root pages" are at the same level.
      // The impact is that each route name must start with a /
      assert(
        route[0] == '/',
        '\'$route\' is an invalid route name. '
        'In a parallel navigation, all the main pages are at the same level. '
        'Each route name must start with a \'/\'. '
        'Exemple: \'/page1\', \'/page2\', \'/page1/detail\'...',
      );
      // some tests with the route content
      List<String> split = route.split('/');
      String parentRoute = '';
      // test 4: make sure that each page of the route path has a non null name.
      // A good name would be '/page1/detail', a route named 'detail' that is the child of the main route named 'page1'
      // A bad name would be '//detail' because the main route wouldn't have a real name
      // I hope you understand;
      for (int i = 0; i < split.length; i++) {
        assert(
          i == 0 || split[i].length > 0,
          '\'$route\' is an invalid route name. '
          'A route name is composed like a web URL. '
          'Exemple: \'/page1/detail\' is a route named \'detail\' that '
          'is the child of a main route named \'page1\'. A route must have a non null name. '
          'In other words, you mustn\'t have two slashes next to each other like this \'//\' or trailing slashes like this \'/page/\'.',
        );
        if (i != split.length - 1 && i != 0) {
          parentRoute += '/${split[i]}';
        }
      }
      // test 5: make sure that the path exists.
      // For exemple, if a '/page1/detail' exists, make sure that the '/page1' route exist as well
      if (parentRoute != '') {
        assert(
          routes.containsKey(parentRoute),
          '\'$route\' is an invalid route name. '
          'A route name is composed like a web URL. '
          'For exemple, the route \'/page1/detail\' is a '
          'route named \'detail\' that is the child of a main route named \'page1\'. '
          'Thus, the \'page1\' route must exist. Try to add a \'$parentRoute\' key in '
          'the map or to change the parent route.',
        );
      }
    });
    return true;
  }

  /// {@macro flutter_app_core.parallelNavigation.navigateTo}
  @override
  Future navigateTo(String route) {
    return _sidebarKey.currentState.navigateTo(route);
  }

  /// build the app with a side bar manager that can handle the parallelism
  @override
  Widget build(BuildContext context) {
    PlatformType platform =
        PlatformProvider.of(context).platform == TargetPlatform.iOS
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
        title: drawerTitle,
        material: materialDrawerSettings,
        cupertino: cupertinoDrawerSettings,
        barBackgroundColor: drawerBarBackgroundColor,
        drawerItems: drawerItems,
        key: _sidebarKey,
      ),
      title: title,
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

  /// elevation of the app bar of the drawer. Defaults to 1.0.
  final double drawerAppBarElevation;

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

  /// Contains the settings of the [Drawer] used with material.
  const MaterialDrawerSettings({
    this.elevation = 16.0,
    this.drawerAppBarElevation = 1.0,
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
  final InnerDrawerDirection direction;

  /// Surprizingly, color of the app bar title.
  final Color appBarTitleColor;

  /// Contains the settings of the [InnerDrawer] used with ios.
  ///
  /// The used package is this one: https://pub.dev/packages/flutter_inner_drawer
  const CupertinoDrawerSettings({
    this.animationType = InnerDrawerAnimation.quadratic,
    this.onTapClose = true,
    this.onDrawerToggled,
    this.offset = 0.4,
    this.swipe = true,
    this.colorTransition,
    this.boxShadow,
    this.drawerKey,
    this.appBarTitleColor,
    this.direction = InnerDrawerDirection.start,
  })  : assert(animationType != null),
        assert(direction != null);
}

/// Contains the properties of a drawer item.
///
/// The item is displayed in the drawer list.
///
/// The `route` is selected if the tile is tapped.
///
/// The `icon` and `name` are the most common way to describe the tile look,
/// but you can define a custom widget using the `builder`.
/// (in that case, provide neither the name nor the icon)
class DrawerItem {
  /// The name/address of the route built when the tile is tapped.
  ///
  /// It is intended to be a **main route** (like `/page`, unlike `/page/detail`)
  final String route;

  /// An icon displayed in the leading slot of the tile. If null, the name will take all the available space.
  final IconData icon;

  /// The name of the tile. Either provide this or the [builder]. If you don't provide a builder, you must provide this.
  final String name;

  /// A function that builds a ListTile for the item.
  ///
  /// `onTap` is the callback that opens the correct route when the tile is tapped.
  /// Don't forget to provide it to the ListTile or you won't be able to change the route.
  ///
  /// `isSelected` is true if the item route is already displayed.
  final Widget Function(
      BuildContext context, void Function() onTap, bool isSelected) builder;

  /// Contains the properties of a drawer item.
  ///
  /// The item is displayed in the drawer list.
  ///
  /// The `route` is selected if the tile is tapped.
  ///
  /// The `icon` and `name` are the most common way to describe the tile look,
  /// but you can define a custom widget using the `builder`.
  /// (in that case, provide neither the name nor the icon)
  const DrawerItem({
    @required this.route,
    this.icon,
    this.name,
    this.builder,
  })  : assert(
          (builder != null && route == null && icon == null && name == null) ||
              builder == null,
          'Either provide a builder or the other parameters. Providing both is redundant.',
        ),
        assert(route != null);
}

/// Handles the display and navigation of the drawer.
///
/// - Uses a [Drawer] with material and a [InnerDrawer] with cupertino
/// - Generates the drawer from [drawerItems]
/// - Handle the base navigation following the [routes]
class _SidebarManager extends StatefulWidget {
  /// The platform style of the drawer
  final PlatformType platform;

  /// {@macro flutter_app_core.parallelNavigation.routes}
  final Map<String, WidgetBuilder> routes;

  /// {@macro flutter_app_core.parallelNavigation.initialRoute}
  final String initialRoute;

  /// The title of the drawer app bar
  final Widget title;

  /// The settings of the cupertino drawer
  final CupertinoDrawerSettings Function() cupertino;

  /// The settings of the material drawer
  final MaterialDrawerSettings Function() material;

  /// The background color of the app bar of the drawer
  final Color barBackgroundColor;

  /// The background color of the drawer body
  final Color backgroundColor;

  /// {@macro flutter_app_core.parallelNavigation.drawerItems}
  final List<DrawerItem> drawerItems;

  const _SidebarManager({
    this.title,
    this.platform = PlatformType.material,
    @required this.routes,
    @required this.initialRoute,
    this.cupertino,
    this.material,
    this.barBackgroundColor,
    this.backgroundColor,
    this.drawerItems,
    Key key,
  })  : assert(platform != null),
        super(key: key);

  @override
  _SidebarManagerState createState() => _SidebarManagerState();
}

/// State of the [_SidebarManager]
class _SidebarManagerState extends State<_SidebarManager> {
  String selectedRoute;

  @override
  void initState() {
    super.initState();
    selectedRoute = widget.initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.routes[selectedRoute](context);

    switch (widget.platform) {
      case PlatformType.cupertino:
        return _buildCupertino(child);
      default:
        return _buildMaterial(child);
    }
  }

  /// {@template flutter_app_core.parallelNavigation.navigateTo}
  /// Navigates to the given route.
  ///
  /// It is different from ``Navigator.of(context).pushNamed``: pushNamed pushes the
  /// route on top of the navigator without touching anything else.
  ///
  /// navigateTo will instead make the stack correspond to the route name/address.
  ///
  /// For example, `navigateTo('/page/detail/more')` will set the main route to `/page`
  /// and push 'detail' and 'more' on top of that.
  /// {@endtemplate}
  Future navigateTo(String route) async {
    // make sure that the route exists (the check is only performed in debug mode)
    assert(
      widget.routes.containsKey(route),
      '\'$route\' is an invalid route. How do you want me to navigate to a route that doesn\'t exist ??!',
    );

    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    var path = route.split('/');
    String parentRoute = '';
    for (int i = 1; i < path.length; i++) {
      parentRoute += '/${path[i]}';
      if (i == 1) {
        if (selectedRoute != parentRoute) {
          setState(() {
            selectedRoute = parentRoute;
          });
        }
      } else {
        Navigator.of(context).pushNamed(parentRoute);
      }
    }
  }

  _changeSelectedRoute(String route) {
    // Don't rebuild a page that is already displayed
    if (selectedRoute != route) {
      setState(() {
        selectedRoute = route;
      });
    }
    // Close the drawer
    Navigator.of(context).pop();
  }

  /// Builds the drawer content that is common between platforms
  Widget _buildDrawerContent() {
    List<Widget> items = List<Widget>(widget.drawerItems.length);
    for (int i = 0; i < items.length; i++) {
      DrawerItem drawerItem = widget.drawerItems[i];
      bool isSelected = drawerItem.route == selectedRoute;
      if (drawerItem.builder == null) {
        // build a classic tile
        items[i] = ListTile(
          selected: isSelected,
          leading: drawerItem != null ? Icon(drawerItem.icon) : null,
          title: Text(drawerItem.name ?? ''),
          onTap: () => _changeSelectedRoute(drawerItem.route),
        );
      } else {
        // use the provided builder to let the programmer build the tile manually
        items[i] = drawerItem.builder(
            context, () => _changeSelectedRoute(drawerItem.route), isSelected);
      }
    }

    return ListView(
      children: items,
    );
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
        child: Scaffold(
          body: _buildDrawerContent(),
          appBar: AppBar(
            title: DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: widget.title,
            ),
            automaticallyImplyLeading: false,
            elevation: settings.drawerAppBarElevation,
            backgroundColor: widget.barBackgroundColor ??
                Theme.of(context).bottomAppBarColor,
          ),
          backgroundColor:
              widget.backgroundColor ?? Theme.of(context).canvasColor,
        ),
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

    // get nav bar color
    Brightness brightness = Theme.of(context).brightness ?? Brightness.light;

    Color navBarColor = settings.appBarTitleColor ??
        Theme.of(context).textTheme?.title?.color ??
        ExtendedThemeData.fromBrightness(brightness).base.textTheme.title.color;

    TextStyle navBarTextStyle = Theme.of(context)
            ?.cupertinoOverrideTheme
            ?.textTheme
            ?.navTitleTextStyle ??
        ExtendedThemeData.fromBrightness(brightness)
            .base
            .cupertinoOverrideTheme
            .textTheme
            .navTitleTextStyle;

    return InnerDrawer(
      leftChild: CupertinoPageScaffold(
        child: Drawer(
          elevation: 0.0,
          child: _buildDrawerContent(),
        ),
        navigationBar: CupertinoNavigationBar(
          middle: DefaultTextStyle(
            child: widget.title,
            style: navBarTextStyle.merge(
              TextStyle(
                color: navBarColor,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor:
              widget.barBackgroundColor ?? Theme.of(context).bottomAppBarColor,
        ),
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).canvasColor,
      ),
      leftAnimationType: settings.animationType,
      onTapClose: settings.onTapClose,
      innerDrawerCallback: settings.onDrawerToggled,
      scaffold: child,
      leftOffset: settings.offset ?? 0.4,
      swipe: settings.swipe,
      colorTransition: settings.colorTransition,
      boxShadow: settings.boxShadow,
      key: settings.drawerKey,
    );
  }
}
