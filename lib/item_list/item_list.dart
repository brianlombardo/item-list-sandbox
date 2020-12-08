import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_details/item_details_screen.dart';

import '../item_model.dart';
import 'items_bloc.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ItemsBloc, List<Item>>(
        builder: (context, items) => ListView.builder(
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              onDismissed: (direction) => {},
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
        ),
      );
}
