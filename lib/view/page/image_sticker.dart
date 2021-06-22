import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cookx/view/widget/keyboard_hider_widget.dart';

import 'color_picker.dart';

class ImageSticker extends StatefulWidget {
  const ImageSticker({Key? key}) : super(key: key);

  @override
  _ImageStickerState createState() => _ImageStickerState();
}

class _ImageStickerState extends State<ImageSticker>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation1 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 1.5),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );
  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: const Offset(0.0, 1.5),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool isTextEditVisible = false;
  TextEditingController textCtrl = TextEditingController();

  List<Widget> stickers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardHider(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox.expand(
                child: InteractiveViewer(
                  child: const Image(
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/2e/f5/38/2ef538b144db555f8dcd4bbc34c17e84.jpg'),
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
                          _controller.reverse();

                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.text_fields, color: Colors.white),
                        onPressed: () {
                          _controller.forward();

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              StickerInput(
                animation: _offsetAnimation1,
                textController: textCtrl,
                stickers: ['asset/svg/avatar.svg', 'asset/svg/baby.svg'],
                onTap: (path) {
                  stickers.add(SvgPicture.asset(path));
                  setState(() {});
                },
              ),
              TextInput(
                animation: _offsetAnimation2,
                textController: textCtrl,
                colors: [
                  Colors.white,
                  Colors.blue,
                  Colors.yellow,
                  Colors.green
                ],
                onTap: (color) {
                  stickers.add(Text(
                    textCtrl.text,
                    style: TextStyle(color: color),
                  ));
                  textCtrl.clear();
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StickerInput extends StatefulWidget {
  final Animation<Offset> animation;
  final ValueSetter onTap;
  final List<String> stickers;
  final TextEditingController textController;
  const StickerInput({
    Key? key,
    required this.animation,
    required this.onTap,
    required this.stickers,
    required this.textController,
  }) : super(key: key);

  @override
  _StickerInputState createState() => _StickerInputState();
}

class _StickerInputState extends State<StickerInput> {
  Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: kToolbarHeight,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(30)),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(widget.stickers.length, (index) {
                  final String sticker = widget.stickers[index];
                  return InkWell(
                    onTap: () {
                      widget.onTap(sticker);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(sticker),
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  final Animation<Offset> animation;
  final ValueSetter onTap;
  final List<Color> colors;
  final TextEditingController textController;
  const TextInput({
    Key? key,
    required this.animation,
    required this.onTap,
    required this.colors,
    required this.textController,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: FastColorPicker(
              selectedColor: textColor,
              onColorSelected: (color) {
                setState(() {
                  textColor = color;
                });
              },
            ),
          ),
          // Row(
          //   children: [
          //     ...List.generate(widget.colors.length, (index) {
          //       final Color color = widget.colors[index];
          //       return InkWell(
          //         onTap: () {
          //           textColor = color;
          //           setState(() {});
          //         },
          //         child: Container(
          //           margin: EdgeInsets.all(8),
          //           height: 24,
          //           width: 24,
          //           decoration:
          //               BoxDecoration(color: color, shape: BoxShape.circle),
          //         ),
          //       );
          //     })
          //   ],
          // ),
          Container(
            height: kToolbarHeight,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(30)),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  controller: widget.textController,
                  //  autofocus: true,
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
                    if (widget.textController.text.isNotEmpty) {
                      widget.onTap(textColor);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
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
                  // onPanStart: (details) {
                  //   x0 = details.globalPosition.dx - initWidth + 13;
                  //   y0 = details.globalPosition.dy - initHeight + 13;
                  //   setState(() {});
                  // },
                  onPanUpdate: (details) {
                    if (details.globalPosition.dx > x0 + 50) {
                      currWidth = details.globalPosition.dx - x0;
                    }
                    if (details.globalPosition.dy > y0 + 50) {
                      currHeight = details.globalPosition.dy - y0;
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
                    child: AbsorbPointer(
                      child: Container(
                          height: ballDiameter,
                          width: ballDiameter,
                          decoration: BoxDecoration(
                              color: Colors.pink, shape: BoxShape.circle),
                          child: Icon(Icons.fullscreen_exit,
                              size: ballDiameter, color: Colors.white)),
                    ),
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
