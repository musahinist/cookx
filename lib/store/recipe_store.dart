import 'package:mobx/mobx.dart';

import '../data/model/recipe.dart';
import '../data/repository/recipe_repo.dart';
import '../util/http/http_exception.dart';

part 'recipe_store.g.dart';

class RecipeStore = _RecipeStoreBase with _$RecipeStore;
enum StoreState { initial, loading, loaded, error }

abstract class _RecipeStoreBase with Store {
  final RecipeRepo _recipeRepo = RecipeRepo();
  @observable
  ObservableFuture<List<Recipe>>? recipesFuture;
  @observable
  List<Recipe>? recipes;
  @observable
  StoreState state = StoreState.initial;
  @observable
  String? errorMessage;
  // @computed
  // StoreState get state {
  //   // If the user has not yet searched for a weather forecast or there has been an error
  //   if (recipesFuture == null ||
  //       recipesFuture?.status == FutureStatus.rejected) {
  //     return StoreState.initial;
  //   }

  //   return recipesFuture.status == FutureStatus.pending
  //       ? StoreState.loading
  //       : StoreState.loaded;
  // }

  @action
  Future getRecipes() async {
    try {
      state = StoreState.loading;
      recipesFuture = ObservableFuture(_recipeRepo.getRecipes());
      recipes = await recipesFuture;
      state = StoreState.loaded;
    } catch (e) {
      errorMessage = HttpException.handleError(e);
      state = StoreState.error;
    }
  }
}
