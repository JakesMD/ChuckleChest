import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';

void main() {
  group('CFormInput Tests', () {
    late CFormInput<dynamic> input;

    setUp(() => input = CFormInput());

    test(
      requirement(
        When: 'first initialized',
        Then: 'input is null',
      ),
      procedure(() => expect(input.input, isNull)),
    );

    test(
      requirement(
        Given: 'new input',
        When: 'onChanged',
        Then: 'input is new input',
      ),
      procedure(() {
        input.onChanged('new input');
        expect(input.input, 'new input');
      }),
    );
  });
}
