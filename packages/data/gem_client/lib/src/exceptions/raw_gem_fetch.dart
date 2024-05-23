/// Represents an exception that occurs when fetching gem data fails.
enum CRawGemFetchException {
  /// A gem with the provided ID was not found.
  notFound,

  /// The failure was unitentifiable.
  unknown,
}
