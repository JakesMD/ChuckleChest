import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

import '../../helpers.dart';

void main() {
  group('BAuthUser tests', () {
    group('isUserViewer', () {
      test(
        requirement(
          given: 'A chest with viewer role',
          whenever: 'isUserViewer is called',
          then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserViewer, isTrue);
        }),
      );

      test(
        requirement(
          given: 'A chest with collaborator role',
          whenever: 'isUserViewer is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserViewer, isFalse);
        }),
      );

      test(
        requirement(
          given: 'A chest with owner role',
          whenever: 'isUserViewer is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.owner);
          expect(chest.isUserViewer, isFalse);
        }),
      );
    });
    group('isUserCollaborator', () {
      test(
        requirement(
          given: 'A chest with viewer role',
          whenever: 'isUserCollaborator is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserCollaborator, isFalse);
        }),
      );

      test(
        requirement(
          given: 'A chest with collaborator role',
          whenever: 'isUserCollaborator is called',
          then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserCollaborator, isTrue);
        }),
      );

      test(
        requirement(
          given: 'A chest with owner role',
          whenever: 'isUserCollaborator is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.owner);
          expect(chest.isUserCollaborator, isFalse);
        }),
      );
    });

    group('isUserOwner', () {
      test(
        requirement(
          given: 'A chest with viewer role',
          whenever: 'isUserOwner is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserOwner, isFalse);
        }),
      );

      test(
        requirement(
          given: 'A chest with collaborator role',
          whenever: 'isUserOwner is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserOwner, isFalse);
        }),
      );

      test(
        requirement(
          given: 'A chest with owner role',
          whenever: 'isUserOwner is called',
          then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.owner);
          expect(chest.isUserOwner, isTrue);
        }),
      );
    });

    group('isUserManager', () {
      test(
        requirement(
          given: 'A chest with viewer role',
          whenever: 'isUserManager is called',
          then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserManager, isFalse);
        }),
      );

      test(
        requirement(
          given: 'A chest with collaborator role',
          whenever: 'isUserManager is called',
          then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserManager, isTrue);
        }),
      );

      test(
        requirement(
          given: 'A chest with owner role',
          whenever: 'isUserManager is called',
          then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.owner);
          expect(chest.isUserManager, isTrue);
        }),
      );
    });
  });
}
