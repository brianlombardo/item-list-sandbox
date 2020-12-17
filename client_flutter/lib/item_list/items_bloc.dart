import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_list/states.dart';
import 'package:item_list/item_model.dart';

abstract class ItemsBloc extends Bloc<ItemListEvent, ItemListState> {
  @override
  ItemListState get initialState => Initial();
}

class ConnectedItemsBloc extends ItemsBloc {
  List<Item> _items = [];
  final ItemsRepository _repo;

  ConnectedItemsBloc({ItemsRepository repo})
      : _repo = repo ?? ItemsRepository();

  @override
  Stream<ItemListState> mapEventToState(ItemListEvent event) async* {
    yield Loading();
    switch (event.runtimeType) {
      case AddItem:
        {
          final text = (event as AddItem).itemText;
          if (text.isEmpty) {
            yield Error("Item text cannot be blank");
            return;
          }
          await _repo.createItem(text);
          break;
        }
      case DeleteItem:
        {
          final id = (event as DeleteItem).itemId;
          await _repo.deleteItem(id);
          break;
        }
    }
    _items = await _repo.getItems();
    _items.sort((item1, item2) => item1.id.compareTo(item2.id));
    _items = _items.reversed.toList();
    yield Loaded(_items);
  }
}
