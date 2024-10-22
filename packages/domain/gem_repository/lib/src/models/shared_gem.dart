import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cperson_repository/cperson_repository.dart';

/// {@template CSharedGem}
///
/// Represents a gem that has been shared and includes the people that the lines
/// of the gem refer to.
///
/// {@endtemplate}
class CSharedGem extends CGem {
  /// {@macro CSharedGem}
  const CSharedGem({
    required super.id,
    required super.number,
    required super.occurredAt,
    required super.lines,
    required super.chestID,
    required this.people,
  });

  /// {@macro CSharedGem}
  ///
  /// Converts a [CGemsTableRecord] and a list of [CPeopleTableRecord] to a
  /// [CSharedGem].
  factory CSharedGem.fromRecords(
    CGemsTableRecord gemRecord,
    List<CPeopleTableRecord> peopleRecords,
  ) {
    final gem = CGem.fromRecord(gemRecord);
    final people = peopleRecords.map(CPerson.fromRecord).toList();

    return CSharedGem(
      id: gem.id,
      number: gem.number,
      occurredAt: gem.occurredAt,
      lines: gem.lines,
      chestID: gem.chestID,
      people: people,
    );
  }

  /// The people that the lines of the gem refer to.
  final List<CPerson> people;

  @override
  List<Object?> get props => super.props..addAll(people);
}
