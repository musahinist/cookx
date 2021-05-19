import 'dart:convert';

class Ingredients {
  String name;
  String image;
  Measures measures;
  Ingredients({
    required this.name,
    required this.image,
    required this.measures,
  });

  Ingredients copyWith({
    String? name,
    String? image,
    Measures? measures,
  }) {
    return Ingredients(
      name: name ?? this.name,
      image: image ?? this.image,
      measures: measures ?? this.measures,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'measures': measures.toMap(),
    };
  }

  factory Ingredients.fromMap(Map<String, dynamic> map) {
    return Ingredients(
      name: map['name'],
      image: map['image'],
      measures: Measures.fromMap(map['measures']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredients.fromJson(String source) =>
      Ingredients.fromMap(json.decode(source));

  @override
  String toString() =>
      'Ingredients(name: $name, image: $image, measures: $measures)';
}

class Measures {
  Metric metric;
  Measures({
    required this.metric,
  });

  Measures copyWith({
    Metric? metric,
  }) {
    return Measures(
      metric: metric ?? this.metric,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metric': metric.toMap(),
    };
  }

  factory Measures.fromMap(Map<String, dynamic> map) {
    return Measures(
      metric: Metric.fromMap(map['metric']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Measures.fromJson(String source) =>
      Measures.fromMap(json.decode(source));

  @override
  String toString() => 'Measures(metric: $metric)';
}

class Metric {
  double amount;
  String unitLong;
  String unitShort;
  Metric({
    required this.amount,
    required this.unitLong,
    required this.unitShort,
  });

  Metric copyWith({
    double? amount,
    String? unitLong,
    String? unitShort,
  }) {
    return Metric(
      amount: amount ?? this.amount,
      unitLong: unitLong ?? this.unitLong,
      unitShort: unitShort ?? this.unitShort,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'unitLong': unitLong,
      'unitShort': unitShort,
    };
  }

  factory Metric.fromMap(Map<String, dynamic> map) {
    return Metric(
      amount: map['amount'],
      unitLong: map['unitLong'],
      unitShort: map['unitShort'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Metric.fromJson(String source) => Metric.fromMap(json.decode(source));

  @override
  String toString() =>
      'Metric(amount: $amount, unitLong: $unitLong, unitShort: $unitShort)';
}
