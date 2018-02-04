import 'package:germanmealbrowser/models/canteen.dart';

abstract class CanteenListViewContract {
  void onLoadCanteensComplete(List<Canteen> canteens);

  void onLoadCanteensError();
}