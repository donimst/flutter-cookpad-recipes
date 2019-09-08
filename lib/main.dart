import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipes.dart';
import 'package:recipes_app/ui/recipe_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Katalog Makanan Korea',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff7e57c2),
          accentColor: Color(0xffd1c4e9),
          fontFamily: 'Ubuntu'),
      home: HomePage(title: 'Katalog Makanan Korea'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipes> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Recipes>((json) => Recipes.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.orangeAccent]),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("APPS"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("MOVIES"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/breakfast.json'),
                builder: (context, snapshot) {
                  List<Recipes> breakfast = parseJson(snapshot.data.toString());
                  return breakfast.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : RecipeList(recipes: breakfast);
                },
              ),
              FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/dessert.json'),
                builder: (context, snapshot) {
                  List<Recipes> dessert = parseJson(snapshot.data.toString());
                  return dessert.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : RecipeList(recipes: dessert);
                },
              ),
            ],
          ),
        ));
  }
}
