import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/states.dart';
import 'package:item_list/item_model.dart';

class FakeItemsBloc extends ItemsBloc {
  List<Item> items = [];
  List<ItemListEvent> events = [];

  @override
  Stream<ItemListState> mapEventToState(ItemListEvent event) async* {
    events = [...events, event];
    yield Loaded(items);
  }
}
