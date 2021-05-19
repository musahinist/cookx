import '../../store/recipe/recipe_store.dart';
import '../../view/page/recipe_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view/page/app_navigator.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigator.$PATH:
        return MaterialPageRoute(
            builder: (_) => Provider(
                create: (context) => RecipeStore(),
                child: const AppNavigator()));
      case RecipeDetailPage.$PATH:
        return MaterialPageRoute(
          builder: (_) => Provider(
              create: (context) => RecipeStore(),
              child: RecipeDetailPage(
                recipeId: settings.arguments! as int,
              )),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
