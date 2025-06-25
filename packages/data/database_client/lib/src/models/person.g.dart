// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// PgModelXGenerator
// **************************************************************************

// The generator is not capable of fetching the documentation comments for some
// reason.
// ignore_for_file: public_member_api_docs

extension PgCRawPersonX on CRawPerson {
  BigInt get id => value(CPeopleTable.id);
  String get chestID => value(CPeopleTable.chestID);
  String get nickname => value(CPeopleTable.nickname);
  DateTime get dateOfBirth => value(CPeopleTable.dateOfBirth);
  List<CRawPersonAvatar> get avatars =>
      value(CPeopleTable.avatars(CRawPersonAvatar.builder));
}
