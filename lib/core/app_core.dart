import 'package:flutter_app_core/core/navigation_data.dart';
import 'package:flutter_app_core/modules/modules.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart' show PlatformProvider;
import 'package:flutter/widgets.dart' show StatelessWidget, required, Widget, BuildContext, Builder;

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
    return PlatformProvider(
      builder: (_) => Builder(builder: navigation.build),
    );
  }

  Future navigateTo(route){
    return navigation.navigateTo(route);
  }

  static AppCore of(BuildContext context){
    return context.ancestorWidgetOfExactType(AppCore);
  }


}

