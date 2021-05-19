import 'package:mobx/mobx.dart';

import '../../data/model/fiiltered_recipe.dart';
import '../../data/model/recipe.dart';
import '../../data/model/recipe_details.dart';
import '../../data/repository/recipe_repo.dart';
import '../../util/http/http_exception.dart';

part 'recipe_store.g.dart';

class RecipeStore = _RecipeStoreBase with _$RecipeStore;
enum StoreState { initial, loading, loaded }

abstract class _RecipeStoreBase with Store {
  final RecipeRepo _recipeRepo = RecipeRepo();

  @observable
  ObservableFuture<List<Recipe>>? recipesFuture;
  @observable
  List<Recipe>? recipes;

  @observable
  RecipeDetail? recipeDetail;

  @observable
  List<FilteredRecipe>? filteredRecipe;

  @observable
  StoreState state = StoreState.initial;

  @observable
  String? errorMessage;

  @action
  Future getRecipes() async {
    try {
      errorMessage = null;
      state = StoreState.loading;
      recipesFuture = ObservableFuture(_recipeRepo.getRecipes());
      recipes = await recipesFuture;
      state = StoreState.loaded;
    } catch (e) {
      errorMessage = HttpException.handleError(e);
    }
  }

  @action
  Future getRecipeDetail(int id) async {
    try {
      errorMessage = null;
      state = StoreState.loading;
      recipeDetail = await _recipeRepo.getRecipeDetail(id: id);

      state = StoreState.loaded;
    } catch (e) {
      errorMessage = HttpException.handleError(e);
    }
  }

  @action
  Future getFilterdRecipe(String filter) async {
    try {
      errorMessage = null;
      state = StoreState.loading;
      filteredRecipe = await _recipeRepo.getFilteredRecipe(filter: filter);
      state = StoreState.loaded;
    } catch (e) {
      errorMessage = HttpException.handleError(e);
    }
  }
}
