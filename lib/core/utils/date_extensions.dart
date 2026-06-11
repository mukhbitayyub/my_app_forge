import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get timeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inDays >= 7) return DateFormat.yMMMd().format(this);
    if (difference.inDays >= 1) return '${difference.inDays} days ago';
    if (difference.inHours >= 1) return '${difference.inHours} hours ago';
    if (difference.inMinutes >= 1) return '${difference.inMinutes} minutes ago';
    return 'just now';
  }

  String get formattedDate => DateFormat.yMMMd().format(this);
  String get formattedDateTime =>
      '${DateFormat.yMMMd().format(this)} at ${DateFormat.jm().format(this)}';

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final difference = now.difference(this);
    return difference.inDays < 7 && difference.inDays >= 0;
  }
}
