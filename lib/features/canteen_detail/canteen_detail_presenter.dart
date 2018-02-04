import 'package:germanmealbrowser/features/canteen_detail/canteen_detail_view_contract.dart';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/repository/meals_repository.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';

class CanteenDetailPresenter {
  CanteenDetailViewContract _view;
  MealsRepository _repository;

  CanteenDetailPresenter(CanteenDetailViewContract view) {
    _view = view;

    _repository =  new RepositoryFactory()
        .getMealsRepository();
  }

  void loadMeals(canteenId, date) {
    assert(_view != null);

    _repository.findAllForCanteenByDate(canteenId, date)
    .then((meals) {
      List<Meal> mealList = meals.values.toList();
      mealList.sort((a, b) => a.category.compareTo(b.category));

      _view.onLoadMealsComplete(mealList);
    }).catchError((onError) {
      _view.onLoadMealsError();
    });
  }
}