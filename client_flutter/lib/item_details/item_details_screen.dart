import 'package:flutter/material.dart';

import '../model/item_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item _item;

  ItemDetailsScreen(this._item);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_item.text),
        ),
        body: Column(
          children: <Widget>[],
        ),
      );
}
