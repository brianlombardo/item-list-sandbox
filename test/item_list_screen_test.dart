import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_input.dart';
import 'package:item_list/item_list.dart';
import 'package:item_list/item_list_screen.dart';

void main() {
  testWidgets('screen will show item text when user adds an item',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemListScreen(),
        ),
      ),
    );

    expect(find.byType(ItemInput), findsOneWidget);
    expect(find.byType(ItemList), findsOneWidget);

    Finder textFinder = find.byType(Text);
    expect(textFinder, findsNothing);

    final item = "Item";
    await tester.enterText(find.byType(TextField), item);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(Duration.zero);

    expect(textFinder, findsOneWidget);

    final actualText = (textFinder.evaluate().first.widget as Text).data;
    expect(actualText, equals(item));
  });
}