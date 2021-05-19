import 'dart:convert';

import 'ingredients.dart';

class RecipeDetail {
  String title;
  String image;
  String instructions;
  int readyInMinutes;
  double pricePerServing;
  double spoonacularScore;
  List<Ingredients> extendedIngredients;
  RecipeDetail({
    required this.title,
    required this.image,
    required this.instructions,
    required this.readyInMinutes,
    required this.pricePerServing,
    required this.spoonacularScore,
    required this.extendedIngredients,
  });

  RecipeDetail copyWith({
    String? title,
    String? image,
    String? instructions,
    int? readyInMinutes,
    double? pricePerServing,
    double? spoonacularScore,
    List<Ingredients>? extendedIngredients,
  }) {
    return RecipeDetail(
      title: title ?? this.title,
      image: image ?? this.image,
      instructions: instructions ?? this.instructions,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      pricePerServing: pricePerServing ?? this.pricePerServing,
      spoonacularScore: spoonacularScore ?? this.spoonacularScore,
      extendedIngredients: extendedIngredients ?? this.extendedIngredients,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'instructions': instructions,
      'readyInMinutes': readyInMinutes,
      'pricePerServing': pricePerServing,
      'spoonacularScore': spoonacularScore,
      'extendedIngredients': extendedIngredients.map((x) => x.toMap()).toList(),
    };
  }

  factory RecipeDetail.fromMap(Map<String, dynamic> map) {
    return RecipeDetail(
      title: map['title'],
      image: map['image'],
      instructions: map['instructions'],
      readyInMinutes: map['readyInMinutes'],
      pricePerServing: map['pricePerServing'],
      spoonacularScore: map['spoonacularScore'],
      extendedIngredients: List<Ingredients>.from(
          map['extendedIngredients']?.map((x) => Ingredients.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeDetail.fromJson(String source) =>
      RecipeDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RecipeDetail(title: $title, image: $image, instructions: $instructions, readyInMinutes: $readyInMinutes, pricePerServing: $pricePerServing, spoonacularScore: $spoonacularScore, extendedIngredients: $extendedIngredients)';
  }
}
