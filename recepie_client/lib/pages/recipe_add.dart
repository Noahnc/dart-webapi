import 'package:flutter/material.dart';
import 'package:recepie_client/model/recipe.dart';
import 'package:recepie_client/services/api_service.dart';

class RecipeAddPage extends StatefulWidget {
  const RecipeAddPage({Key? key}) : super(key: key);

  @override
  State<RecipeAddPage> createState() => _RecipeAddPageState();
}

class _RecipeAddPageState extends State<RecipeAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String text1 = "";
  String text2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Rezept hinzufügen"),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Rezeptname',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte geben Sie einen Rezeptnamen ein';
                        } {
                          text1 = value;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Zutaten (getrennt mit ",")',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte geben Sie mindestens eine Zutat ein';
                        }{
                          text2 = value;
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          var recipe = Recipe(12, text1, text2);
                          ApiService.instance.addRecipe(recipe);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ))),
      ),
    );
  }
}
