import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipes_app/ui/detail_page.dart';
import 'package:recipes_app/models/recipes.dart';
import 'package:recipes_app/ui/recipe_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  List data;

  List<Recipes> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Recipes>((json) => new Recipes.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Katalog Makanan Korea',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff7e57c2),
          accentColor: Color(0xffd1c4e9),
          fontFamily: 'Ubuntu'),
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Katalog Makanan Korea'),
          ),
          body: Container(
            child: Center(
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/recipes.json'),
                builder: (context, snapshot) {
                  List<Recipes> recipes = parseJson(snapshot.data.toString());
                  return recipes.isEmpty
                      ? new Center(child: CircularProgressIndicator())
                      : new RecipeList(recipes: recipes);
                },
              ),
            ),
          )),
    );
  }
}
