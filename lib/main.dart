import 'package:cookx/store/recipe/recipe_store.dart';
import 'package:cookx/view/page/app_navigator.dart';
import 'package:cookx/view/page/fotune_whell.dart';
import 'package:cookx/view/sample/drop_down_menu.dart';
import 'package:cookx/view/sample/sliver_appbar_sample.dart';
import 'package:cookx/view/sample/wheel_pcker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router/app_router.dart';
import 'util/log/log.dart';
import 'dart:math' as math;

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
      home: Wheel(),
    );
  }
}

class Wheel extends StatefulWidget {
  Wheel({
    Key? key,
  }) : super(key: key);

  @override
  _WheelState createState() => _WheelState();
}

class _WheelState extends State<Wheel> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotateY;
  @override
  initState() {
    super.initState();
    animationController = new AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    rotateY = new Tween<double>(
      begin: .0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotatedBox(
          quarterTurns: -1,
          child: ListWheelScrollView.useDelegate(
            physics: FixedExtentScrollPhysics(),
            itemExtent: 350, perspective: 0.01,
            //  useMagnifier: true,
            diameterRatio: 1, renderChildrenOutsideViewport: true,
            squeeze: 2,
            clipBehavior: Clip.none,
            offAxisFraction: -.5, //squeeze: 6, // perspective: 0.0099,
            //  renderChildrenOutsideViewport: true,
            //  perspective: 0.009,
            //  magnification: 1.3,
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List<Widget>.generate(
                10,
                (index) => RotatedBox(
                    quarterTurns: 1,
                    child:
                        CircleAvatar(radius: 100, child: Text('${index + 1}'))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
