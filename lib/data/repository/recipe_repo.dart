import 'dart:convert';

import '../model/fiiltered_recipe.dart';
import '../model/recipe.dart';
import '../model/recipe_details.dart';
import '../provider/local_storage.dart';
import '../provider/recipe_provider.dart';

class RecipeRepo {
  RecipeProvider recipeProvider = RecipeProvider();

  Future<List<Recipe>> getRecipes() async {
    try {
      if (await Storage().needUpdate()) {
        final response = await recipeProvider.getRandomRecipe();

        final List<Recipe> recipes = response.data['recipes']
            .map<Recipe>((v) => Recipe.fromMap(v))
            .toList();
        Storage().setRecipes(json.encode(response.data));
        print('FROM NETWORK');

        // print(recipes.toString());
        return recipes;
      } else {
        final response = await Storage().getRecipes();

        final List<Recipe> recipes = jsonDecode(response!)['recipes']
            .map<Recipe>((v) => Recipe.fromMap(v))
            .toList();
        print('FROM LOCAL');

        return recipes;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RecipeDetail> getRecipeDetail({required int id}) async {
    try {
      final response = await recipeProvider.getRecipeDetail(id);

      final RecipeDetail recipeDettail = RecipeDetail.fromMap(response.data);

      return recipeDettail;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FilteredRecipe>> getFilteredRecipe(
      {required String filter}) async {
    try {
      final response = await recipeProvider.getFilteredRecipe(filter);

      final List<FilteredRecipe> recipes = response.data['results']
          .map<FilteredRecipe>((v) => FilteredRecipe.fromMap(v))
          .toList();

      return recipes;
    } catch (e) {
      rethrow;
    }
  }
}
