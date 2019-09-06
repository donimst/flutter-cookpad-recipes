import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final String ingredients;
  DetailPage({Key key, this.itemName, this.imagePath, this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Resep $itemName'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/$imagePath'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(itemName,
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Container(
                        height: 4, color: Theme.of(context).primaryColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Container(
                      child: Text(
                        ingredients,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
