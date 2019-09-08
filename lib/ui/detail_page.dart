import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String itemName;
  final String imagePath;
  final String ingredients;
  DetailPage(
      {Key key, this.id, this.itemName, this.imagePath, this.ingredients})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Resep ' + widget.itemName),
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
                    child: ClipOval(
                      child: Hero(
                        child: Image.asset('assets/images/' + widget.imagePath,
                            fit: BoxFit.cover),
                        tag: 'Recipes' + widget.id.toString(),
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
                          Text(widget.itemName,
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
                        widget.ingredients,
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
