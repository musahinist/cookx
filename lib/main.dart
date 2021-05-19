import 'package:flutter/material.dart';

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
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
