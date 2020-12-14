import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/item_input.dart';
import 'package:item_list/item_list/item_list.dart';
import 'package:item_list/item_list/item_list_screen.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_model.dart';

import '../fake_items_bloc.dart';

void main() {
  testWidgets('screen will show input and list', (WidgetTester tester) async {
    final fakeItemsBloc = FakeItemsBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemListScreen(itemsBloc: fakeItemsBloc),
        ),
      ),
    );

    expect(find.byType(ItemInput), findsOneWidget);
    expect(find.byType(ItemList), findsOneWidget);
    expect(fakeItemsBloc.events.length, equals(1));
    expect(fakeItemsBloc.events[0], equals(RefreshItems()));
    expect(find.byType(ItemInput), findsOneWidget);
    expect(find.byType(ItemList), findsOneWidget);

    final enteredItemText = "Entered Item Text!!!";
    final blocItemText = "Bloc Item Text!!!";

    await tester.enterText(find.byType(TextField), enteredItemText);
    fakeItemsBloc.items = [Item(text: blocItemText)];
    await tester.tap(find.byIcon(Icons.add));

    Finder textFinder = find.byType(Text);
    expect(textFinder, findsNothing);

    await tester.pump(Duration.zero);

    expect(fakeItemsBloc.events.length, equals(2));
    expect(fakeItemsBloc.events[1], equals(AddItem(enteredItemText)));

    expect(textFinder, findsOneWidget);
    final actualText = (textFinder.evaluate().first.widget as Text).data;
    expect(actualText, equals(blocItemText));
  });
}
