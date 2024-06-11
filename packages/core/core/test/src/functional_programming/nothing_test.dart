import 'package:ccore/src/functional_programming/_functional_programming.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';

void main() {
  group('CNothing tests', () {
    group('cNothing', () {
      test(
        requirement(
          When: 'cNothing is called',
          Then: 'returns an instance of CNothing',
        ),
        procedure(() {
          expect(cNothing, isA<CNothing>());
        }),
      );
    });
  });
}
