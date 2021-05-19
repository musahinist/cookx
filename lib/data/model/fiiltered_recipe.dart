import 'dart:convert';

class FilteredRecipe {
  int id;
  String image;
  String title;
  FilteredRecipe({
    required this.id,
    required this.image,
    required this.title,
  });

  FilteredRecipe copyWith({
    int? id,
    String? image,
    String? title,
  }) {
    return FilteredRecipe(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
    };
  }

  factory FilteredRecipe.fromMap(Map<String, dynamic> map) {
    return FilteredRecipe(
      id: map['id'],
      image: map['image'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FilteredRecipe.fromJson(String source) =>
      FilteredRecipe.fromMap(json.decode(source));

  @override
  String toString() => 'FilteredRecipe(id: $id, image: $image, title: $title)';
}
