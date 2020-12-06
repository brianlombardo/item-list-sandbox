import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'items_bloc.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ItemsBloc, List<String>>(
        builder: (context, items) =>
            ListView.builder(
              itemBuilder: (context, index) =>
                  ListTile(
                    title: Text(items[index]),
                  ),
              itemCount: items.length,
            ),
      );
}
