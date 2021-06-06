import 'package:cookx/store/recipe/recipe_store.dart';
import 'package:cookx/view/page/app_navigator.dart';
import 'package:cookx/view/sample/drop_down_menu.dart';
import 'package:cookx/view/sample/sliver_appbar_sample.dart';
import 'package:cookx/view/sample/wheel_pcker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router/app_router.dart';
import 'util/log/log.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Log.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cookx',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      //  onGenerateRoute: AppRouter.generateRoute,
      home: Nav(),
    );
  }
}
