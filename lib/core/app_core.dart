import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app.dart';
import 'package:flutter_app_core/core/navigation_data.dart';
import 'package:flutter_app_core/flutter_app_core.dart';
import 'package:flutter_app_core/modules/modules.dart';
import 'package:flutter/widgets.dart'
    show StatelessWidget, required, Widget, BuildContext, Builder;

/// TODO: documentation
class AppCore extends StatelessWidget {
  final List<AppCoreModule> modules;
  final NavigationData navigation;

  AppCore({
    this.modules: const <AppCoreModule>[],
    @required this.navigation,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: navigation.build);
  }

  Future navigateTo(route) {
    return navigation.navigateTo(route);
  }

  static String getThemeName(BuildContext context){
    return SharedApp.of(context).getThemeName();
  }

  static ExtendedThemeData getTheme(BuildContext context){
    return SharedApp.of(context).getTheme();
  }

  static void setTheme(BuildContext context, String newTheme){
    SharedApp.of(context).setTheme(newTheme);
  }

  static void setPlatform(BuildContext context, TargetPlatform platform) {
    SharedApp.of(context).setPlatform(platform);
  }

  static TargetPlatform switchPlatform(BuildContext context) {
    TargetPlatform newPlatform =
        (SharedApp.of(context).getPlatform() == TargetPlatform.iOS)
            ? TargetPlatform.android
            : TargetPlatform.iOS;
    SharedApp.of(context).setPlatform(newPlatform);
    return newPlatform;
  }

  static AppCore of(BuildContext context) {
    return context.ancestorWidgetOfExactType(AppCore);
  }
}
