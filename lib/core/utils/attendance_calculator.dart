import 'package:intl/intl.dart';

class AttendanceCalculator {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _timeFormat = DateFormat('HH:mm');

  static String formatBusinessDate(DateTime dateTime) {
    return _dateFormat.format(dateTime.toLocal());
  }

  static String formatTime(DateTime dateTime) {
    return _timeFormat.format(dateTime.toLocal());
  }

  static String formatTimeFromMillis(int millis) {
    final dt = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true).toLocal();
    return _timeFormat.format(dt);
  }

  static bool isLate(DateTime checkInTime, String? scheduledStartTime) {
    if (scheduledStartTime == null || scheduledStartTime.isEmpty) {
      return false;
    }
    final parts = scheduledStartTime.split(':');
    if (parts.length < 2) return false;

    final hour = int.tryParse(parts[0]) ?? 8;
    final minute = int.tryParse(parts[1]) ?? 0;

    final localCheckIn = checkInTime.toLocal();
    final scheduledDate = DateTime(
      localCheckIn.year,
      localCheckIn.month,
      localCheckIn.day,
      hour,
      minute,
    );

    return localCheckIn.isAfter(scheduledDate);
  }

  static Duration calculateWorkingDuration({
    required DateTime checkIn,
    DateTime? checkOut,
    String? breakStartStr,
    String? breakEndStr,
  }) {
    final localCheckIn = checkIn.toLocal();
    final localEnd = (checkOut ?? DateTime.now()).toLocal();

    if (localEnd.isBefore(localCheckIn)) {
      return Duration.zero;
    }

    var totalDuration = localEnd.difference(localCheckIn);

    // Calculate overlapping break duration if applicable
    if (breakStartStr != null && breakEndStr != null) {
      final breakStartParts = breakStartStr.split(':');
      final breakEndParts = breakEndStr.split(':');

      if (breakStartParts.length >= 2 && breakEndParts.length >= 2) {
        final bStart = DateTime(
          localCheckIn.year,
          localCheckIn.month,
          localCheckIn.day,
          int.tryParse(breakStartParts[0]) ?? 12,
          int.tryParse(breakStartParts[1]) ?? 0,
        );
        final bEnd = DateTime(
          localCheckIn.year,
          localCheckIn.month,
          localCheckIn.day,
          int.tryParse(breakEndParts[0]) ?? 13,
          int.tryParse(breakEndParts[1]) ?? 0,
        );

        // Calculate overlap of [localCheckIn, localEnd] with [bStart, bEnd]
        final overlapStart = localCheckIn.isAfter(bStart) ? localCheckIn : bStart;
        final overlapEnd = localEnd.isBefore(bEnd) ? localEnd : bEnd;

        if (overlapEnd.isAfter(overlapStart)) {
          final overlap = overlapEnd.difference(overlapStart);
          totalDuration = totalDuration - overlap;
        }
      }
    }

    return totalDuration.isNegative ? Duration.zero : totalDuration;
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}
