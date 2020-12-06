
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsBloc extends Bloc<String, List<String>> {
  List<String> _items = [];

  @override
  List<String> get initialState => _items;

  @override
  Stream<List<String>> mapEventToState(String item) async* {
    _items = [..._items, item];
    yield _items;
  }
}
