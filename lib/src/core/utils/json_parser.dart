class JsonParser {
  static int? parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }

  static String parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static bool parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is int) return value == 1;
    return false;
  }
}
