import 'package:flutter/material.dart';
import 'dart:math' as math;

class DropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPainter(),
    );
  }
}

class MyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> with TickerProviderStateMixin {
  var _sides = 3.0;

  late Animation<double> animation;
  late AnimationController controller;

  late Animation<double> animation2;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    Tween<double> _radiusTween = Tween(begin: 0.0, end: 200);
    Tween<double> _rotationTween = Tween(begin: -math.pi, end: math.pi);

    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    animation2 = _radiusTween
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          });

    controller.forward();
    //  controller2.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygons'),
      ),
      body: GestureDetector(
        onTap: () {
          controller2.reverse();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            //  height: 250,
            width: double.maxFinite,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, snapshot) {
                      return Container(
                        //   width: animation2.value,
                        //  height: animation2.value,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.circular(1000 / animation2.value)),
                        child: Padding(
                          padding:
                              EdgeInsets.all(24.0 * animation2.value / 200),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "sdfsdfsfsdfdsf",
                                  style: TextStyle(
                                      fontSize: 16 * animation2.value / 200),
                                ),
                              ),
                              Text(
                                "sdfsdfsfsdfdsf",
                                style: TextStyle(
                                    fontSize: 16 * animation2.value / 200),
                              ),
                              Text(
                                "sdfsdfsfsdfdsf",
                                style: TextStyle(
                                    fontSize: 16 * animation2.value / 200),
                              ),
                              Text(
                                "sdfsdfsfsdfdsf",
                                style: TextStyle(
                                    fontSize: 16 * animation2.value / 200),
                              ),
                              Text(
                                "sdfsdfsfsdfdsf",
                                style: TextStyle(
                                    fontSize: 16 * animation2.value / 200),
                              )
                            ],
                          ),
                        ),
                      );
                      // return CustomPaint(
                      //   painter:
                      //       ShapePainter(_sides, animation2.value, animation.value),
                      //   child: Container(),
                      // );
                    },
                  ),
                ),
                FloatingActionButton(
                  elevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  onPressed: () {
                    if (animation2.isCompleted) {
                      controller2.reverse();
                    } else if (animation2.isDismissed) {
                      controller2.forward();
                    }
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 24.0),
                //   child: Text('Sides'),
                // ),
                // Slider(
                //   value: _sides,
                //   min: 3.0,
                //   max: 10.0,
                //   label: _sides.toInt().toString(),
                //   divisions: 7,
                //   onChanged: (value) {
                //     setState(() {
                //       _sides = value;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// FOR PAINTING POLYGONS
class ShapePainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;
  ShapePainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();

    var angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.addOval(Rect.fromCircle(center: Offset(224, 200), radius: 24));
    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.stroke;
    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTWH(224, 200, 144 * -radius / 200, radius),
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ));
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
