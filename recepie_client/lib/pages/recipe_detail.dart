import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage(
      {Key? key, required this.name, required this.components})
      : super(key: key);

  final String name;
  final List components;

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            itemCount: widget.components.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                height: 50,
                color: Colors.black12,
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(widget.components[index])])),
              );
            }),
      ),
    );
  }
}
