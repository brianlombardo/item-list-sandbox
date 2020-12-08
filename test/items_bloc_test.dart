import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_model.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/items_repository.dart';
import 'package:mockito/mockito.dart';

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
    final testItemText1 = "Test1";

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
    );

    blocTest(
      "adds multiple items to list",
      build: () async {
        final testItemResponses = [
          [Item(text: testItemText)],
          [Item(text: testItemText), Item(text: testItemText1)]
        ];
        when(mockRepo.getItems())
            .thenAnswer((_) async => testItemResponses.removeAt(0));
        return ItemsBloc(repo: mockRepo);
      },
      act: (bloc) {
        bloc.add(AddItem(testItemText));
        bloc.add(AddItem(testItemText1));
        return;
      },
      expect: [
        [Item(text: testItemText)],
        [Item(text: testItemText), Item(text: testItemText1)]
      ],
    );

    // blocTest(
    //   "deletes item from list",
    //   build: () async {
    //     final testItemResponses = [
    //       [Item(text: testItemText)],
    //       []
    //     ];
    //     when(mockRepo.getItems())
    //         .thenAnswer((_) async => testItemResponses.removeAt(0));
    //     return ItemsBloc(repo: mockRepo);
    //   },
    //   act: (bloc) {
    //     bloc.add(AddItem(testItemText));
    //     // bloc.add(DeleteItem());
    //     return;
    //   },
    //   expect: [
    //     [testItemText],
    //     []
    //   ],
    // );
  });
}

class MockRepo extends Mock implements ItemsRepository {}
