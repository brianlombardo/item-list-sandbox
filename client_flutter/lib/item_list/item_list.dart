import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_details/item_details_screen.dart';
import 'package:item_list/item_model.dart';

import 'items_bloc.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ItemsBloc, ItemListState>(
        builder: (context, listState) {
          final List<Item> items =
              listState is Loaded ? listState.items : [];
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                onDismissed: (direction) => {
                  BlocProvider.of<ItemsBloc>(context)
                      .add(DeleteItem(items[index].id))
                },
                key: UniqueKey(),
                child: ListTile(
                  title: Text(item.text),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemDetailsScreen(item)),
                    );
                  },
                ),
              );
            },
            itemCount: items.length,
          );
        },
      );
}
