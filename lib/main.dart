import 'dart:math' as math;

import 'package:flutter/material.dart';

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
      home: const FortuneWheel(),
    );
  }
}

class FortuneWheel extends StatefulWidget {
  const FortuneWheel({
    Key? key,
  }) : super(key: key);

  @override
  _FortuneWheelState createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  ScrollController ctrl = ScrollController();
  late Animation<double> rotate;
  final Duration rotationDuration = const Duration(seconds: 7);
  Curve rotateCurve = Curves.bounceOut;
  final Tween<double> _rotationTween = Tween(begin: 0, end: 1);
  int rotateMargin = 0;
  double radius = 100;
  int count = 8;

  @override
  void initState() {
    super.initState();
    setAnimation();
  }

  void setAnimation() {
    animationController = AnimationController(
      duration: rotationDuration,
      vsync: this,
    );
    // animationController.repeat();

    rotate = _rotationTween.animate(CurvedAnimation(
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
          if (animationController.isCompleted) {
            animationController.reset();
            rotateMargin = math.Random().nextInt(count);
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
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: NetworkImage(
                //       'https://cdn.imgbin.com/16/6/7/imgbin-template-game-show-wheel-others-7rzmirYGArZp1c3MEGBSGvn8d.jpg'),
                // ),
              ),
              height: 2 * radius,
              width: 2 * radius,
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
            Transform.rotate(
              angle: rotate.value * 8 * math.pi +
                  math.pi / 2 +
                  rotateMargin * 2 * math.pi / count,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      //  color: Colors.yellow,
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
                                (25 + rotate.value * radius) *
                                    math.cos(-i * 2 * math.pi / count),
                            (radius - 20) +
                                (25 + rotate.value * radius) *
                                    math.sin(-i * 2 * math.pi / count)),
                      child: AnimatedOpacity(
                        opacity: animationController.isAnimating
                            ? 1
                            : animationController.isCompleted &&
                                    i == rotateMargin
                                ? 1
                                : 0.3,
                        duration: Duration(milliseconds: 500),
                        child: Profile(
                          rotate: rotate,
                          rotateMargin: rotateMargin * 1.0,
                          index: i,
                          // magnify: animationController.isCompleted &&
                          //         i == rotateMargin
                          //     ? 1.2
                          //     : 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: NetworkImage(
                //       'https://cdn.imgbin.com/16/6/7/imgbin-template-game-show-wheel-others-7rzmirYGArZp1c3MEGBSGvn8d.jpg'),
                // ),
              ),
              height: radius,
              width: radius,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(rotateMargin.toString()),
            )
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile(
      {Key? key,
      required this.rotate,
      required this.rotateMargin,
      required this.index,
      this.magnify = 1})
      : super(key: key);

  final Animation<double> rotate;
  final double rotateMargin;
  final int index;
  final double magnify;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -rotate.value * 8 * math.pi -
            math.pi / 2 -
            rotateMargin * 2 * math.pi / 8,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 20 * magnify,
              backgroundColor: Colors.yellow,
              // backgroundImage: NetworkImage(
              //     'https://www.eaclinic.co.uk/wp-content/uploads/2019/01/woman-face-eyes-1000x1000.jpg'),
            ),
            Text(
              index.toString(),
              style: const TextStyle(fontSize: 24),
            )
          ],
        ));
  }
}
