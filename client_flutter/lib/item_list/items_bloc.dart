import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_model.dart';

abstract class ItemsBloc extends Bloc<ItemListEvent, ItemListState> {}

abstract class ItemListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class ItemListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Loading extends ItemListState {}
class LoadFailed extends ItemListState {}

class Loaded extends ItemListState {
  final List<Item> items;

  Loaded(this.items);

  @override
  List<Object> get props => [items];
}

class AddItem extends ItemListEvent {
  final String itemText;

  AddItem(this.itemText);

  @override
  List<Object> get props => [itemText];
}

class DeleteItem extends ItemListEvent {
  final String itemId;

  DeleteItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class RefreshItems extends ItemListEvent {}
