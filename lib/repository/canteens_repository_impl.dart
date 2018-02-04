import 'dart:async';
import 'canteens_repository.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'package:germanmealbrowser/api/mensa_api.dart';

class CanteensRepositoryImpl extends CanteensRepository {

  MensaApi api;
  Map<int, Canteen> _cache = new Map();
  bool _isDirty = true;

  CanteensRepositoryImpl(this.api);

  @override
  Future<Map<int, Canteen>> findAll() async {
    if(!_isDirty && _cache.isNotEmpty) {
      print('getting from cache');
      return new Future.value(_cache);
    }

    Map<int, Canteen> result = new Map();

    await api.getCanteens().then((canteens) {
      _isDirty = false;
      result = canteens;
    });

    _cache = result;
    return new Future.value(result);
  }
}