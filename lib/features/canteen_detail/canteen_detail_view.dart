import 'package:flutter/material.dart';
import 'package:germanmealbrowser/features/canteen_detail/canteen_detail_presenter.dart';
import 'package:germanmealbrowser/features/canteen_detail/canteen_detail_view_contract.dart';
import 'package:germanmealbrowser/features/canteen_detail/meal_item.dart';
import 'package:germanmealbrowser/features/canteen_detail/meal_list.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';
import 'package:germanmealbrowser/utils/string_utils.dart';

class CanteenDetailView extends StatefulWidget {
  const CanteenDetailView({this.canteen});

  final Canteen canteen;

  @override
  _CanteenDetailViewState createState() => new _CanteenDetailViewState();
}

class _CanteenDetailViewState extends State<CanteenDetailView>
    with WidgetsBindingObserver
    implements CanteenDetailViewContract  {
  CanteenDetailPresenter _presenter;
  List<Meal> _meals;
  bool _isLoading;
  bool _isError;
  PageController _controller;
  int _currentIndex = 0;

  _CanteenDetailViewState() {
    _presenter = new CanteenDetailPresenter(this);
  }



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _isLoading = true;
    _isError = false;
    _presenter.loadMeals(widget.canteen.id, _currentIndex);
    _controller = new PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  void _handlePageChanged(int page) {
    setState(() {
      _currentIndex = page;
      _presenter.loadMeals(widget.canteen.id, page);
      _isLoading = true;
    });
  }

  @override
  void onLoadMealsComplete(List<Meal> meals) {
    setState(() {
      _meals = meals;
      _isLoading = false;
      _isError = false;
    });
  }

  @override
  void onLoadMealsError() {
    setState(() {
      _isLoading = false;
      _isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    String forDate = StringUtils
        .formatDateBeautiful(StringUtils.formatIndexToDate(_currentIndex));

    if (_isLoading) {
      widget = new Center(
        child: new Padding(
          padding: new EdgeInsets.only(left: 16.0, right: 16.0),
          child: new CircularProgressIndicator(),
        ),
      );
    } else if (_isError) {
      widget = new Center(
        child: new Text("There are no meals for this canteen yet."),
      );
    } else {
      widget = new MealList(
        meals: _meals,
      );
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("${this.widget.canteen.name}"),
        ),
        body: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: new Text(
                "${forDate}",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            new Expanded(
                child: new PageView.builder(
              controller: _controller,
              onPageChanged: _handlePageChanged,
              itemBuilder: (BuildContext context, int index) {
                return widget;
              },
            ))
          ],
        ));
  }
}
