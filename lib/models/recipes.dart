class Recipes {
  final String name;
  final String imagePath;
  final String ingredients;

  Recipes({this.name, this.imagePath, this.ingredients});

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return new Recipes(
      name: json['strName'] as String,
      imagePath: json['strImage'] as String,
      ingredients: json['strIngredients'] as String,
    );
  }
}
