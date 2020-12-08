import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';

class ItemsBloc extends Bloc<ListEvent, List<String>> {
  List<String> _items = [];
  final ItemsRepository _repo;

  ItemsBloc({ItemsRepository repo}) : _repo = repo ?? ItemsRepository();

  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(ListEvent event) async* {
    switch (event.runtimeType) {
      case AddItem:
        {
          await _repo.createItem((event as AddItem).itemText);
          final items = await _repo.getItems();
          _items = items.map((item) => item.text).toList();
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
