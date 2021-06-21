import 'dart:math';

import 'package:cookx/view/widget/keyboard_hider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSticker extends StatefulWidget {
  const ImageSticker({Key? key}) : super(key: key);

  @override
  _ImageStickerState createState() => _ImageStickerState();
}

class _ImageStickerState extends State<ImageSticker>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool isTextEditVisible = false;
  TextEditingController textCtrl = TextEditingController();
  Color textColor = Colors.white;
  List<Widget> stickers = [
    Image(
      image: NetworkImage(
          "https://www.baskiyap.com/image/catalog/product/Sticker/karpuz-dilim.png"),
    ),
    Text(
      "sdfsdfsdfsdfsdfsdfsdfddf",
      style: TextStyle(color: Colors.white),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: KeyboardHider(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox.expand(
              child: InteractiveViewer(
                child: Image(
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/2e/f5/38/2ef538b144db555f8dcd4bbc34c17e84.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Stack(
              children: List.generate(stickers.length, (index) {
                Widget sticker = stickers[index];
                return Sticker(
                  index: index,
                  child: sticker,
                );
              }),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(8),
                width: kToolbarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black.withOpacity(.3),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.emoji_emotions_outlined,
                          color: Colors.white),
                      onPressed: () {
                        stickers.add(SvgPicture.asset("asset/svg/avatar.svg"));

                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.text_fields, color: Colors.white),
                      onPressed: () {
                        if (_controller.isCompleted) {
                          _controller.reverse();
                          setState(() {});
                        } else {
                          _controller.forward();
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          textColor = Colors.blue;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          textColor = Colors.yellow;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.yellow, shape: BoxShape.circle),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          textColor = Colors.white;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: kToolbarHeight,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: textCtrl,
                          autofocus: true,
                          maxLength: 30,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 4, right: 15),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            if (textCtrl.text.isNotEmpty) {
                              stickers.add(Text(
                                textCtrl.text,
                                style: TextStyle(color: textColor),
                              ));
                              textCtrl.clear();

                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Sticker extends StatefulWidget {
  final Widget child;
//  final VoidCallback remove;
  final int index;
  const Sticker({
    Key? key,
    required this.child,
    //   required this.remove,
    required this.index,
  }) : super(key: key);

  @override
  _StickerState createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  double x0 = 100;
  double y0 = 100;
  double? currHeight;
  double? currWidth;
  double initHeight = 100;
  double initWidth = 100;
  bool isVisible = false;
  double initialAngle = 0.0;
  double finalAngle = 0;
  bool isStickerVisible = true;
  double ballDiameter = 24.0;
  // double scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x0,
      top: y0,
      child: Visibility(
        visible: isStickerVisible,
        maintainSize: true,
        maintainState: true,
        maintainAnimation: true,
        child: Container(
          height: currHeight ?? initHeight,
          width: currWidth ?? initWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                child: Container(
                  height: currHeight ?? initHeight,
                  width: currWidth ?? initWidth,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: isVisible
                          ? Border.all(color: Colors.pink, width: 2)
                          : null),
                  child: Transform.rotate(
                    angle: finalAngle,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Center(child: widget.child),
                    ),
                  ),
                ),
              ),
              //SCALE
              if (isVisible)
                GestureDetector(
                  onPanStart: (details) {
                    x0 = details.globalPosition.dx - initWidth + 13;
                    y0 = details.globalPosition.dy - initHeight + 13;
                    setState(() {});
                  },
                  onPanUpdate: (details) {
                    if (details.globalPosition.dx > x0 + 50) {
                      currWidth = details.globalPosition.dx + 13 - x0;
                    }
                    if (details.globalPosition.dy > y0 + 50) {
                      currHeight = details.globalPosition.dy + 13 - y0;
                    }
                    setState(() {});
                  },
                  onPanEnd: (details) {
                    initWidth = currWidth!;
                    initHeight = currHeight!;
                    setState(() {});
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        height: ballDiameter,
                        width: ballDiameter,
                        decoration: BoxDecoration(
                            color: Colors.pink, shape: BoxShape.circle),
                        child: Icon(Icons.fullscreen_exit,
                            size: ballDiameter, color: Colors.white)),
                  ),
                ),
              //MOVE
              if (isVisible)
                GestureDetector(
                  onPanUpdate: (details) {
                    if (details.globalPosition.dx > 12) {
                      x0 = details.globalPosition.dx - 12;
                    }
                    if (details.globalPosition.dy > 12) {
                      y0 = details.globalPosition.dy - 12;
                    }

                    setState(() {});
                  },
                  child: Container(
                    height: ballDiameter,
                    width: ballDiameter,
                    decoration: BoxDecoration(
                        color: Colors.pink, shape: BoxShape.circle),
                    child: Icon(
                      Icons.drag_indicator_rounded,
                      size: ballDiameter,
                      color: Colors.white,
                    ),
                  ),
                ),
              //REMOVE
              if (isVisible)
                GestureDetector(
                  onTap: () {
                    isStickerVisible = false;
                    setState(() {});
                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: ballDiameter,
                      width: ballDiameter,
                      decoration: BoxDecoration(
                          color: Colors.pink, shape: BoxShape.circle),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: ballDiameter,
                      ),
                    ),
                  ),
                ),
              //ROTATE
              if (isVisible)
                LayoutBuilder(builder: (context, constraints) {
                  return GestureDetector(
                    onPanStart: (details) {
                      Offset centerOfGestureDetector = Offset(
                          constraints.maxWidth / 2, constraints.maxHeight / 2);
                      final touchPositionFromCenter =
                          details.localPosition - centerOfGestureDetector;
                      print(touchPositionFromCenter.direction * 180 / pi);
                      setState(
                        () {
                          initialAngle =
                              touchPositionFromCenter.direction - finalAngle;
                        },
                      );
                    },
                    onPanUpdate: (details) {
                      Offset centerOfGestureDetector = Offset(
                          constraints.maxWidth / 2, constraints.maxHeight / 2);
                      final touchPositionFromCenter =
                          details.localPosition - centerOfGestureDetector;
                      print(touchPositionFromCenter.direction * 180 / pi);
                      setState(
                        () {
                          finalAngle =
                              touchPositionFromCenter.direction - initialAngle;
                        },
                      );
                    },
                    // onPanEnd: (details) {
                    //   setState(
                    //     () {
                    //       initialAngle = finalAngle;
                    //     },
                    //   );
                    // },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: ballDiameter,
                        width: ballDiameter,
                        decoration: BoxDecoration(
                            color: Colors.pink, shape: BoxShape.circle),
                        child: Icon(
                          Icons.rotate_right_rounded,
                          size: ballDiameter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                })
            ],
          ),
        ),
      ),
    );
  }
}
