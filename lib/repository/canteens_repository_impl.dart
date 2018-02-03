import 'dart:async';
import 'canteens_repository.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/api/mensa_api.dart';

class CanteensRepositoryImpl extends CanteensRepository {

  MensaApi api;

  CanteensRepositoryImpl(this.api);

  @override
  Future<Map<int, Canteen>> findAll() {
    return api.getCanteens().then((canteens) {
      return canteens;
    });
  }
}