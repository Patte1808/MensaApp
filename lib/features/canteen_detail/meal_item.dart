import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/utils/string_utils.dart';

class MealItem extends StatelessWidget {

  const MealItem({Meal meal, Key key}) : meal = meal,
        super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {

    final String studentPrice = StringUtils.formatNumberToEuros(meal.prices['students']);
    final String employeePrice = StringUtils.formatNumberToEuros(meal.prices['employees']);
    final String otherPrice = StringUtils.formatNumberToEuros(meal.prices['others']);

    return new ListTile(
      title: new Text(meal.name),
      subtitle: new Container(
        child: new Row(
          children: <Widget>[
            new Text("Price: ${studentPrice} / ${employeePrice} / ${otherPrice}"),
          ],
        ),
      ),
    );
  }
}
