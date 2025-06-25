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
    required super.shareToken,
    required this.people,
  });

  /// {@macro CSharedGem}
  ///
  /// Converts a [CRawGem] and a list of [CRawPerson]s to a [CSharedGem].
  factory CSharedGem.fromRaw(
    CRawGem rawGem,
    List<CRawPerson> rawPeople,
  ) {
    final gem = CGem.fromRaw(rawGem);
    final people = rawPeople.map(CPerson.fromRaw).toList();

    return CSharedGem(
      id: gem.id,
      number: gem.number,
      occurredAt: gem.occurredAt,
      lines: gem.lines,
      chestID: gem.chestID,
      shareToken: gem.shareToken,
      people: people,
    );
  }

  /// The people that the lines of the gem refer to.
  final List<CPerson> people;

  @override
  List<Object?> get props => super.props..addAll(people);
}
