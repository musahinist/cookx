import 'package:flutter/material.dart';

import '../../data/model/recipe.dart';
import '../page/recipe_detail.dart';
import 'page_view_indicator_widget.dart';
import 'recipe_card_widget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    Key? key,
    required this.recipes,
    this.notchColor = Colors.white,
  }) : super(key: key);
  final List<Recipe> recipes;
  final Color notchColor;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 330.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            const ListTile(
              dense: true,
              title: Text(
                'Recipes of the Day',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 280,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  PageView.builder(
                    itemCount: widget.recipes.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return RecipeCardWidget(
                        recipe: widget.recipes[index],
                        onPressed: () {
                          Navigator.pushNamed(context, RecipeDetailPage.$PATH,
                              arguments: widget.recipes[index].id);
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PageViewDotIndicator(
                      currentIndex: currentIndex,
                      dotCount: 3,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
