import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipes.dart';
import 'package:recipes_app/ui/detail_page.dart';

class RecipeList extends StatelessWidget {
  final List<Recipes> recipes;
  RecipeList({Key key, this.recipes}) : super(key: key);

  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: recipes == null ? 0 : recipes.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0)),
            ),
            borderOnForeground: true,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                  ),
                  child: Image.asset(
                      'assets/images/${recipes[index].imagePath}',
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      recipes[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                    itemName: recipes[index].name,
                    imagePath: recipes[index].imagePath,
                    ingredients: recipes[index].ingredients),
              ),
            );
          },
        );
      },
    );
  }
}
