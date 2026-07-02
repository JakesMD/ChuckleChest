import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cstorage_client/cstorage_client.dart';
import 'package:mocktail/mocktail.dart';

class MockCAuthClient extends Mock implements CAuthClient {}

class MockCChestClient extends Mock implements CChestClient {}

class MockCGemClient extends Mock implements CGemClient {}

class MockCPersonClient extends Mock implements CPersonClient {}

class MockCPlatformClient extends Mock implements CPlatformClient {}

class MockCStorageClient extends Mock implements CStorageClient {}

class CTestClients {
  CTestClients() {
    when(authClient.currentUserStream).thenAnswer(
      (_) => BobsStream(
        stream: () => Stream.value(bobsSuccess(bobsAbsent())),
      ),
    );
  }

  final authClient = MockCAuthClient();
  final chestClient = MockCChestClient();
  final gemClient = MockCGemClient();
  final personClient = MockCPersonClient();
  final platformClient = MockCPlatformClient();
  final storageClient = MockCStorageClient();
}
