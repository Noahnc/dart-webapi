import 'package:flutter/material.dart';
import 'package:recepie_client/model/recipe.dart';
import 'package:recepie_client/pages/recipe_add.dart';
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

  Future<List<Recipe>> future = ApiService.instance.getAllRecipes();

  void _incrementCounter() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const RecipeAddPage()),
    ).then((value) => setState(() {}));
  }

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(onPressed: updateState, icon: const Icon(Icons.refresh)),
      ),
      body: FutureBuilder<List<Recipe>>(
          initialData: const [],
          future: ApiService.instance.getAllRecipes(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading");
            }
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              color: Colors.purple,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: ListView.builder(
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
                                                  .data![index].ingredients,
                                            )),
                                  );
                                },
                                child: const Text('Rezept öffnen'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  ApiService.instance.deleteRecipeById(
                                      snapshot.data![index].id);
                                  setState(() {});
                                },
                                child: const Text('Rezept löschen'),
                              ),
                            ],
                          )
                        ],
                      )),
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
