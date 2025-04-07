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
          Given: 'A chest with viewer role',
          When: 'isUserViewer is called',
          Then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserViewer, isTrue);
        }),
      );

      test(
        requirement(
          Given: 'A chest with collaborator role',
          When: 'isUserViewer is called',
          Then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserViewer, isFalse);
        }),
      );

      test(
        requirement(
          Given: 'A chest with owner role',
          When: 'isUserViewer is called',
          Then: 'returns false',
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
          Given: 'A chest with viewer role',
          When: 'isUserCollaborator is called',
          Then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserCollaborator, isFalse);
        }),
      );

      test(
        requirement(
          Given: 'A chest with collaborator role',
          When: 'isUserCollaborator is called',
          Then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserCollaborator, isTrue);
        }),
      );

      test(
        requirement(
          Given: 'A chest with owner role',
          When: 'isUserCollaborator is called',
          Then: 'returns false',
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
          Given: 'A chest with viewer role',
          When: 'isUserOwner is called',
          Then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserOwner, isFalse);
        }),
      );

      test(
        requirement(
          Given: 'A chest with collaborator role',
          When: 'isUserOwner is called',
          Then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserOwner, isFalse);
        }),
      );

      test(
        requirement(
          Given: 'A chest with owner role',
          When: 'isUserOwner is called',
          Then: 'returns true',
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
          Given: 'A chest with viewer role',
          When: 'isUserManager is called',
          Then: 'returns false',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.viewer);
          expect(chest.isUserManager, isFalse);
        }),
      );

      test(
        requirement(
          Given: 'A chest with collaborator role',
          When: 'isUserManager is called',
          Then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.collaborator);
          expect(chest.isUserManager, isTrue);
        }),
      );

      test(
        requirement(
          Given: 'A chest with owner role',
          When: 'isUserManager is called',
          Then: 'returns true',
        ),
        procedure(() {
          final chest = createChest(userRole: CUserRole.owner);
          expect(chest.isUserManager, isTrue);
        }),
      );
    });
  });
}
