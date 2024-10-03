class DateUtils {
  static String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  static bool isFutureDate(DateTime date) {
    return date.isAfter(DateTime.now());
  }
}