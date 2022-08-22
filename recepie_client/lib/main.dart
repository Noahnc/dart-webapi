import 'package:flutter/material.dart';
import 'package:recepie_client/pages/recipe_page.dart';


void main() {
  runApp(const MyApp());
}

const String message = "dasd";


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipePage(title: 'Meine Rezepte'),
    );
  }
}