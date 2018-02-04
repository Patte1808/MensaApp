import 'package:flutter/material.dart';
import 'package:germanmealbrowser/features/canteen_detail/meal_item.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';

class CanteenDetailScreen extends StatefulWidget {
  const CanteenDetailScreen({this.canteen});

  final Canteen canteen;

  @override
  _CanteenDetailScreenState createState() => new _CanteenDetailScreenState();
}

class _CanteenDetailScreenState extends State<CanteenDetailScreen> {
  List<Meal> _meals = [];

  @override
  void initState() {
    super.initState();

    new RepositoryFactory()
        .getMealsRepository()
        .findAllForCanteenByDate(this.widget.canteen.id, new DateTime.now())
        .then((canteens) => setMeals(canteens.values.toList()), onError: (e) {
      setMeals(new List(0));
    });
  }

  void setMeals(List<Meal> meals) {
    setState(() {
      _meals = meals;

      debugPrint(_meals.toString());
    });
  }

  List<Widget> _mealListItems() {
    final List<Widget> listItems = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    final TextStyle headerStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    String mealCategory;

    for(Meal meal in _meals) {

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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.widget.canteen.name),
      ),
      body: new ListView.custom(childrenDelegate: new SliverChildListDelegate(_mealListItems())),
    );
  }
}
