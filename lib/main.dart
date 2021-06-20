import 'package:cookx/view/page/app_navigator.dart';
import 'package:cookx/view/page/curved_line_chart.dart';
import 'package:cookx/view/page/fl_chart.dart';
import 'package:cookx/view/page/image_sticker.dart';
import 'package:flutter/material.dart';

import 'util/log/log.dart';
import 'view/page/fotune_whell.dart';

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
      home: Scaffold(body: ImageSticker()),
    );
  }
}
