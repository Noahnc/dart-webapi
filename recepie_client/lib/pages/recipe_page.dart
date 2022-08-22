import 'package:flutter/material.dart';
import 'package:recepie_client/model/recipe.dart';
import 'package:recepie_client/services/api_service.dart';
import 'package:recepie_client/pages/recipe_detail.dart';

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
      body: FutureBuilder<List<Recipe>>(
          initialData: const [],
          future: ApiService.instance.getAllRecipes(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Text("Loading");

            return ListView.builder(
                padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                itemCount: snapshot.data?.length,
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
                          child: Text(snapshot.data![index].name),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeDetailPage(
                                            name: snapshot.data![index].name,
                                            components: snapshot
                                                .data![index].ingredients
                                                .split(","),
                                          )),
                                );
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
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
