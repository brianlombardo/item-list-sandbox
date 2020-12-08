import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String _item;

  ItemDetailsScreen(this._item);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_item),
        ),
        body: Column(
          children: <Widget>[],
        ),
      );
}
