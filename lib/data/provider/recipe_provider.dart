import 'package:dio/dio.dart';

import '../../config/constant/app_config.dart';
import '../../config/core/abstract_provider.dart';

class RecipeProvider extends AbstractProvider {
  RecipeProvider({
    this.path = 'recipes',
    this.tag = 'recipes',
  }) : super(path, tag);
  final String path;
  final String tag;

  Future<Response> getRandomRecipe() async {
    try {
      final Response response = await get(
          innerPath: 'random',
          queryParameters: {'apiKey': AppConfig.apiKey, "number": 10});
      print(response.data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRecipeDetail(int id) async {
    try {
      final Response response = await get(
          innerPath: '$id/information',
          queryParameters: {'apiKey': AppConfig.apiKey});
      print(response.data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getFilteredRecipe(String filter) async {
    try {
      final Response response = await get(
          innerPath: 'complexSearch',
          queryParameters: {
            'apiKey': AppConfig.apiKey,
            'query': filter,
            'number': 10
          });
      print(response.data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
