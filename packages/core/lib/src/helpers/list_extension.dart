/// A custom extension on [List] to add useful methods.
extension CListExtention<T> on List<T> {
  /// Returns the first element that satisfies the given predicate [test] or
  /// `null` if there are no elements that satisfy the predicate.
  T? cFirstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
