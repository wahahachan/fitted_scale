import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitted_scale/fitted_scale.dart';

void main() {
  test('Simple test', () {
    final aNullChildWidget = FittedScale(scale: 1);
  });

  testWidgets('Initialized with a scaled container', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scale: 0.5,
            child: Text('Hello world.'),
          ),
        )),
      ),
    );

    Finder foundText = find.text('Hello world.');
    expect(foundText, findsOneWidget);
    Rect r = tester.getRect(foundText);
    expect(r.width, greaterThanOrEqualTo(1));
    expect(r.width, lessThanOrEqualTo(200));
  });

  testWidgets('Initialized with a zero scaled text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scale: 0.0,
            child: Text('Hello world.'),
          ),
        )),
      ),
    );

    Finder foundText = find.text('Hello world.');
    expect(foundText, findsOneWidget);
    Rect r = tester.getRect(foundText);
    expect(r.width, equals(0));
    expect(r.height, equals(0));
  });

  testWidgets('Correctly scaled sizedbox', (tester) async {
    Key testKey = ValueKey(12345);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scale: 1.5,
            child: SizedBox(key: testKey, height: 60, width: 90),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, equals(135));
    expect(r.height, equals(90));
  });

  testWidgets('Correctly scaled sizedbox 2', (tester) async {
    Key testKey = ValueKey(12345);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleX: 2.5,
            scaleY: 0.25,
            child: SizedBox(key: testKey, height: 60, width: 90),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, equals(225));
    expect(r.height, equals(15));
  });

  testWidgets('Correctly scaled sizedbox 3', (tester) async {
    Key testKey = ValueKey(12345);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleX: -1.5,
            scaleY: -2,
            child: SizedBox(key: testKey, height: 60, width: 90),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, equals(135));
    expect(r.height, equals(120));
  });

  testWidgets('A zero X scaled text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleX: 0.0,
            child: Text('Hello world.'),
          ),
        )),
      ),
    );

    Finder foundText = find.text('Hello world.');
    expect(foundText, findsOneWidget);
    Rect r = tester.getRect(foundText);
    expect(r.width, equals(0));
    expect(r.height, greaterThan(0));
  });

  testWidgets('A zero Y scaled text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleY: 0.0,
            child: Text('Hello world.'),
          ),
        )),
      ),
    );

    Finder foundText = find.text('Hello world.');
    expect(foundText, findsOneWidget);
    Rect r = tester.getRect(foundText);
    expect(r.width, greaterThan(0));
    expect(r.height, equals(0));
  });

  testWidgets('A elongated button', (tester) async {
    Key testKey = ValueKey(12345);
    int res = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleX: 1.8,
            child: IconButton(
                key: testKey,
                onPressed: () {
                  res++;
                },
                icon: Icon(Icons.close)),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, greaterThan(0));
    expect(r.height, greaterThan(0));
    await tester.tapAt(r.center);
    await tester.pumpAndSettle();
    expect(res, equals(1));
  });

  testWidgets('A zero scaled button', (tester) async {
    Key testKey = ValueKey(12345);
    int res = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scale: 0.0,
            child: IconButton(
                key: testKey,
                onPressed: () {
                  res++;
                },
                icon: Icon(Icons.close)),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, equals(0));
    expect(r.height, equals(0));
    await tester.tap(foundButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(res, equals(0));
  });

  testWidgets('A negative scaled button', (tester) async {
    Key testKey = ValueKey(12345);
    int res = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scale: -1.0,
            child: IconButton(
                key: testKey,
                onPressed: () {
                  res++;
                },
                icon: Icon(Icons.close)),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, greaterThan(0));
    expect(r.height, greaterThan(0));
    await tester.tap(foundButton);
    await tester.pumpAndSettle();
    expect(res, equals(1));
  });

  testWidgets('A negative X scaled button', (tester) async {
    Key testKey = ValueKey(12345);
    int res = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleX: -0.8,
            child: IconButton(
                key: testKey,
                onPressed: () {
                  res++;
                },
                icon: Icon(Icons.close)),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, greaterThan(0));
    expect(r.height, greaterThan(0));
    await tester.tapAt(r.center);
    await tester.pumpAndSettle();
    expect(res, equals(1));
  });
  testWidgets('A negative X&Y scaled button', (tester) async {
    Key testKey = ValueKey(12345);
    int res = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Center(
          child: FittedScale(
            scaleY: -0.6,
            scaleX: -0.8,
            child: IconButton(
                key: testKey,
                onPressed: () {
                  res++;
                },
                icon: Icon(Icons.close)),
          ),
        )),
      ),
    );

    Finder foundButton = find.byKey(testKey);
    expect(foundButton, findsOneWidget);
    Rect r = tester.getRect(foundButton);
    expect(r.width, greaterThan(0));
    expect(r.height, greaterThan(0));
    await tester.tapAt(r.center);
    await tester.pumpAndSettle();
    expect(res, equals(1));
  });
}
