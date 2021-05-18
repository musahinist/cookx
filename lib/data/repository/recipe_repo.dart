import '../model/recipe.dart';
import '../provider/recipe_provider.dart';
import '../provider/shared_prefs.dart';

class RecipeRepo {
  RecipeProvider recipeProvider = RecipeProvider();

  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await recipeProvider.getRandomRecipe();
      print(response);
      final List<Recipe> recipes = response.data["recipes"]
          .map<Recipe>((v) => Recipe.fromMap(v))
          .toList();
      SharedPrefs().setRecipes(recipes.toString());
      print("FROM NETWORK");

      // print(recipes.toString());
      return recipes;
      // print(await SharedPrefs.needUpdate());
      // if (await SharedPrefs.needUpdate()) {
      //   final response = await recipeProvider.getRandomRecipe();
      //   print(response);
      //   final List<Recipe> recipes =
      //       response.data.map<Recipe>((v) => Recipe.fromMap(v)).toList();
      //   SharedPrefs().setRecipes(recipes.toString());
      //   print("FROM NETWORK");

      //   // print(recipes.toString());
      //   return recipes;
      // } else {
      //   final response = await SharedPrefs().getRecipes();
      //   print(response);
      //   final List<Recipe> recipes = jsonDecode(response!)
      //       .map<Recipe>((v) => Recipe.fromMap(v))
      //       .toList();
      //   // print("FROM LOCAL");
      //   print(recipes.toString());
      //   return recipes;
      // }
    } catch (e) {
      rethrow;
    }
  }
}
