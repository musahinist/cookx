import 'package:flutter/material.dart';

import '../../view/page/app_navigator.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigator.$PATH:
        return MaterialPageRoute(builder: (_) => const AppNavigator());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
