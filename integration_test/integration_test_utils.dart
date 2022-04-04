import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tm_demo/main.dart' as app;

startApp(WidgetTester tester) async {
  app.main();
  //Wait for splash page to finish
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}

openFirstMovieItemDetails(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('btn_image_title')).first);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}
