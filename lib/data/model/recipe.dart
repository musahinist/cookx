import 'dart:convert';

class Recipe {
  String title;
  Recipe({
    required this.title,
  });

  Recipe copyWith({
    String? title,
  }) {
    return Recipe(
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));

  @override
  String toString() => 'Recipe(title: $title)';
}
