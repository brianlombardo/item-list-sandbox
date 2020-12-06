import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/items_bloc.dart';
import 'package:item_list/items_repository.dart';
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

    blocTest(
      "adds item to list",
      build: () async => ItemsBloc(repo: mockRepo),
      act: (bloc) => bloc.add("Test"),
      expect: [
        ["Test"]
      ],
    );

    blocTest(
      "adds multiple items to list",
      build: () async => ItemsBloc(repo: mockRepo),
      act: (bloc) {
        bloc.add("Test");
        bloc.add("Test 2");
        return;
      },
      expect: [
        ["Test"],
        ["Test", "Test 2"]
      ],
    );
  });
}

class MockRepo extends Mock implements ItemsRepository {}
