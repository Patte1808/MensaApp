import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:germanmealbrowser/features/canteen_detail/canteen_detail_screen.dart';
import 'package:germanmealbrowser/models/meal.dart';

class MealItem extends StatelessWidget {

  const MealItem({Meal meal, Key key}) : meal = meal,
        super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(meal.name),
      subtitle: new Container(
        child: new Row(
          children: <Widget>[
            new Text("Price: ${meal.prices[0]}"),
            new Text("Category: ${meal.category}"),
          ],
        ),
      ),
    );
  }
}
