/// Represents an exception that occurs when fetching a gem fails.
enum CGemFetchException {
  /// The gem was not found.
  notFound,

  /// The failure was unitentifiable.
  unknown,
}
