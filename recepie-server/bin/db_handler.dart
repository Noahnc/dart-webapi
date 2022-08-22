import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;

import '../models/recipe.dart';

class DBHandler {
  static DBHandler? _instance;

  static DBHandler getInstance() {
    if (_instance == null) {
      _instance = DBHandler('../data/recipes.db');
      _instance!._open();
    }

    return _instance!;
  }

  final String _dbRelativeFilePath;
  late Database _db;

  DBHandler(this._dbRelativeFilePath);

  void _open() {
    var path = p.join(
        File(Platform.script.toString()).parent.path, _dbRelativeFilePath);
    path = p.normalize(path);

    _db = sqlite3.open(path, mode: OpenMode.readWrite, mutex: false);
  }

  List<Recipe> getAll() {
    List<Recipe> recipes = [];

    var rs = _db.select('SELECT * from recipes');
    for (final Row row in rs) {
      recipes.add(Recipe(row['id'], row['name'], row['time'], row['marked']));
    }

    return recipes;
  }

  Recipe getById(int id) {
    try {
      var rs = _db.select('SELECT * from recipes where id = ?', [id]).first;
      return Recipe(rs['id'], rs['name'], rs['time'], rs['marked']);
    } catch (ex) {
      print(ex);
      throw Exception('Recipe with id $id not found');
    }
  }

  deleteById(int id) {
    var stmt = _db.prepare('DELETE from recipes where id = ?');

    try {
      stmt.execute([id]);
    } catch (ex) {
      print(ex);
      throw Exception('Could not delete recipe with id $id');
    } finally {
      stmt.dispose();
    }
  }

  create(Recipe recipe) {
    var stmt = _db
        .prepare('INSERT INTO recipes (name, time, marked) VALUES (?, ?, ?)');

    try {
      stmt.execute([recipe.name, recipe.time, recipe.marked]);
      print('Recipe added to database');
    } catch (ex) {
      print(ex.toString());
      rethrow;
    } finally {
      stmt.dispose();
    }
  }
}
