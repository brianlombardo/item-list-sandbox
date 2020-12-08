import 'package:bloc_test/bloc_test.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_model.dart';

class MockInfoBloc extends MockBloc<ListEvent, List<Item>>
    implements ItemsBloc {}
