import 'package:equatable/equatable.dart';
import 'package:item_list/item_model.dart';

abstract class ItemListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends ItemListState {}
class Loading extends ItemListState {}

class LoadFailed extends ItemListState {}

class Loaded extends ItemListState {
  final List<Item> items;

  Loaded(this.items);

  @override
  List<Object> get props => [items];
}
