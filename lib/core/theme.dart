import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
