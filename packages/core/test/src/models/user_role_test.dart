import 'package:ccore/ccore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

void main() {
  group('CUserRole tests', () {
    group('parse', () {
      test(
        requirement(
          given: 'a valid owner string',
          whenever: 'the string is parsed',
          then: 'returns a [CUserRole.owner] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('owner'), CUserRole.owner);
        }),
      );
      test(
        requirement(
          given: 'a valid collaborator string',
          whenever: 'the string is parsed',
          then: 'returns a [CUserRole.collaborator] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('collaborator'), CUserRole.collaborator);
        }),
      );

      test(
        requirement(
          given: 'a valid viewer string',
          whenever: 'the string is parsed',
          then: 'returns a [CUserRole.viewer] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('viewer'), CUserRole.viewer);
        }),
      );
      test(
        requirement(
          given: 'an invalid string',
          whenever: 'the string is parsed',
          then: 'returns a [CUserRole.viewer] instance',
        ),
        procedure(() {
          expect(CUserRole.parse('akfjkkflajkal'), CUserRole.viewer);
        }),
      );
    });
  });
}
