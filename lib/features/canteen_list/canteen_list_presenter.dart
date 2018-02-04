import 'package:germanmealbrowser/features/canteen_list/canteen_list_view_contract.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/repository/canteens_repository.dart';
import 'package:germanmealbrowser/repository/repository_factory.dart';

class CanteenListPresenter {
  CanteenListViewContract _view;
  CanteensRepository _repository;

  CanteenListPresenter(CanteenListViewContract view) {
    _view = view;

    _repository = new RepositoryFactory()
        .getCanteensRepository();
  }

  void loadCanteens() {
    assert(_view != null);

    _repository.findAll()
    .then((canteens) {
      List<Canteen> canteenList = canteens.values.toList();
      canteenList.sort((a, b) => a.city.compareTo(b.city));

      _view.onLoadCanteensComplete(canteenList);
    })
    .catchError((error) => _view.onLoadCanteensError());
  }
}