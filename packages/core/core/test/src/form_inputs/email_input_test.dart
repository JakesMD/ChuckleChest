import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:flutter/widgets.dart';

Widget _testWithLocalizations(void Function(BuildContext context) expect) {
  return Localizations(
    delegates: CCoreL10n.localizationsDelegates,
    locale: CCoreL10n.supportedLocales[0],
    child: Builder(
      builder: (context) {
        expect(context);
        return const SizedBox();
      },
    ),
  );
}

void main() {
  group('BEmailInput Tests', () {
    late CEmailInput input;

    setUp(() => input = CEmailInput());

    testWidgets(
      requirement(
        Given: 'empty input',
        When: 'validate',
        Then: 'returns string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          _testWithLocalizations(
            (context) => expect(
              input.validator(input: ' ', context: context),
              isA<String>(),
            ),
          ),
        );
      }),
    );

    testWidgets(
      requirement(
        Given: 'invalid email',
        When: 'validate',
        Then: 'returns string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          _testWithLocalizations(
            (context) => expect(
              input.validator(input: 'sfsdf', context: context),
              isA<String>(),
            ),
          ),
        );
      }),
    );

    testWidgets(
      requirement(
        Given: 'valid input',
        When: 'parse',
        Then: 'returns num',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          _testWithLocalizations(
            (context) => expect(
              input.parse(input: 'abc@def.com', context: context),
              'abc@def.com',
            ),
          ),
        );
      }),
    );
  });
}
