import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/items_bloc.dart';

void main() {
  group("Items bloc", () {
    blocTest(
      "empty list initial state",
      build: () async => ItemsBloc(),
      skip: 0,
      expect: [[]],
    );

    blocTest(
      "adds item to list",
      build: () async => ItemsBloc(),
      act: (bloc) => bloc.add("Test"),
      expect: [
        ["Test"]
      ],
    );

    blocTest(
      "adds  multiple items to list",
      build: () async => ItemsBloc(),
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
