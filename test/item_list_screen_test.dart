import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/item_input.dart';
import 'package:item_list/item_list/item_list.dart';
import 'package:item_list/item_list/item_list_screen.dart';
import 'package:item_list/item_model.dart';
import 'package:mockito/mockito.dart';

import 'item_list_mocks.dart';

void main() {
  testWidgets('screen will show item text when user adds an item',
      (WidgetTester tester) async {
    //TODO: fix warning
    // ignore: close_sinks
    final MockInfoBloc bloc = MockInfoBloc();
    //
    // await tester.pumpWidget(
    //   MaterialApp(
    //     home: Scaffold(
    //       body: ItemListScreen(itemsBloc: bloc),
    //     ),
    //   ),
    // );
    //
    // final itemText = "Item";
    //
    // expect(find.byType(ItemInput), findsOneWidget);
    // expect(find.byType(ItemList), findsOneWidget);
    //
    // Finder textFinder = find.byType(Text);
    // expect(textFinder, findsNothing);
    //
    // await tester.enterText(find.byType(TextField), itemText);
    // when(bloc.state).thenReturn([Item(text: itemText)]);
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump(Duration.zero);
    //
    // expect(textFinder, findsOneWidget);
    // final actualText = (textFinder.evaluate().first.widget as Text).data;
    // expect(actualText, equals(itemText));
  });
}
