import 'package:ccore/ccore.dart';
import 'package:cpub/dartz.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';

void main() {
  group('CEitherExtension Tests', () {
    test(
      requirement(
        Given: 'Right with some value',
        When: 'cAsRight',
        Then: 'returns value',
      ),
      procedure(() => expect(right(12).cAsRight(), 12)),
    );

    test(
      requirement(
        Given: 'Left with some value',
        When: 'cAsLeft',
        Then: 'returns value',
      ),
      procedure(() => expect(left(32).cAsLeft(), 32)),
    );
  });
}
