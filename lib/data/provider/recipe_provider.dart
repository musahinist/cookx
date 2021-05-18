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
          innerPath: 'random', queryParameters: {'apiKey': AppConfig.apiKey});
      print(response.data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
