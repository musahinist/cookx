import 'package:cookx/view/page/home_page.dart';
import 'package:cookx/view/page/search_page.dart';

import '../../store/recipe/recipe_store.dart';
import '../../view/page/recipe_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view/page/app_navigator.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Nav.$PATH:
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           Provider(create: (context) => RecipeStore(), child: Nav()));
      case HomePage.$PATH:
        return MaterialPageRoute(
            builder: (_) => Provider(
                create: (context) => RecipeStore(), child: HomePage()));
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
      case SearchPage.$PATH:
        return MaterialPageRoute(
          builder: (_) =>
              Provider(create: (context) => RecipeStore(), child: SearchPage()),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  // onGenerateRoute: (RouteSettings settings) {
  //       return MaterialPageRoute(
  //         settings: settings,
  //         builder: (BuildContext context) {
  //           switch(settings.name) {
  //             case '/':
  //               return RootPage(destination: widget.destination);
  //             case '/list':
  //               return ListPage(destination: widget.destination);
  //             case '/text':
  //               return TextPage(destination: widget.destination);
  //           }
  //         },
  //       );
  //     }
}
