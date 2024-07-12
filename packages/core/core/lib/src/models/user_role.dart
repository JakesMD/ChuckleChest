/// Represents a user's role in a chest.
enum CUserRole {
  /// The owner of the chest.
  owner,

  /// A collaborator in the chest.
  collaborator,

  /// A viewer in the chest.
  viewer;

  /// Parses a string into a [CUserRole].
  static CUserRole parse(String role) {
    switch (role) {
      case 'owner':
        return CUserRole.owner;
      case 'collaborator':
        return CUserRole.collaborator;
      default:
        return CUserRole.viewer;
    }
  }
}
