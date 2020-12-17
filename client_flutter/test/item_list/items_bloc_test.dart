import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:item_list/item_list/states.dart';
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
      "emits initial state",
      build: () async => ConnectedItemsBloc(repo: mockRepo),
      skip: 0,
      expect: [Initial()],
    );

    final testItemText = "Test";

    blocTest(
      "adds item to list",
      build: () async {
        when(mockRepo.getItems())
            .thenAnswer((_) async => [Item(text: testItemText)]);

        return ConnectedItemsBloc(repo: mockRepo);
      },
      skip: 0,
      act: (bloc) async => bloc.add(AddItem(testItemText)),
      expect: [
        Initial(),
        Loading(),
        Loaded([Item(text: testItemText)])
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

        return ConnectedItemsBloc(repo: mockRepo);
      },
      skip: 0,
      act: (bloc) async => bloc.add(DeleteItem(item.id)),
      expect: [Initial(), Loading(), Loaded([])],
      verify: (_) {
        verify(mockRepo.deleteItem(item.id));
        return;
      },
    );

    blocTest(
      "refreshes the list",
      build: () async {
        when(mockRepo.getItems()).thenAnswer((_) async => []);

        return ConnectedItemsBloc(repo: mockRepo);
      },
      skip: 0,
      act: (bloc) async => bloc.add(RefreshItems()),
      expect: [Initial(), Loading(), Loaded([])],
      verify: (_) {
        verify(mockRepo.getItems());
        return;
      },
    );

    final unsortedItem0 = Item(text: "item", id: "0");
    final unsortedItem1 = Item(text: "item", id: "1");
    final unsortedItem2 = Item(text: "item", id: "2");

    blocTest(
      "sorts the list in descending order by id",
      build: () async {
        when(mockRepo.getItems()).thenAnswer((_) async => [
              unsortedItem1,
              unsortedItem0,
              unsortedItem2,
            ]);

        return ConnectedItemsBloc(repo: mockRepo);
      },
      skip: 0,
      act: (bloc) async => bloc.add(RefreshItems()),
      expect: [
        Initial(),
        Loading(),
        Loaded([
          unsortedItem2,
          unsortedItem1,
          unsortedItem0,
        ])
      ],
    );
  });
}
