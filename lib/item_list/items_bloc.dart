import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_model.dart';

class ItemsBloc extends Bloc<ListEvent, List<Item>> {
  List<Item> _items = [];
  final ItemsRepository _repo;

  ItemsBloc({ItemsRepository repo}) : _repo = repo ?? ItemsRepository();

  @override
  List<Item> get initialState => [];

  @override
  Stream<List<Item>> mapEventToState(ListEvent event) async* {
    switch (event.runtimeType) {
      case AddItem:
        {
          await _repo.createItem((event as AddItem).itemText);
          _items = await _repo.getItems();
          yield _items;
        }
    }
  }
}

abstract class ListEvent extends Equatable {}

class AddItem extends ListEvent {
  final String itemText;

  AddItem(this.itemText);

  @override
  List<Object> get props => [itemText];
}
