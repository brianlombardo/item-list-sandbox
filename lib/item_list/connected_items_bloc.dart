import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_model.dart';

class ConnectedItemsBloc extends ItemsBloc {
  List<Item> _items = [];
  final ItemsRepository _repo;

  ConnectedItemsBloc({ItemsRepository repo})
      : _repo = repo ?? ItemsRepository();

  @override
  List<Item> get initialState => [];

  @override
  Stream<List<Item>> mapEventToState(ListEvent event) async* {
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
    yield _items;
  }
}
