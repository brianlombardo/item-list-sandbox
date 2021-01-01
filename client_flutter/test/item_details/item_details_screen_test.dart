import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_details/item_details_screen.dart';
import 'package:item_list/model/item_model.dart';

void main() {
  testWidgets('shows current item', (WidgetTester tester) async {
    final itemText = 'loaded item';
    var item = Item(text: itemText);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemDetailsScreen(item),
        ),
      ),
    );

    final actualText = (find.byType(Text).evaluate().first.widget as Text).data;
    expect(actualText, equals(itemText));
  });
}
