// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// PgModelXGenerator
// **************************************************************************

// The generator is not capable of fetching the documentation comments for some
// reason.
// ignore_for_file: public_member_api_docs

extension PgCRawInvitationX on CRawInvitation {
  String get email => value(CInvitationsTable.email);
  CUserRole get assignedRole => value(CInvitationsTable.assignedRole);
  CRawChest get chest => value(CInvitationsTable.chest(CRawChest.builder));
}
