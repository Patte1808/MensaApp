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
        .then((canteens) {
      List<Canteen> canteenList = canteens.values.toList();
      canteenList.sort((a, b) => a.city.compareTo(b.city));
      setCanteens(canteenList);
    });
  }

  void setCanteens(List<Canteen> canteens) {
    setState(() {
      _canteens = canteens;
    });
  }

  List<Widget> _canteenListItems() {
    final List<Widget> listItems = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    final TextStyle headerStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    String city;
    debugPrint("Trying to build list");
    debugPrint("Canteens Length: ${_canteens.length}");
    for(Canteen canteen in _canteens) {

      debugPrint("iterating ${canteen.name}");
      if(city != canteen.city) {
        if(city != null) {
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
                  child: new Text(canteen.city, style: headerStyle),
                ),
              ),
            )
        );

        city = canteen.city;
      }
      listItems.add(new CanteenItem(canteen: canteen,));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.custom(childrenDelegate: new SliverChildListDelegate(_canteenListItems()));
  }
}
