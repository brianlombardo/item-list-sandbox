import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_list/states.dart';
import 'package:mockito/mockito.dart';

class MockItemsBloc extends MockBloc<ItemListEvent, ItemListState>
    implements ItemsBloc {}

class MockHttpClient extends Mock implements Client {}

class MockResponse extends Mock implements Response {}

class MockRepo extends Mock implements ItemsRepository {}
