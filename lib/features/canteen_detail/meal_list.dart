import 'package:flutter/material.dart';
import 'package:germanmealbrowser/features/canteen_detail/canteen_detail_presenter.dart';
import 'package:germanmealbrowser/features/canteen_detail/canteen_detail_view_contract.dart';
import 'package:germanmealbrowser/features/canteen_detail/meal_item.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';

class MealList extends StatelessWidget {

  MealList({this.meals});

  final List<Meal> meals;

  List<Widget> _mealListItems(BuildContext context) {
    final List<Widget> listItems = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    final TextStyle headerStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    String mealCategory;

    for(Meal meal in meals) {

      if(mealCategory != meal.category) {
        if(mealCategory != null) {
          listItems.add(const Divider());
        }

        listItems.add(
            new MergeSemantics(
              child: new Container(
                height: 48.0,
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                alignment: AlignmentDirectional.centerStart,
                child: new SafeArea(
                  top: false,
                  bottom: false,
                  child: new Text(meal.category, style: headerStyle),
                ),
              ),
            )
        );

        mealCategory = meal.category;
      }
      listItems.add(new MealItem(meal: meal,));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.custom(childrenDelegate: new SliverChildListDelegate(_mealListItems(context)));
  }
}
