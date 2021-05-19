import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../data/model/recipe.dart';
import '../../store/recipe/recipe_store.dart';
import '../widget/recipe_card_widget.dart';
import '../widget/slider_widget.dart';
import 'recipe_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RecipeStore _recipeStore;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _recipeStore = Provider.of<RecipeStore>(context)..getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            if (_recipeStore.state == StoreState.loaded) {
              return CustomScrollView(
                slivers: [
                  SliderWidget(
                    recipes: _recipeStore.recipes!.take(3).toList(),
                  ),
                  const SliverTitle(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final Recipe recipe =
                          (_recipeStore.recipes!.skip(3).toList())[index];
                      return RecipeCardWidget(
                        recipe: recipe,
                        onPressed: () {
                          Navigator.pushNamed(context, RecipeDetailPage.$PATH,
                              arguments: _recipeStore.recipes![index].id);
                        },
                        notchColor: Colors.amber,
                      );
                    }, childCount: _recipeStore.recipes!.length - 3),
                  )
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class SliverTitle extends StatelessWidget {
  const SliverTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      expandedHeight: 56.0, pinned: true,
      backgroundColor: Colors.white,
      //  elevation: 0,
      floating: true, titleSpacing: 0,
      title: ListTile(
        dense: true,
        title: Text(
          'Populer Recipes',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
