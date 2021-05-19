import 'package:flutter/material.dart';

import '../../data/model/recipe.dart';

class RecipeCardWidget extends StatelessWidget {
  const RecipeCardWidget({
    Key? key,
    required this.onPressed,
    required this.recipe,
    this.notchColor = Colors.white,
  }) : super(key: key);
  final Recipe recipe;
  final VoidCallback onPressed;
  final Color notchColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(32),
                image: DecorationImage(
                    image: NetworkImage(recipe.image), fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 136,
                  height: 64,
                  decoration: BoxDecoration(
                    color: notchColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${recipe.readyInMinutes} min.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              recipe.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
