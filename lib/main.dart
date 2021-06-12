import 'dart:math';

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
  ScrollController ctrl = ScrollController();
  late Animation<double> rotate;
  final Duration rotationDuration = const Duration(seconds: 10);
  Curve rotateCurve = Curves.bounceOut;
  final Tween<double> _rotationTween = Tween(begin: 0, end: 1);
  int rotateMargin = 0;
  double radius = 100;
  int count = 8;

  @override
  initState() {
    super.initState();
    setAnimation();
  }

  setAnimation() {
    animationController = AnimationController(
      duration: rotationDuration,
      vsync: this,
    );
    // animationController.repeat();

    rotate = _rotationTween.animate(new CurvedAnimation(
      parent: animationController,
      curve: rotateCurve,
    ))
      ..addListener(() {
        setState(() {});
        if (animationController.isCompleted) {
          //  animationController.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          rotateMargin = math.Random().nextInt(count);
          rotateCurve = Curves.easeOut;
          if (animationController.isCompleted) {
            animationController.reset();
            animationController.forward();
          } else if (animationController.isDismissed) {
            animationController.forward();
          }
        },
      ),
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: rotate.value * 8 * math.pi +
                  rotateMargin * 2 * math.pi / count,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //       'https://cdn.imgbin.com/16/6/7/imgbin-template-game-show-wheel-others-7rzmirYGArZp1c3MEGBSGvn8d.jpg'),
                      // ),
                    ),
                    height: 2 * radius,
                    width: 2 * radius,
                  ),
                  ...List.generate(
                    count,
                    (i) => Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            (radius - 20) +
                                (rotate.value * radius * 1.3) *
                                    cos(-i * 2 * math.pi / count),
                            (radius - 20) +
                                (rotate.value * radius * 1.3) *
                                    sin(-i * 2 * math.pi / count)),
                      child: Profile(
                        rotate: rotate,
                        rotateMargin: rotateMargin * 1.0,
                        index: i,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(rotateMargin.toString()),
          )
        ],
      )),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile(
      {Key? key,
      required this.rotate,
      required this.rotateMargin,
      required this.index})
      : super(key: key);

  final Animation<double> rotate;
  final double rotateMargin;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -rotate.value * 8 * math.pi - rotateMargin * 2 * math.pi / 8,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              // backgroundImage: NetworkImage(
              //     'https://www.eaclinic.co.uk/wp-content/uploads/2019/01/woman-face-eyes-1000x1000.jpg'),
            ),
            Text(
              index.toString(),
              style: TextStyle(fontSize: 24),
            )
          ],
        ));
  }
}
