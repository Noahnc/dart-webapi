
class Recipe {
  int id;
  String name;
  String? ingredients;

  Recipe(this.id, this.name, this.ingredients);

  factory Recipe.fromJson(dynamic json) {
    return Recipe(json['id'] as int, json['name'] as String, json['ingredients'] as String?);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name} }';
  }

  Map toJson() => {
    'id': id,
    'name': name,
    'ingredients': ingredients
  };
}