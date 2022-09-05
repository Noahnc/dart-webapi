import 'dart:convert';
import 'dart:developer';
import 'package:recepie_client/model/recipe.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static ApiService instance = ApiService('http://10.0.2.2:8080');
  
  final String _url;

  ApiService(this._url);

  Future addRecipe(Recipe recipe) async {
    var response = await http.post(Uri.parse("$_url/recipe"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(recipe.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Could not create recipe");
    }
  }

  Future deleteRecipeById(int id) async {
    var response = await http.delete(Uri.parse("$_url/recipe/$id"));
    if (response.statusCode != 200) {
      throw Exception("Could not create recipe");
    }
  }

  Future<List<Recipe>> getAllRecipes() async {
    log('getAllRecipes');

    List<Recipe> recipes = [];

    try {
      var response = await http.get(Uri.parse("$_url/recipe"));
      if (response.statusCode != 200) {
        log('error');
        throw Exception("Could not load recipes");
      }

      log('success');
      List<dynamic> parsedJson = jsonDecode(response.body);

      for (var j in parsedJson) {
        log('add recipe');
        recipes.add(Recipe.fromJson(j));
      }
    } on Exception catch (e) {
      print(e); // Only catches an exception of type `Exception`.
    } catch (e) {
      print(e); // Catches all types of `Exception` and `Error`.
    }

    log('Total ${recipes.length} recipes loaded');
    return recipes;
  }

  Future<Recipe> getById(int id) async {
    var response = await http.get(Uri.parse("$_url/recipe/$id"));
    if (response.statusCode != 200) {
      throw Exception("Could not load recipe with id $id");
    }

    var recipe = Recipe.fromJson(jsonDecode(response.body));
    log('Recipe with id $id loaded');
    return recipe;
  }
}
