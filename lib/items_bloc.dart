import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/items_repository.dart';

class ItemsBloc extends Bloc<String, List<String>> {
  List<String> _items = [];
  final ItemsRepository _repo;

  ItemsBloc({ItemsRepository repo}) : _repo = repo ?? ItemsRepository();

  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(String item) async* {
    await _repo.createItem(item);
    final items = await _repo.getItems();
    _items = items.map((item) => item.text).toList();
    yield _items;
  }
}