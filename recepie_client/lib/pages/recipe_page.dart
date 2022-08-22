import 'package:flutter/material.dart';
import 'package:recepie_client/model/recipe.dart';

final recipe1 = Recipe(1, "rezept1", 1, 1);
final recipe2 = Recipe(2, "rezept2", 2, 2);
final recipe3 = Recipe(3, "rezept3", 3, 3);

final array = [recipe1, recipe2, recipe3];

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            itemCount: array.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                height: 50,
                color: Colors.black12,
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(array[index].name),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // TODO: open RecipeDetail
                              },
                              child: const Text('Rezept öffnen'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: delete Recipe
                              },
                              child: const Text('Rezept löschen'),
                            ),
                          ],
                        )
                      ],
                    )),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
