// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tm_demo/main.dart';
import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/home/home_page.dart';
import 'package:tm_demo/screens/home/movie_home_widget.dart';

import 'test_utils.dart';

void main() {
  setUp(() {
    return setWidgetTestConfig();
  });
  group('Home widget test', () {
    Widget widget = Provider<HomeBloc>(
      create: (context) => HomeBloc(context),
      dispose: disposeBloc,
      child: const HomePage(),
    );
    widget = wrapWithMaterialApp(widget);
    testWidgets('Contains Movie List', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(MovieHomeWidget), findsNWidgets(1));
    });
  });
}
