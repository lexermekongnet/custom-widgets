import 'package:intl/intl.dart';

import 'date_time_extension.dart';

const _fullDate = 'MMMM dd, yyyy';
const _fullDateHourMinute = 'MMMM dd, yyyy hh:mm a';
const _dashDate = 'yyyy-MM-dd';

/// An extension method for String function with time related result
extension DateFormatString on String {
  /// Return a [String] formatted with 'hh:mm a'
  String toFullDate() {
    try {
      DateTime time = DateTime.parse(this);
      return time.toFullDate();
    } catch (e) {
      // sanity check
      return '';
    }
  }

  /// Return a [String] formatted with 'MMMM dd, yyyy'
  String toFullDateHourMinute() {
    try {
      DateTime time = DateTime.parse(this);
      return time.toFullDateHourMinute();
    } catch (e) {
      // sanity check
      return '';
    }
  }

  /// Return a [String] formatted with 'MMMM dd, yyyy'
  String toAgoTime() {
    try {
      DateTime time = DateTime.parse(this);
      return time.toAgoTime();
    } catch (e) {
      // sanity check
      return '';
    }
  }

  /// Return a [String] formatted with 'MMMM dd, yyyy'
  String toHourMinute() {
    try {
      DateTime time = DateTime.parse(this);
      return time.toHourMinute();
    } catch (e) {
      // sanity check
      return '';
    }
  }

  /// Return a [DateTime]
  DateTime? fullDateToDateTime() {
    try {
      // Define the date format you want to parse
      DateFormat dateFormat = DateFormat(_fullDate);
      // Parse the string into a DateTime object
      return dateFormat.parse(this);
    } catch (e) {
      // sanity check
      return null;
    }
  }

  /// Return a [DateTime]
  DateTime? fullDateHourMinuteToDateTime() {
    try {
      // Define the date format you want to parse
      DateFormat dateFormat = DateFormat(_fullDateHourMinute);
      // Parse the string into a DateTime object
      return dateFormat.parse(this);
    } catch (e) {
      // sanity check
      return null;
    }
  }

  /// Return a [DateTime]
  DateTime? dashedDateToDateTime() {
    try {
      // Define the date format you want to parse
      DateFormat dateFormat = DateFormat(_dashDate);
      // Parse the string into a DateTime object
      return dateFormat.parse(this);
    } catch (e) {
      // sanity check
      return null;
    }
  }
}

/// An extension function to check whether [String] is valid [TicketModel]
extension StringTimeDifference on String? {
  /// Returns `true` if String is valid [TicketModel]
  String? calculateDifferenceBetween(String? otherTime) {
    try {
      if (this == null || otherTime == null) return null;
      DateTime? thisDate = DateTime.tryParse(this!);
      DateTime? otherDate = DateTime.tryParse(otherTime);
      if (thisDate == null || otherDate == null) return null;
      final duration = otherDate.difference(thisDate);
      final elapseInHours = duration.inHours.toString().padLeft(2, '0');
      final elapseInMinutes = (duration.inMinutes % 60).toString().padLeft(
        2,
        '0',
      );
      final stopWatchSeconds =
          duration.inSeconds.isNegative ? 0 : duration.inSeconds;
      final elapseInSeconds = (stopWatchSeconds % 60).toString().padLeft(
        2,
        '0',
      );
      return '$elapseInHours:$elapseInMinutes:$elapseInSeconds';
    } catch (e) {
      return null;
    }
  }
}
