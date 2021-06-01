import 'dart:math' as math;

import 'package:flutter/material.dart';

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
      duration: const Duration(seconds: 1),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final Tween<double> _radiusTween = Tween(begin: 0.0, end: 200);
    final Tween<double> _rotationTween = Tween(begin: -math.pi, end: math.pi);

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   title: Text('Polygons'),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            //  height: 250,
            width: double.maxFinite,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Opacity(
                    opacity:
                        animation2.value >= 150 ? animation2.value / 200 : 0,
                    child: ClipPath(
                      clipper: CustomClipPath(),
                      child:
                          Container(width: 80, height: 48, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 48,
                  ),
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, snapshot) {
                      return Opacity(
                        opacity: animation2.value >= 150
                            ? animation2.value / 200
                            : 0,
                        child: Container(
                          padding:
                              EdgeInsets.all(12.0 * animation2.value / 200),
                          // margin: EdgeInsets.all(animation2.value / 200),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  2400 / animation2.value)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_alarm,
                                      size: 24 * animation2.value / 200),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'sdfsdfsfsdfdsf',
                                      style: TextStyle(
                                          fontSize:
                                              16 * animation2.value / 200),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_alarm,
                                      size: 24 * animation2.value / 200),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'sdfsdfsfsdfdsf',
                                      style: TextStyle(
                                          fontSize:
                                              16 * animation2.value / 200),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_alarm,
                                      size: 24 * animation2.value / 200),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'sdfsdfsfsdfdsf',
                                      style: TextStyle(
                                          fontSize:
                                              16 * animation2.value / 200),
                                    ),
                                  ),
                                ],
                              ),
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
                  backgroundColor: Colors.white,
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
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.purple,
                    child: CircleAvatar(radius: 22),
                  ),
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

class CustomClipPath extends CustomClipper<Path> {
  var radius = 24.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(radius, 0.0);
    path.arcToPoint(Offset(0.0, radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(0.0, size.height);
    // path.arcToPoint(Offset(radius, size.height),
    //     clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width, size.height);
    // path.arcToPoint(Offset(size.width, size.height - radius),
    //     clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width, 0);
    // path.arcToPoint(Offset(size.width - radius, 0.0),
    //     clockwise: true, radius: Radius.circular(radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// FOR PAINTING POLYGONS
class ShapePainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;
  ShapePainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final angle = (math.pi * 2) / sides;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset startPoint =
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
