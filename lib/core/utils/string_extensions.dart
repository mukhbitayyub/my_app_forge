extension StringX on String {
  bool get isValidEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  bool get isValidPhone => RegExp(
        r'^\+?[1-9]\d{1,14}$',
      ).hasMatch(this);

  bool get isValidUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => isEmpty
      ? this
      : split(' ').map((str) => str.capitalize).join(' ');

  String? get nullIfEmpty => isEmpty ? null : this;

  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}...';
}
