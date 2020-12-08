import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/item_input.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:mockito/mockito.dart';

import 'item_list_mocks.dart';

void main() {
  final MockInfoBloc bloc = MockInfoBloc();

  testWidgets('clicking add button will send field text to the bloc',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<ItemsBloc>.value(
        value: bloc,
        child: MaterialApp(
          home: Scaffold(
            body: ItemInput(),
          ),
        ),
      ),
    );

    final testText = "Item text";

    await tester.enterText(find.byType(TextField), testText);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    verify(bloc.add(testText));
  });
}
