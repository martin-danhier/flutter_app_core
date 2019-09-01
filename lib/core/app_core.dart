import 'package:flutter/cupertino.dart';
import 'package:flutter_app_core/core/navigation_data.dart';
import 'package:flutter_app_core/modules/modules.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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

}
