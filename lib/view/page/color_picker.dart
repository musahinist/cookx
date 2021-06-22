import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spring_button/spring_button.dart';

final Map<int, double> _correctSizes = {};
final PageController pageController = PageController(keepPage: true);

class FastColorPicker extends StatelessWidget {
  final Color selectedColor;
  final IconData? icon;
  final Function(Color) onColorSelected;

  const FastColorPicker({
    Key? key,
    this.icon,
    this.selectedColor = Colors.white,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => SizedBox(
        height: 66,
        width: size.maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: SelectedColor(
                    icon: icon,
                    selectedColor: selectedColor,
                    size: size.maxWidth,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    width: size.maxWidth,
                    child: PageView(
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Row(
                          children: createColors(
                              context, Constants.colors1, size.maxWidth),
                        ),
                        Row(
                          children: createColors(
                              context, Constants.colors2, size.maxWidth),
                        ),
                        Row(
                          children: createColors(
                              context, Constants.colors3, size.maxWidth),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SmoothPageIndicator(
              controller: pageController, // PageController
              count: 3,
              effect: const ScrollingDotsEffect(
                spacing: 8,
                activeDotColor: Colors.white,
                dotColor: Colors.white24,
                dotHeight: 8,
                dotWidth: 8,
                activeDotScale: 1,
              ),
            ),
            SizedBox(height: 6)
          ],
        ),
      ),
    );
  }

  List<Widget> createColors(
      BuildContext context, List<Color> colors, double maxWidth) {
    double size = correctButtonSize(
      colors.length,
      maxWidth,
    );
    return [
      for (var c in colors)
        SpringButton(
          SpringButtonType.OnlyScale,
          Padding(
            padding: EdgeInsets.all(size * 0.1),
            child: AnimatedContainer(
              width: size,
              height: size,
              duration: Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  width: c == selectedColor ? 4 : 2,
                  color: Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: size * 0.1,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            onColorSelected.call(c);
          },
          useCache: false,
          scaleCoefficient: 0.9,
          duration: 1000,
        ),
    ];
  }

  double correctButtonSize(int itemSize, double screenWidth) {
    double firstSize = 52;
    double maxWidth = screenWidth - firstSize;
    bool isSizeOkay = false;
    double finalSize = 48;
    do {
      finalSize -= 2;
      double eachSize = finalSize * 1.2;
      double buttonsArea = itemSize * eachSize;
      isSizeOkay = maxWidth > buttonsArea;
    } while (!isSizeOkay);
    _correctSizes[itemSize] = finalSize;
    return finalSize;
  }
}

class SelectedColor extends StatelessWidget {
  final Color selectedColor;
  final IconData? icon;
  final double size;
  double correctButtonSize(int itemSize, double screenWidth) {
    double firstSize = 52;
    double maxWidth = screenWidth - firstSize;
    bool isSizeOkay = false;
    double finalSize = 48;
    do {
      finalSize -= 2;
      double eachSize = finalSize * 1.2;
      double buttonsArea = itemSize * eachSize;
      isSizeOkay = maxWidth > buttonsArea;
    } while (!isSizeOkay);
    _correctSizes[itemSize] = finalSize;
    return finalSize;
  }

  const SelectedColor(
      {Key? key, required this.selectedColor, this.icon, required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double newsize = correctButtonSize(9, size);
    return Container(
      width: newsize,
      height: newsize,
      child: icon != null
          ? Icon(
              icon,
              color: selectedColor.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
              size: 22,
            )
          : null,
      decoration: BoxDecoration(
        color: selectedColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        boxShadow: [
          const BoxShadow(
            blurRadius: 6,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}

class Constants {
  static final List<Color> colors1 = const [
    const Color(0xFFFFFFFF),
    const Color(0xFF000000),
    const Color(0xFF3897F1),
    const Color(0xFF70C04F),
    const Color(0xFFFDCB5C),
    const Color(0xFFFC8D33),
    const Color(0xFFED4A57),
    const Color(0xFFD1086A),
    const Color(0xFFA208BA),
  ];
  static final List<Color> colors2 = const [
    const Color(0xFFED0014),
    const Color(0xFFEC858E),
    const Color(0xFFFFD3D4),
    const Color(0xFFFEDBB3),
    const Color(0xFFFFC482),
    const Color(0xFFD29046),
    const Color(0xFF99643A),
    const Color(0xFF432324),
    const Color(0xFF1C4928),
  ];
  static final List<Color> colors3 = const [
    const Color(0xFF262626),
    const Color(0xFF363636),
    const Color(0xFF555555),
    const Color(0xFF737373),
    const Color(0xFF999999),
    const Color(0xFFB2B2B2),
    const Color(0xFFC7C7C7),
    const Color(0xFFDBDBDB),
    const Color(0xFFEFEFEF),
  ];
}
