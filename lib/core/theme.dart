import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ExtendedThemeData {
  /// A classic theme data that is used by most widgets.
  ///
  /// To access it, simply do `Theme.of(context)`.
  final ThemeData base;

  /// An extendable CustomThemeData class where you can define your own values.
  ///
  /// To access it, do `CustomTheme.of(context)`.
  final CustomThemeData custom;

  /// Instanciates a ExtendedThemeData.
  const ExtendedThemeData({@required this.base, this.custom});

  ExtendedThemeData setPlatform(TargetPlatform platform) {
    return this.merge(
      ExtendedThemeData(
        base: ThemeData(
          platform: platform,
        ),
      ),
    );
  }

  // ExtendedThemeData switchPlatform() {
  //   TargetPlatform currentPlatform = this.base?.platform ?? Platform.isIOS
  //       ? TargetPlatform.iOS
  //       : TargetPlatform.android;

  //   return this.setPlatform(
  //     currentPlatform == TargetPlatform.iOS
  //         ? TargetPlatform.android
  //         : TargetPlatform.iOS,
  //   );
  // }

  /// Returns a copy of `this`, overrided by `other`.
  /// The non-null values of `other` override the corresponding value of `this`.
  ExtendedThemeData merge(ExtendedThemeData other) {
    return ExtendedThemeData(
      base: ThemeData(
        accentColor: other.base?.accentColor ?? this.base?.accentColor,
        accentColorBrightness: other.base?.accentColorBrightness ??
            this.base?.accentColorBrightness,
        accentIconTheme:
            other.base?.accentIconTheme ?? this.base?.accentIconTheme,
        accentTextTheme:
            other.base?.accentTextTheme ?? this.base?.accentTextTheme,
        applyElevationOverlayColor: other.base?.applyElevationOverlayColor ??
            this.base?.applyElevationOverlayColor,
        backgroundColor:
            other.base?.backgroundColor ?? this.base?.backgroundColor,
        bottomAppBarColor:
            other.base?.bottomAppBarColor ?? this.base?.bottomAppBarColor,
        brightness: other.base?.brightness ?? this.base?.brightness,
        buttonColor: other.base?.buttonColor ?? this.base?.buttonColor,
        canvasColor: other.base?.canvasColor ?? this.base?.canvasColor,
        cardColor: other.base?.cardColor ?? this.base?.cardColor,
        cursorColor: other.base?.cursorColor ?? this.base?.cursorColor,
        dialogBackgroundColor: other.base?.dialogBackgroundColor ??
            this.base?.dialogBackgroundColor,
        disabledColor: other.base?.disabledColor ?? this.base?.disabledColor,
        dividerColor: other.base?.dividerColor ?? this.base?.dividerColor,
        errorColor: other.base?.errorColor ?? this.base?.errorColor,
        focusColor: other.base?.focusColor ?? this.base?.focusColor,
        highlightColor: other.base?.highlightColor ?? this.base?.highlightColor,
        hintColor: other.base?.hintColor ?? this.base?.hintColor,
        hoverColor: other.base?.hoverColor ?? this.base?.hoverColor,
        indicatorColor: other.base?.indicatorColor ?? this.base?.indicatorColor,
        materialTapTargetSize: other.base?.materialTapTargetSize ??
            this.base?.materialTapTargetSize,
        platform: other.base?.platform ?? this.base?.platform,
        primaryColor: other.base?.primaryColor ?? this.base?.primaryColor,
        primaryColorBrightness: other.base?.primaryColorBrightness ??
            this.base?.primaryColorBrightness,
        primaryColorDark:
            other.base?.primaryColorDark ?? this.base?.primaryColorDark,
        primaryColorLight:
            other.base?.primaryColorLight ?? this.base?.primaryColorLight,
        scaffoldBackgroundColor: other.base?.scaffoldBackgroundColor ??
            this.base?.scaffoldBackgroundColor,
        secondaryHeaderColor:
            other.base?.secondaryHeaderColor ?? this.base?.secondaryHeaderColor,
        selectedRowColor:
            other.base?.selectedRowColor ?? this.base?.selectedRowColor,
        splashColor: other.base?.splashColor ?? this.base?.splashColor,
        textSelectionColor:
            other.base?.textSelectionColor ?? this.base?.textSelectionColor,
        textSelectionHandleColor: other.base?.textSelectionHandleColor ??
            this.base?.textSelectionHandleColor,
        toggleableActiveColor: other.base?.toggleableActiveColor ??
            this.base?.toggleableActiveColor,
        unselectedWidgetColor: other.base?.unselectedWidgetColor ??
            this.base?.unselectedWidgetColor,
        typography: other.base?.typography ?? this.base?.typography,
        buttonTheme: other.base?.buttonTheme ?? this.base?.buttonTheme,
        appBarTheme: other.base?.appBarTheme ?? this.base?.appBarTheme,
        bannerTheme: other.base?.bannerTheme ?? this.base?.bannerTheme,
        bottomAppBarTheme:
            other.base?.bottomAppBarTheme ?? this.base?.bottomAppBarTheme,
        bottomSheetTheme:
            other.base?.bottomSheetTheme ?? this.base?.bottomSheetTheme,
        cardTheme: other.base?.cardTheme ?? this.base?.cardTheme,
        chipTheme: other.base?.chipTheme ?? this.base?.chipTheme,
        colorScheme: other.base?.colorScheme ?? this.base?.colorScheme,
        cupertinoOverrideTheme: other.base?.cupertinoOverrideTheme ??
            this.base?.cupertinoOverrideTheme,
        dialogTheme: other.base?.dialogTheme ?? this.base?.dialogTheme,
        dividerTheme: other.base?.dividerTheme ?? this.base?.dividerTheme,
        floatingActionButtonTheme: other.base?.floatingActionButtonTheme ??
            this.base?.floatingActionButtonTheme,
        iconTheme: other.base?.iconTheme ?? this.base?.iconTheme,
        inputDecorationTheme:
            other.base?.inputDecorationTheme ?? this.base?.inputDecorationTheme,
        pageTransitionsTheme:
            other.base?.pageTransitionsTheme ?? this.base?.pageTransitionsTheme,
        popupMenuTheme: other.base?.popupMenuTheme ?? this.base?.popupMenuTheme,
        primaryIconTheme:
            other.base?.primaryIconTheme ?? this.base?.primaryIconTheme,
        primaryTextTheme:
            other.base?.primaryTextTheme ?? this.base?.primaryTextTheme,
        sliderTheme: other.base?.sliderTheme ?? this.base?.sliderTheme,
        snackBarTheme: other.base?.snackBarTheme ?? this.base?.snackBarTheme,
        splashFactory: other.base?.splashFactory ?? this.base?.splashFactory,
        tabBarTheme: other.base?.tabBarTheme ?? this.base?.tabBarTheme,
        textTheme: other.base?.textTheme ?? this.base?.textTheme,
        toggleButtonsTheme:
            other.base?.toggleButtonsTheme ?? this.base?.toggleButtonsTheme,
        tooltipTheme: other.base?.tooltipTheme ?? this.base?.tooltipTheme,
      ),
      custom: other.custom ?? this.custom,
    );
  }

  factory ExtendedThemeData.fromBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return ExtendedThemeData.light();
      default:
        return ExtendedThemeData.dark();
    }
  }

  factory ExtendedThemeData.light() => ExtendedThemeData(
        base: ThemeData(
            brightness: Brightness.light,
            dialogTheme: const DialogTheme(
              titleTextStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            snackBarTheme: const SnackBarThemeData(
              backgroundColor: const Color(0xff2d2d2d),
              actionTextColor: Colors.white,
            ),
            cupertinoOverrideTheme: const CupertinoThemeData(
              barBackgroundColor: Colors.blue,
              textTheme: const CupertinoTextThemeData(
                navActionTextStyle: const TextStyle(
                  inherit: false,
                  fontFamily: '.SF Pro Text',
                  fontSize: 17.0,
                  letterSpacing: -0.41,
                  color: CupertinoColors.white,
                  decoration: TextDecoration.none,
                ),
                navTitleTextStyle: const TextStyle(
                  inherit: false,
                  fontFamily: '.SF Pro Text',
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.41,
                  color: CupertinoColors.white,
                ),
              ),
            )),
      );
  factory ExtendedThemeData.dark() => ExtendedThemeData(
        base: ThemeData(
          brightness: Brightness.dark,
        ),
      );
  factory ExtendedThemeData.trueDark() => ExtendedThemeData(
        base: ThemeData(
          brightness: Brightness.dark,
        ),
      );
}

/// Base class that doesn't do anything.
///
/// You can extend this class to add custom theme data.
/// However, check if the value you want to add doesn't already exist in a regular ThemeData.
abstract class CustomThemeData {}

/// Creates a Theme widget from an ExtendedThemeData.
///
/// To access the data:
/// - base data: as usual, `Theme.of(context)`
/// - custom data: `CustomTheme.of<T>(context)` where T is your extended class
class CustomTheme extends StatelessWidget {
  final ExtendedThemeData data;
  final Widget child;
  final bool isMaterialAppTheme;
  final Key themeKey;
  final Key customThemeKey;

  /// Inherits a CustomThemeData from the [context].
  ///
  /// If you want to inherit the base ThemeData instead, you should use
  /// `Theme.of(context)`.
  ///
  /// `T` is a class extended from CustomThemeData
  static T of<T extends CustomThemeData>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedCustomTheme)
            as _InheritedCustomTheme)
        .data as T;
  }

  const CustomTheme({
    Key key,
    this.themeKey,
    this.customThemeKey,
    @required this.data,
    @required this.child,
    this.isMaterialAppTheme = false,
  })  : assert(data != null),
        super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return _InheritedCustomTheme(
      child: Theme(
        key: themeKey,
        data: data.base,
        isMaterialAppTheme: isMaterialAppTheme,
        child: child,
      ),
      data: data.custom,
      key: customThemeKey,
    );
  }
}

class _InheritedCustomTheme extends InheritedWidget {
  final CustomThemeData data;

  const _InheritedCustomTheme({
    @required this.data,
    @required Widget child,
    Key key,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(_InheritedCustomTheme oldWidget) =>
      oldWidget.data != this.data;
}
