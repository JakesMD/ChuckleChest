import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

const _chestID = 'chest-1';
const _gemID = 'gem-1';
final _lineID = BigInt.from(42);
final _personID = BigInt.from(7);

CRawLine _fakeRawLine({bool withPerson = false}) => CRawLine(
  {
    'id': 42,
    'text': 'Hello world',
    'person_id': withPerson ? 7 : null,
    'gem_id': _gemID,
    'chest_id': _chestID,
  },
  null,
);

CLine _fakeLine({BigInt? personID}) => CLine(
  id: _lineID,
  text: 'Hello world',
  personID: personID,
  gemID: _gemID,
  chestID: _chestID,
);

void main() {
  group('CLine', () {
    group('fromRaw', () {
      test(
        requirement(
          given: 'raw line without person',
          whenever: 'fromRaw is called',
          then: 'creates CLine with correct fields and null personID',
        ),
        () {
          final result = CLine.fromRaw(_fakeRawLine());
          expect(result.id, _lineID);
          expect(result.text, 'Hello world');
          expect(result.personID, isNull);
          expect(result.gemID, _gemID);
          expect(result.chestID, _chestID);
        },
      );

      test(
        requirement(
          given: 'raw line with person',
          whenever: 'fromRaw is called',
          then: 'creates CLine with personID set',
        ),
        () {
          final result = CLine.fromRaw(_fakeRawLine(withPerson: true));
          expect(result.personID, _personID);
        },
      );
    });

    group('copyWith', () {
      test(
        requirement(
          given: 'line',
          whenever: 'copyWith called with new text',
          then: 'returns line with updated text',
        ),
        () {
          final result = _fakeLine().copyWith(text: 'Updated');
          expect(result.text, 'Updated');
          expect(result.id, _lineID);
        },
      );

      test(
        requirement(
          given: 'line without person',
          whenever: 'copyWith called with personID',
          then: 'returns line with personID set',
        ),
        () {
          final result = _fakeLine().copyWith(personID: _personID);
          expect(result.personID, _personID);
        },
      );
    });

    group('toInsert', () {
      test(
        requirement(
          given: 'line',
          whenever: 'toInsert is called',
          then: 'returns CLinesTableInsert with correct fields',
        ),
        () {
          final result = _fakeLine(personID: _personID).toInsert();
          expect(result.id, _lineID);
          expect(result.text, 'Hello world');
          expect(result.gemID, _gemID);
          expect(result.chestID, _chestID);
        },
      );
    });

    group('equality', () {
      test(
        requirement(
          given: 'two lines with same fields',
          whenever: 'equality is checked',
          then: 'they are equal',
        ),
        () {
          expect(_fakeLine(), _fakeLine());
        },
      );
    });

    group('isQuote', () {
      test(
        requirement(
          given: 'line with personID',
          whenever: 'isQuote is checked',
          then: 'returns true',
        ),
        () {
          expect(_fakeLine(personID: _personID).isQuote, isTrue);
        },
      );

      test(
        requirement(
          given: 'line without personID',
          whenever: 'isQuote is checked',
          then: 'returns false',
        ),
        () {
          expect(_fakeLine().isQuote, isFalse);
        },
      );
    });
  });
}
