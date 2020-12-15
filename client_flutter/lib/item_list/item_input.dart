import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_list/items_bloc.dart';

import 'events.dart';

class ItemInput extends StatefulWidget {
  final _controller = TextEditingController();

  @override
  _ItemInputState createState() => _ItemInputState();
}

class _ItemInputState extends State<ItemInput> {
  @override
  Widget build(BuildContext context) => TextField(
        controller: widget._controller,
        style: TextStyle(color: Colors.blue),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              _getBloc().add(AddItem(widget._controller.text));
            },
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ),
        ),
      );

  ItemsBloc _getBloc() => BlocProvider.of<ItemsBloc>(context);
}
