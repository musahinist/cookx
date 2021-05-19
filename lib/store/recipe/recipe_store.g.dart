// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecipeStore on _RecipeStoreBase, Store {
  final _$recipesFutureAtom = Atom(name: '_RecipeStoreBase.recipesFuture');

  @override
  ObservableFuture<List<Recipe>>? get recipesFuture {
    _$recipesFutureAtom.reportRead();
    return super.recipesFuture;
  }

  @override
  set recipesFuture(ObservableFuture<List<Recipe>>? value) {
    _$recipesFutureAtom.reportWrite(value, super.recipesFuture, () {
      super.recipesFuture = value;
    });
  }

  final _$recipesAtom = Atom(name: '_RecipeStoreBase.recipes');

  @override
  List<Recipe>? get recipes {
    _$recipesAtom.reportRead();
    return super.recipes;
  }

  @override
  set recipes(List<Recipe>? value) {
    _$recipesAtom.reportWrite(value, super.recipes, () {
      super.recipes = value;
    });
  }

  final _$stateAtom = Atom(name: '_RecipeStoreBase.state');

  @override
  StoreState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(StoreState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_RecipeStoreBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$getRecipesAsyncAction = AsyncAction('_RecipeStoreBase.getRecipes');

  @override
  Future<dynamic> getRecipes() {
    return _$getRecipesAsyncAction.run(() => super.getRecipes());
  }

  @override
  String toString() {
    return '''
recipesFuture: ${recipesFuture},
recipes: ${recipes},
state: ${state},
errorMessage: ${errorMessage}
    ''';
  }
}
