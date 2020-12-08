import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_list/item_list.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:mockito/mockito.dart';

import 'item_list_mocks.dart';
import 'test_extensions.dart';

void main() {
  final MockInfoBloc bloc = MockInfoBloc();

  testWidgets('list is initially empty', (WidgetTester tester) async {
    when(bloc.state).thenReturn(<String>[]);

    await tester.pumpWidget(
      BlocProvider<ItemsBloc>.value(
        value: bloc,
        child: MaterialApp(
          home: Scaffold(
            body: ItemList(),
          ),
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);

    ListView list = find.byType(ListView).evaluate().first.widget;

    expect(list.semanticChildCount, equals(0));

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets(
      'when items are emitted by the bloc, then the list will display them',
      (WidgetTester tester) async {
    when(bloc.state).thenReturn(<String>[]);
    final testData = ["Test", "Test 2", "Test 3"];
    whenListen(bloc, Stream.fromIterable([<String>[], testData]));

    await tester.pumpWidget(
      BlocProvider<ItemsBloc>.value(
        value: bloc,
        child: MaterialApp(
          home: Scaffold(
            body: ItemList(),
          ),
        ),
      ),
    );

    Finder listFinder = find.byType(ListView);
    Finder tileFinder = find.byType(ListTile);
    Finder textFinder = find.byType(Text);

    var itemCount = listFinder.atIndex<ListView>(0).semanticChildCount;
    expect(itemCount, equals(0));
    expect(tileFinder, findsNothing);

    await tester.pump(Duration.zero);

    itemCount = listFinder.atIndex<ListView>(0).semanticChildCount;
    expect(itemCount, equals(3));
    expect(tileFinder, findsNWidgets(3));
    expect(textFinder, findsNWidgets(3));
    expect(textFinder.atIndex<Text>(0).data, testData[0]);
    expect(textFinder.atIndex<Text>(1).data, testData[1]);
    expect(textFinder.atIndex<Text>(2).data, testData[2]);
  });
}
