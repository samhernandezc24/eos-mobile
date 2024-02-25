class StyleStringsUtils {
  /// toCapitalized
  static String toCapitalized(String? string) {
    if (string == null || string.isEmpty) {
      return '';
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  /// toProperCase
  static String toProperCase(String? sentence) {
    if (sentence == null) {
      return '';
    }

    final words = sentence.split(' ');
    var result = '';

    for (final word in words) {
      final lower = word.toLowerCase();
      if (lower.isNotEmpty) {
        final proper = '${lower.substring(0, 1).toUpperCase()}${lower.substring(1)}';
        result = result.isEmpty ? proper : '$result $proper';
      }
    }
    return result;
  }
}
