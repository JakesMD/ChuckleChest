// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem.dart';

// **************************************************************************
// PgModelXGenerator
// **************************************************************************

// The generator is not capable of fetching the documentation comments for some
// reason.
// ignore_for_file: public_member_api_docs

extension PgCRawGemX on CRawGem {
  String get id => value(CGemsTable.id);
  String get chestID => value(CGemsTable.chestID);
  int get number => value(CGemsTable.number);
  DateTime get occurredAt => value(CGemsTable.occurredAt);
  List<CRawLine> get lines => value(CGemsTable.lines(CRawLine.builder));
  CRawGemShareToken? get shareToken =>
      value(CGemsTable.shareToken(CRawGemShareToken.builder));
}
