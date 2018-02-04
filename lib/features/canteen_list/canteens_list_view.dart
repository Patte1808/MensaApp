import 'package:flutter/material.dart';
import 'package:germanmealbrowser/features/canteen_list/canteen_item.dart';
import 'package:germanmealbrowser/features/canteen_list/canteen_list_presenter.dart';
import 'package:germanmealbrowser/features/canteen_list/canteen_list_view_contract.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/models/meal.dart';

class CanteenListView extends StatefulWidget {
  @override
  _CanteenListViewState createState() => new _CanteenListViewState();
}

class _CanteenListViewState extends State<CanteenListView>
    implements CanteenListViewContract {
  CanteenListPresenter _presenter;
  List<Canteen> _canteens;
  bool _isLoading;

  _CanteenListViewState() {
    _presenter = new CanteenListPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _presenter.loadCanteens();
  }

  @override
  void onLoadCanteensComplete(List<Canteen> canteens) {
    setState(() {
      _canteens = canteens;
      _isLoading = false;
    });
  }

  @override
  void onLoadCanteensError() {
    // TODO: implement Error handling
  }

  @override
  void onSetCanteenFavorite(int canteenId) {
    _presenter.setCanteenFavorite(canteenId);
  }

  List<Widget> _canteenListItems() {
    final List<Widget> listItems = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    final TextStyle headerStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    String city;

    for(Canteen canteen in _canteens) {

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

    Widget widget;

    if(_isLoading) {
      widget = new Center(
        child: new Padding(padding: new EdgeInsets.only(left: 16.0, right: 16.0),
        child: new CircularProgressIndicator(),),
      );
    } else {
      widget = new ListView.custom(
          childrenDelegate: new SliverChildListDelegate(_canteenListItems()));
    }

    return widget;
  }
}
