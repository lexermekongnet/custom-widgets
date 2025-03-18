import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

const _fullDate = 'MMMM dd, yyyy';
const _slashDate = 'MM/dd/yy';
const _dashDate = 'yyyy-MM-dd';
const _fullDateHourMinute = 'MMMM dd, yyyy hh:mm a';
const _hourMinute = 'hh:mm a';

/// An extension method for [DateTime] functions with [String] result
extension DateTimeFormat on DateTime {
  /// Returns a formatted [String] with [_fullDate]
  String toFullDate() {
    try {
      final formatter = DateFormat(_fullDate);
      return formatter.format(toLocal());
    } catch (e) {
      // Sanity Check
      return '';
    }
  }

  /// Returns a formatted [String] with [_slashDate]
  String toSlashedDate() {
    try {
      final formatter = DateFormat(_slashDate);
      return formatter.format(toLocal());
    } catch (e) {
      // Sanity Check
      return '';
    }
  }

  /// Returns a formatted [String] with [_dashDate]
  String toDashedDate() {
    try {
      final formatter = DateFormat(_dashDate);
      return formatter.format(toLocal());
    } catch (e) {
      // Sanity Check
      return '';
    }
  }

  /// Returns a formatted [String] with [_slashDate]
  String toHourMinute() {
    try {
      final formatter = DateFormat(_hourMinute);
      return formatter.format(toLocal());
    } catch (e) {
      // Sanity Check
      return '';
    }
  }

  /// Returns a formatted [String] with [_fullDateHourMinute]
  String toFullDateHourMinute() {
    try {
      final formatter = DateFormat(_fullDateHourMinute);
      return formatter.format(toLocal());
    } catch (e) {
      // Sanity Check
      return '';
    }
  }

  /// Returns a formatted [String] with ago format
  String toAgoTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Return todays date
  DateTime date() => DateTime(year, month, day);
}

/// An extension method with real time from NTP
Future<DateTime> currentDate() async {
  try {
    return NTP.now();
  } catch (e) {
    return DateTime.now();
  }
}
