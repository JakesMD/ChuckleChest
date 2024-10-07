import 'package:ccore/ccore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

MaterialApp themedApp({required Widget Function(BuildContext) builder}) {
  return MaterialApp(
    home: Builder(builder: builder),
  );
}

void main() {
  group('CContextExtension Tests', () {
    group('cTextTheme', () {
      testWidgets(
        requirement(
          When: 'cTextTheme is called',
          Then: 'should return a TextTheme',
        ),
        widgetsProcedure((tester) async {
          await tester.pumpWidget(
            themedApp(
              builder: (context) {
                expect(context.cTextTheme, isA<TextTheme>());
                return Container();
              },
            ),
          );
        }),
      );
    });
    group('cColorScheme', () {
      testWidgets(
        requirement(
          When: 'cColorScheme is called',
          Then: 'should return a ColorScheme',
        ),
        widgetsProcedure((tester) async {
          await tester.pumpWidget(
            themedApp(
              builder: (context) {
                expect(context.cColorScheme, isA<ColorScheme>());
                return Container();
              },
            ),
          );
        }),
      );
    });
  });
}
