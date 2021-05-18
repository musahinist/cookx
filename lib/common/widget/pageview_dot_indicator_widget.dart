import 'package:flutter/material.dart';

class PageViewDotIndicator extends StatelessWidget {
  const PageViewDotIndicator({
    Key? key,
    required this.dotCount,
    required this.currentIndex,
  }) : super(key: key);

  final int dotCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotCount,
        (index) {
          final double size = currentIndex == index ? 9 : 6;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: currentIndex == index ? Colors.amber[700] : Colors.grey,
                borderRadius: BorderRadius.circular(size / 2)),
            width: size,
            height: size,
          );
        },
      ),
    );
  }
}
