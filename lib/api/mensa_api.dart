import 'package:germanmealbrowser/models/canteen.dart';
import 'dart:async';

abstract class MensaApi {
  Future<Map<int, Canteen>> getCanteens();
}