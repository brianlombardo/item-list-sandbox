import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_list/states.dart';
import 'package:item_list/item_model.dart';

abstract class ItemsBloc extends Bloc<ItemListEvent, ItemListState> {}

class ConnectedItemsBloc extends ItemsBloc {
  List<Item> _items = [];
  final ItemsRepository _repo;

  ConnectedItemsBloc({ItemsRepository repo})
      : _repo = repo ?? ItemsRepository();

  @override
  ItemListState get initialState => Loading();

  @override
  Stream<ItemListState> mapEventToState(ItemListEvent event) async* {
    switch (event.runtimeType) {
      case AddItem:
        {
          await _repo.createItem((event as AddItem).itemText);
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
    yield Loaded(_items);
  }
}
