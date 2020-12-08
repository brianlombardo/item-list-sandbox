import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_details/item_details_screen.dart';

import 'items_bloc.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ItemsBloc, List<String>>(
        builder: (context, items) => ListView.builder(
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: Text(item),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // builder: (context) => ItemDetailsScreen(item)),
                      builder: (context) => ItemDetailsScreen(item)),
                );
              },
            );
          },
          itemCount: items.length,
        ),
      );
}
