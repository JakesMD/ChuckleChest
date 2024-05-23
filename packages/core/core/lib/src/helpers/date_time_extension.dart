/// A custom extension on [DateTime] to add useful methods.
extension CDateTimeExtension on DateTime {
  /// Returns the age of the [DateTime] compared to the provided (newer) [date].
  int cAge(DateTime date) {
    var age = date.year - year;

    if (date.month < month || (date.month == month && date.day < day)) {
      age--;
    }
    return age;
  }
}
