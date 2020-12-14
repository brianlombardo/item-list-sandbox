import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_model.dart';

abstract class ItemsBloc extends Bloc<ListEvent, List<Item>> {}

abstract class ListEvent extends Equatable {}

class AddItem extends ListEvent {
  final String itemText;

  AddItem(this.itemText);

  @override
  List<Object> get props => [itemText];
}

class DeleteItem extends ListEvent {
  final String itemId;

  DeleteItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class RefreshItems extends ListEvent {
  @override
  List<Object> get props => [];
}
