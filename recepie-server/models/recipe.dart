
class Recipe {
  int id;
  String name;
  int time;
  int marked;

  Recipe(this.id, this.name, this.time, this.marked);
  factory Recipe.fromJson(dynamic json) {
    return Recipe(json['age'] as int, json['name'] as String, json['time'] as int, json['marked'] as int);
  }
  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.time}, ${this.marked} }';
  }
}