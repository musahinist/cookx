import 'dart:convert';

class Recipe {
  int id;
  String title;
  String image;
  String summary;
  String instructions;
  int readyInMinutes;
  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.instructions,
    required this.readyInMinutes,
  });

  Recipe copyWith({
    int? id,
    String? title,
    String? image,
    String? summary,
    String? instructions,
    int? readyInMinutes,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      summary: summary ?? this.summary,
      instructions: instructions ?? this.instructions,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'summary': summary,
      'instructions': instructions,
      'readyInMinutes': readyInMinutes,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      summary: map['summary'],
      instructions: map['instructions'],
      readyInMinutes: map['readyInMinutes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, image: $image, summary: $summary, instructions: $instructions, readyInMinutes: $readyInMinutes)';
  }
}
