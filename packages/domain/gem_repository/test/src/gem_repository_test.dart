import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mallard/mallard.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

class _MockCGemClient extends Mock implements CGemClient {}

class _MockCPlatformClient extends Mock implements CPlatformClient {}

void main() {
  group('CGemRepository', () {
    late _MockCGemClient gemClient;
    late CGemRepository repo;

    setUp(() {
      gemClient = _MockCGemClient();
      repo = CGemRepository(
        gemClient: gemClient,
        platformClient: _MockCPlatformClient(),
      );
    });

    group('deleteGem', () {
      Task<String, CRawGemDeleteException> mockDeleteGem() =>
          gemClient.deleteGem(gemID: any(named: 'gemID'));

      Task<String, CGemDeleteException> deleteGemTask() =>
          repo.deleteGem(gemID: 'gem-1');

      test(
        requirement(
          given: 'gem ID',
          whenever: 'deleteGem succeeds',
          then: 'returns deleted gem ID',
        ),
        () async {
          when(mockDeleteGem).thenReturn(Task.succeed('gem-1'));

          final result = await deleteGemTask().run();

          expect(result.asSuccess, 'gem-1');
        },
      );

      test(
        requirement(
          given: 'gem ID',
          whenever: 'deleteGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(mockDeleteGem)
              .thenReturn(Task.fail(CRawGemDeleteException.unknown));

          final result = await deleteGemTask().run();

          expect(result.asFailure, CGemDeleteException.unknown);
        },
      );
    });
  });
}
