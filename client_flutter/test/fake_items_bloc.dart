import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_model.dart';

class FakeItemsBloc extends ItemsBloc {
  List<Item> items = [];
  List<ItemListEvent> events = [];

  @override
  ItemListState get initialState => Loading();

  @override
  Stream<ItemListState> mapEventToState(ItemListEvent event) async* {
    events.add(event);
    yield Loaded(items);
  }
}
