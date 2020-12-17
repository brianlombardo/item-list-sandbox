import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/item_input.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  testWidgets('clicking add button will send field text to the bloc',
      (WidgetTester tester) async {
    final MockItemsBloc bloc = MockItemsBloc();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemInput(
            bloc: bloc,
          ),
        ),
      ),
    );

    final testText = "Item text";

    await tester.enterText(find.byType(TextField), testText);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    verify(bloc.add(AddItem(testText)));
    bloc.close();
  });
}
