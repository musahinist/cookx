import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../data/model/fiiltered_recipe.dart';
import '../../store/recipe/recipe_store.dart';
import '../widget/keyboard_hider_widget.dart';
import '../widget/search_appbar_widget.dart';
import 'recipe_detail.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late RecipeStore _recipeStore;
  TextEditingController searchController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recipeStore = Provider.of<RecipeStore>(context)
      ..getFilterdRecipe('Hamburger');
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardHider(
      child: Scaffold(
        appBar: SearchAppBar(
          controller: searchController,
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Provider.of<RecipeStore>(context, listen: false)
                .getFilterdRecipe(searchController.text);
          },
        ),
        body: Observer(
          builder: (context) {
            if (_recipeStore.state == StoreState.loaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: _recipeStore.filteredRecipe!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final FilteredRecipe filteredRecipe =
                        _recipeStore.filteredRecipe![index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RecipeDetailPage.$PATH,
                            arguments: filteredRecipe.id);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(filteredRecipe.image),
                                fit: BoxFit.cover),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(15))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    filteredRecipe.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
