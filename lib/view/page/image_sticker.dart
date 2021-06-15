import 'dart:ffi';

import 'package:flutter/material.dart';

class ImageSticker extends StatefulWidget {
  const ImageSticker({Key? key}) : super(key: key);

  @override
  _ImageStickerState createState() => _ImageStickerState();
}

class _ImageStickerState extends State<ImageSticker> {
  double? x0;
  double? y0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              left: x0,
              top: y0,
              child: Sticker(
                onMove: (details) {
                  x0 = details.globalPosition.dx - 12;
                  y0 = details.globalPosition.dy - 12;
                  setState(() {});
                },
              ))
        ],
      ),
    );
  }
}

class Sticker extends StatefulWidget {
  final void Function(DragUpdateDetails)? onMove;
  const Sticker({
    Key? key,
    required this.onMove,
  }) : super(key: key);

  @override
  _StickerState createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  double? x0;
  double? y0;
  double? currSize;
  double initSize = 100;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: currSize ?? initSize,
      width: currSize ?? initSize,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              isVisible = !isVisible;
              setState(() {});
            },
            child: Container(
              height: currSize ?? initSize,
              width: currSize ?? initSize,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: isVisible
                      ? Border.all(color: Colors.grey, width: 4)
                      : null),
              child: Image(
                image: NetworkImage(
                    "https://www.baskiyap.com/image/catalog/product/Sticker/karpuz-dilim.png"),
              ),
            ),
          ),
          if (isVisible)
            GestureDetector(
              onPanStart: (details) {
                x0 = details.globalPosition.dx - initSize;
                y0 = details.globalPosition.dy - initSize;
                setState(() {});
              },
              onPanUpdate: (details) {
                currSize = details.globalPosition.dx - x0!;
                setState(() {});
              },
              onPanEnd: (details) {
                initSize = currSize!;
                setState(() {});
              },
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: Icon(Icons.fullscreen_exit))),
            ),
          if (isVisible)
            GestureDetector(
              onPanUpdate: widget.onMove,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  child: Icon(Icons.drag_indicator_rounded),
                ),
              ),
            ),
          if (isVisible)
            GestureDetector(
              //  onPanUpdate: widget.onMove,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  child: Icon(Icons.rotate_right_rounded),
                ),
              ),
            )
        ],
      ),
    );
  }
}
