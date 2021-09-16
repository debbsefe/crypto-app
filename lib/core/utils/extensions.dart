extension StringExtensions on String {
  ///extension method capitalize the first letter of a sentence
  String? get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}
