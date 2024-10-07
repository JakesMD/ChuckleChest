import 'package:ccore/ccore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

void main() {
  group('CUserRole tests', () {
    group('parse', () {
      test(
        requirement(
          Given: 'a valid owner string',
          When: 'the string is parsed',
          Then: 'returns a [CUserRole.owner] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('owner'), CUserRole.owner);
        }),
      );
      test(
        requirement(
          Given: 'a valid collaborator string',
          When: 'the string is parsed',
          Then: 'returns a [CUserRole.collaborator] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('collaborator'), CUserRole.collaborator);
        }),
      );

      test(
        requirement(
          Given: 'a valid viewer string',
          When: 'the string is parsed',
          Then: 'returns a [CUserRole.viewer] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('viewer'), CUserRole.viewer);
        }),
      );
      test(
        requirement(
          Given: 'an invalid string',
          When: 'the string is parsed',
          Then: 'returns a [CUserRole.viewer] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('akfjkkflajkal'), CUserRole.viewer);
        }),
      );
    });
  });
}
