import 'dart:async';

import 'package:germanmealbrowser/models/canteen.dart';

abstract class CanteensRepository {
  Future<Map<int, Canteen>> findAll();
}