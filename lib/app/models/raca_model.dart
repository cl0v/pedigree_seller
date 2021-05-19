import 'dart:convert';


class Raca {
  String? category;
  String? especie;
  Raca({
    this.category,
    this.especie,
  });

  @override
  String toString() => 'Raca(category: $category, especie: $especie)';

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'especie': especie,
    };
  }

  factory Raca.fromMap(Map<String, dynamic> map) {
    return Raca(
      category: map['category'],
      especie: map['especie'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Raca.fromJson(String source) => Raca.fromMap(json.decode(source));
}
