import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_model.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  ItemsRepository mockRepo;

  setUp(() {
    mockRepo = MockRepo();
  });

  group("Items bloc", () {
    blocTest(
      "empty list initial state",
      build: () async => ItemsBloc(repo: mockRepo),
      skip: 0,
      expect: [[]],
    );

    final testItemText = "Test";

    blocTest(
      "adds item to list",
      build: () async {
        when(mockRepo.getItems())
            .thenAnswer((_) async => [Item(text: testItemText)]);

        return ItemsBloc(repo: mockRepo);
      },
      act: (bloc) {
        return bloc.add(AddItem(testItemText));
      },
      expect: [
        [Item(text: testItemText)]
      ],
      verify: (_) {
        verify(mockRepo.createItem(testItemText));
        return;
      },
    );

    final item = Item(id: "ID", text: testItemText);
    blocTest(
      "deletes item from list",
      build: () async {
        when(mockRepo.getItems()).thenAnswer((_) async => []);

        return ItemsBloc(repo: mockRepo);
      },
      act: (bloc) {
        bloc.add(DeleteItem(item.id));
        return;
      },
      expect: [[]],
      verify: (_) {
        verify(mockRepo.deleteItem(item.id));
        return;
      },
    );

    blocTest(
      "refreshes the list",
      build: () async {
        when(mockRepo.getItems()).thenAnswer((_) async => []);

        return ItemsBloc(repo: mockRepo);
      },
      act: (bloc) {
        bloc.add(RefreshItems());
        return;
      },
      expect: [[]],
      verify: (_) {
        verify(mockRepo.getItems());
        return;
      },
    );
  });
}
