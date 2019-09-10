import 'package:flutter/widgets.dart';

abstract class NavigationData {
  Widget build(BuildContext context);
  Future navigateTo(String route);
}

