import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_list/item_details/item_details_screen.dart';
import 'package:item_list/item_list/events.dart';
import 'package:item_list/item_list/item_list.dart';
import 'package:item_list/item_list/items_bloc.dart';
import 'package:item_list/item_list/states.dart';
import 'package:item_list/item_model.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';
import '../test_extensions.dart';

void main() {
  final MockInfoBloc bloc = MockInfoBloc();

  testWidgets('list is initially empty', (WidgetTester tester) async {
    when(bloc.state).thenReturn(Loaded([]));

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
    final testData = [
      Item(text: "Test"),
      Item(text: "Test 2"),
      Item(text: "Test 3")
    ];
    whenListen(bloc, Stream.fromIterable([Loaded([]), Loaded(testData)]));

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
    expect(textFinder.atIndex<Text>(0).data, testData[0].text);
    expect(textFinder.atIndex<Text>(1).data, testData[1].text);
    expect(textFinder.atIndex<Text>(2).data, testData[2].text);
  });

  testWidgets('when item is selected, then the details screen is shown',
      (WidgetTester tester) async {
    final testData = [Item(text: "Test")];
    when(bloc.state).thenReturn(Loaded(testData));

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

    Finder tileFinder = find.byType(ListTile);
    expect(tileFinder, findsOneWidget);

    await tester.tap(tileFinder);
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailsScreen), findsNWidgets(1));
    var textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);
    expect(textFinder.atIndex<Text>(0).data, testData[0].text);
  });

  testWidgets(
      'when item is swiped away, then the item should be removed from list',
      (WidgetTester tester) async {
    final testData = [Item(id: "ID", text: "Test")];
    when(bloc.state).thenReturn(Loaded(testData));

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

    Finder dismissibleFinder = find.byType(Dismissible);
    expect(dismissibleFinder, findsOneWidget);
    expect(bloc.state, equals(Loaded(testData)));

    await tester.drag(dismissibleFinder, Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    expect(dismissibleFinder, findsNothing);
    verify(bloc.add(DeleteItem("ID")));
  });
}
