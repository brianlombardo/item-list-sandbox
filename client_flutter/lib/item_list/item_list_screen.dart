import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/states.dart';

import 'events.dart';
import 'item_input.dart';
import 'item_list.dart';

class ItemListScreen extends StatelessWidget {
  final _itemsBloc;

  ItemListScreen({ItemsBloc itemsBloc})
      : _itemsBloc = itemsBloc ?? ConnectedItemsBloc();

  @override
  Widget build(BuildContext context) {
    _itemsBloc.add(RefreshItems());
    return BlocProvider<ItemsBloc>.value(
      value: _itemsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: null,
        ),
        body: BlocBuilder<ItemsBloc, ItemListState>(
          builder: (context, listState) => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ItemInput(),
              ),
              Expanded(
                flex: 1,
                child: Container(child: ItemList(bloc: _itemsBloc)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
