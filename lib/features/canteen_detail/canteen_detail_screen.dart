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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.widget.canteen.name),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) => new MealItem(meal:_meals[index]),
        itemCount: _meals.length,
      ),
    );
  }
}
