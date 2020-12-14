import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_model.dart';

class FakeItemsBloc extends ItemsBloc {
  List<Item> items = [];
  List<ListEvent> events = [];

  @override
  List<Item> get initialState => items;

  @override
  Stream<List<Item>> mapEventToState(ListEvent event) async* {
    events.add(event);
    yield items;
  }
}
