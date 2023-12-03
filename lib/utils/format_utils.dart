import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatUtils {
  static String formatTimeOfDay(TimeOfDay? t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t!.hour, t.minute);
    return DateFormat("HH:mm").format(dt);
  }

  static String formatDateAndTime(DateTime eventDate, TimeOfDay eventTime) {
    DateTime eventDateFormated = DateFormat("yyyy-MM-dd hh:mm")
        .parse("$eventDate ${formatTimeOfDay(eventTime)}");
    return DateFormat("yyyy-MM-ddThh:mm:ss").format(eventDateFormated);
  }
}
