import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_list/items_repository.dart';
import 'package:http/http.dart' as http;

class ItemsBloc extends Bloc<String, List<String>> {
  List<String> _items = [];
  final ItemsRepository _repo;

  ItemsBloc({ItemsRepository repo}) : _repo = repo ?? ItemsRepository();

  @override
  List<String> get initialState => _items;

  @override
  Stream<List<String>> mapEventToState(String item) async* {
    await _repo.createItem(item);
    _items = [..._items, item];
    yield _items;
  }
}

// abstract class
