import 'dart:async';

import 'package:germanmealbrowser/features/canteen_list/canteen_list_view_contract.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/repository/canteens_repository.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';
import 'package:germanmealbrowser/utils/shared_preferences_utils.dart';

/*
TODO: dependency injection is not strong in this one
 */
class CanteenListPresenter {
  CanteenListViewContract _view;
  CanteensRepository _repository;
  SharedPreferencesUtils _sharedPreferencesUtils;

  CanteenListPresenter(CanteenListViewContract view) {
    _view = view;

    _repository = new RepositoryFactory()
        .getCanteensRepository();

    _sharedPreferencesUtils = new SharedPreferencesUtils();
  }

  void loadCanteens() {
    assert(_view != null);

    /*_sharedPreferencesUtils
        .getAllCanteenFavorites().then((favorites) {
      _repository.findAll()
          .then((canteens) {
        List<Canteen> canteenList = canteens.values.toList();
        canteenList.sort((a, b) => a.city.compareTo(b.city));

        for(Canteen canteen in canteenList) {
          if(favorites.containsKey(canteen.id))
            canteen.isFavorite = true;
        }

        _view.onLoadCanteensComplete(canteenList);
      })
          .catchError((error) => _view.onLoadCanteensError());
    });*/
  }

  void setCanteenFavorite(int canteenId) {
    _sharedPreferencesUtils.setCanteenFavorite(canteenId);
  }
}