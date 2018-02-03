import 'package:flutter/material.dart';
import 'package:germanmealbrowser/features/canteen_list/canteen_item.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';

class CanteenListScreen extends StatefulWidget {
  @override
  _CanteenListScreenState createState() => new _CanteenListScreenState();
}

class _CanteenListScreenState extends State<CanteenListScreen> {
  List<Canteen> _canteens = [];

  @override
  void initState() {
    super.initState();

    new RepositoryFactory()
        .getCanteensRepository()
        .findAll()
        .then((canteens) => setCanteens(canteens.values.toList()));
  }

  void setCanteens(List<Canteen> canteens) {
    setState(() {
      _canteens = canteens;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        new ListView.builder(
          itemBuilder: (BuildContext context, int index) => new CanteenItem(canteen: _canteens[index]),
          itemCount: _canteens.length,
    );
  }
}
