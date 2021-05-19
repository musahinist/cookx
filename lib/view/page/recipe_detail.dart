import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

import '../../store/recipe/recipe_store.dart';
import '../widget/item_counter_widget.dart';
import '../widget/sliver_appbar_widget.dart';

class RecipeDetailPage extends StatefulWidget {
  static const String $PATH = 'RecipeDetail';
  final int recipeId;

  const RecipeDetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late RecipeStore _recipeStore;
  int servings = 1;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    _recipeStore = Provider.of<RecipeStore>(context)
      ..getRecipeDetail(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (_recipeStore.state == StoreState.loaded) {
          final recipeDetail = _recipeStore.recipeDetail;
          return CustomScrollView(
            slivers: [
              SliverAppBarWidget(
                  title: recipeDetail!.title, image: recipeDetail.image),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.local_offer, color: Colors.amber),
                            Text(
                                '\$ ${recipeDetail.pricePerServing.round() / 100}')
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.timelapse, color: Colors.amber),
                            Text(recipeDetail.readyInMinutes.toString())
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.star_border, color: Colors.amber),
                            Text("${recipeDetail.spoonacularScore}")
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Ingredients",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("How many servings"),
                    trailing: ItemCounterWidget(
                      servings: servings,
                      onPressedMinus: () {
                        if (servings > 1) servings--;
                        setState(() {});
                      },
                      onPressedPlus: () {
                        servings++;
                        setState(() {});
                      },
                    ),
                  ),
                  ...List.generate(recipeDetail.extendedIngredients.length,
                      (index) {
                    final ingr = recipeDetail.extendedIngredients[index];
                    return ListTile(
                      title: Text(ingr.name),
                      dense: true,
                      trailing: Text(
                          '${ingr.measures.metric.amount * servings} ${ingr.measures.metric.unitShort}'),
                    );
                  }),
                  ListTile(
                    title: Text("Instructions",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HtmlWidget(recipeDetail.instructions),
                  ),
                ]),
              )
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
