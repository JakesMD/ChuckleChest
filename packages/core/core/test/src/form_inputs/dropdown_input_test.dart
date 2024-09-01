import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:flutter/material.dart';

Widget localizations({required Widget Function(BuildContext context) builder}) {
  return Localizations(
    delegates: CCoreL10n.localizationsDelegates,
    locale: CCoreL10n.supportedLocales[0],
    child: Builder(builder: builder),
  );
}

void main() {
  group('CDropdownInput Tests', () {
    late CDropdownInput<int> input;

    setUp(() => input = CDropdownInput());

    testWidgets(
      requirement(
        Given: 'empty input',
        When: 'validate',
        Then: 'returns error text',
      ),
      widgetsProcedure((tester) async {
        String? result;

        await tester.pumpWidget(
          localizations(
            builder: (context) {
              result = input.validator(input: null, context: context);
              return Container();
            },
          ),
        );
        expect(result, isNotNull);
      }),
    );

    testWidgets(
      requirement(
        Given: 'valid input',
        When: 'parse',
        Then: 'returns value',
      ),
      widgetsProcedure((tester) async {
        var result = 0;

        await tester.pumpWidget(
          localizations(
            builder: (context) {
              result = input.parse(input: 5, context: context);
              return Container();
            },
          ),
        );
        expect(result, 5);
      }),
    );
  });
}
