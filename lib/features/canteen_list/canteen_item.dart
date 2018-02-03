import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:germanmealbrowser/models/canteen.dart';

typedef void CanteenChangedCallback(int index);

class CanteenItem extends StatelessWidget {

  const CanteenItem({Canteen canteen, Key key}) : canteen = canteen,
    super(key: key);

  final Canteen canteen;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(canteen.name),
    );
  }
}
