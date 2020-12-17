import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/item_input.dart';
import 'package:item_list/item_list/item_list.dart';
import 'package:item_list/item_list/item_list_screen.dart';
import 'package:item_list/item_list/states.dart';
import 'package:item_list/item_model.dart';

import '../fake_items_bloc.dart';

void main() {
  testWidgets('initially shows loading indicator', (WidgetTester tester) async {
    final fakeItemsBloc = FakeItemsBloc();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemListScreen(itemsBloc: fakeItemsBloc),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    fakeItemsBloc.close();
  });

  testWidgets('shows input and list when data is loaded',
      (WidgetTester tester) async {
    final fakeItemsBloc = FakeItemsBloc();
    final itemText = "loaded item";
    fakeItemsBloc.states = [Loaded([Item(text: itemText)])];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemListScreen(itemsBloc: fakeItemsBloc),
        ),
      ),
    );
    final itemInput = find.byType(ItemInput);
    final itemList = find.byType(ItemList);
    expect(itemInput, findsNothing);
    expect(itemList, findsNothing);

    await tester.pump(Duration.zero);

    expect(itemInput, findsOneWidget);
    expect(itemList, findsOneWidget);
    expect(fakeItemsBloc.events, equals([RefreshItems()]));
    final actualText = (find.byType(Text).evaluate().first.widget as Text).data;
    expect(actualText, equals(itemText));

    fakeItemsBloc.close();
  });

  testWidgets('shows loading indicator while data is reloading',
      (WidgetTester tester) async {
    final fakeItemsBloc = FakeItemsBloc();
    fakeItemsBloc.states = [Loaded([])];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemListScreen(itemsBloc: fakeItemsBloc),
        ),
      ),
    );
    await tester.pump(Duration.zero);

    final itemInput = find.byType(ItemInput);
    final itemList = find.byType(ItemList);
    expect(itemInput, findsOneWidget);
    expect(itemList, findsOneWidget);

    fakeItemsBloc.states = [Loading()];

    final itemText = "aloha";
    await tester.enterText(find.byType(TextField), itemText);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(Duration.zero);

    expect(itemInput, findsNothing);
    expect(itemList, findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(fakeItemsBloc.events, equals([RefreshItems(), AddItem(itemText)]));

    fakeItemsBloc.close();
  });
}
