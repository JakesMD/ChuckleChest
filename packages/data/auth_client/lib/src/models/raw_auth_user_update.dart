/// {@template CRawAuthUserUpdate}
///
/// The minimum raw data required for updating a user in the data store.
///
/// {@endtemplate}
class CRawAuthUserUpdate {
  /// {@macro CRawAuthUserUpdate}
  const CRawAuthUserUpdate({required this.username});

  /// The new username of the user.
  final String? username;

  /// Converts the raw data to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      if (username != null) 'username': username,
    };
  }
}
