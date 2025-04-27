import 'package:arth_ai/utils/constants.dart';

class Helper {
  /// Formats a datetime string into a human-readable relative time format.
  ///
  /// This function converts a datetime string into a relative time format based on
  /// how long ago the time occurred:
  /// - Less than an hour: returns minutes (e.g., "30 m")
  /// - Same day but more than an hour: returns hours (e.g., "5 h")
  /// - Within a week: returns days (e.g., "3 d")
  /// - Older than a week: returns formatted date (e.g., "Jan 15, 2023")
  ///
  /// [input] The datetime string in a format parsable by [DateTime.parse].
  ///
  /// Returns a formatted string representing the relative time or date.
  static String formatDateTime(String input) {
    final dateTime = DateTime.parse(input).toLocal();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} m';
    } else if (isSameDay(now, dateTime)) {
      return '${difference.inHours} h';
    } else if (difference.inDays <= 7) {
      return '${difference.inDays} d';
    } else {
      final month = _monthAbbreviation(dateTime.month);
      return '$month ${dateTime.day}, ${dateTime.year}';
    }
  }

  /// Checks if two DateTime objects represent the same calendar day.
  ///
  /// [d1] The first DateTime object to compare.
  /// [d2] The second DateTime object to compare.
  ///
  /// Returns true if both dates fall on the same year, month, and day.
  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.difference(d2).inHours < 24;
  }

  /// Converts a month number to its three-letter abbreviation.
  ///
  /// [month] An integer representing the month (1-12).
  ///
  /// Returns the three-letter abbreviation of the month (e.g., "Jan" for 1).
  static String _monthAbbreviation(int month) {
    const months = [
      Constants.jan,
      Constants.feb,
      Constants.mar,
      Constants.apr,
      Constants.may,
      Constants.jun,
      Constants.jul,
      Constants.aug,
      Constants.sep,
      Constants.oct,
      Constants.nov,
      Constants.dec,
    ];
    return months[month - 1];
  }

  /// Validates if the provided URL is in a correct format.
  ///
  /// [url] The URL string to validate.
  ///
  /// Returns true if the URL is valid, false otherwise.
  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) {
      return false;
    }
    final Uri? uri = Uri.tryParse(url);
    return uri != null &&
        (uri.isScheme(Constants.http) || uri.isScheme(Constants.https));
  }

  /// Validates if the search query contains only alphanumeric characters.
  ///
  /// [query] The search query string to validate.
  ///
  /// Returns true if the query is valid, false otherwise.
  static bool isValidSearchQuery(String query) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9\s]+$');
    return regex.hasMatch(query);
  }
}
