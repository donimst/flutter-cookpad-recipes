import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipes.dart';
import 'package:recipes_app/ui/recipe_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Katalog Masakan Korea',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff7e57c2),
          accentColor: Color(0xffd1c4e9),
          fontFamily: 'Ubuntu'),
      home: HomePage(title: 'Katalog Masakan Korea'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Recipes> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Recipes>((json) => Recipes.fromJson(json)).toList();
  }

  TabController tabController;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white24, Theme.of(context).primaryColor]),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0)),
                color: Colors.white),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Breakfast"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Dessert"),
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Container(
            padding: EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/breakfast.json'),
              builder: (context, snapshot) {
                List<Recipes> breakfast =
                    snapshot.hasData ? parseJson(snapshot.data.toString()) : [];
                return breakfast.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : RecipeList(recipes: breakfast);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/dessert.json'),
              builder: (context, snapshot) {
                List<Recipes> dessert =
                    snapshot.hasData ? parseJson(snapshot.data.toString()) : [];
                return dessert.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : RecipeList(recipes: dessert);
              },
            ),
          ),
        ],
      ),
    );
  }
}
