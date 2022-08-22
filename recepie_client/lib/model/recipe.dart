
class Recipe {
  int id;
  String name;
  int time;
  int marked;
  String ingredients;

  Recipe(this.id, this.name, this.time, this.marked, this.ingredients);

  factory Recipe.fromJson(dynamic json) {
    return Recipe(json['id'] as int, json['name'] as String, json['time'] as int, json['marked'] as int, json['ingredients'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.time}, ${this.marked} }';
  }

  Map toJson() => {
    'id': id,
    'name': name,
    'time': time,
    'marked': marked,
    'ingredients': ingredients
  };
}