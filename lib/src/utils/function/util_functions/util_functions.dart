import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/base/controller/base_controller.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class UtilFunctions {
  static NoteDocument noteDocumentFromList(List data) {
    final NoteDocument document = [];
    for (final Map noteData in data) {
      document.add(DocumentEditingController.fromMap(noteData.cast()));
    }
    return document;
  }

  static DoubleRange doubleRangeFromList(List<double> list) {
    return (val1: list[0], val2: list[1]);
  }

  static Color colorFromMap(dynamic map) {
    return Color(int.parse(map['color'].toString()));
  }

  static TimeOfDay timeOfDayFromMap(dynamic map) {
    return TimeOfDay(
      hour: int.parse(map['hour'].toString()),
      minute: int.parse(map['minute'].toString()),
    );
  }

  static Duration simpleDurationFromString(String string) {
    final List<String> parts = string.split(':');
    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2]),
    );
  }

  static Color interpolateColors(double value, List<Color> colors) {
    assert(value >= 0 || value <= 1, 'value must be between 0 and 1');

    final int colorListLength = colors.length - 1;

    final int maxExpectedIndex = (colorListLength * value).ceil();
    final int minExpectedIndex = (colorListLength * value).floor();

    final Color minColor = colors[minExpectedIndex];
    final Color maxColor = colors[maxExpectedIndex];

    return Color.lerp(minColor, maxColor, value)!;
  }

  static PointDouble pointDoubleFromMap(Map<String, dynamic> map) {
    return PointDouble(
      (map['x'] as num).toDouble(),
      (map['y'] as num).toDouble(),
    );
  }

  static double extrapolateColors(Color value, List<Color> colors) {
    int difference = 100000000;
    int colorIndex = 0;

    for (final Color color in colors) {
      final int temp = (color.value - value.value).abs();
      if (temp < difference) {
        difference = temp;
        colorIndex = colors.indexOf(color);
      }
    }

    return colorIndex / (colors.length - 1);
  }

  static DateTime? dateTimeFromMap(
    dynamic data, {
    bool mustReturnData = false,
    DateTime? fallBack,
  }) {
    final DateTime fallbackDateTime =
        fallBack ?? DateTime.now().copySubtract(hour: 1).toLocal();

    if (data == null || data is! String) {
      return mustReturnData ? fallbackDateTime : null;
    }
    return (DateTime.tryParse(data) ?? fallbackDateTime).toLocal();
  }

  static String formatDateAndTime(DateTime dateTime) {
    final String time =
        intl.DateFormat.jm().format(dateTime).toLowerCase().removeAllSpaces;
    final String dateDay =
        intl.DateFormat.d().format(dateTime).withNumberOrdinal;
    final String dateMY = intl.DateFormat.yMMMM().format(dateTime);
    return '$time, $dateDay $dateMY';
  }

  static String formatLongDate(
    DateTime date, [
    String monthSeparator = ' ',
  ]) {
    final String dateDay = intl.DateFormat.d().format(date).withNumberOrdinal;
    final String month = intl.DateFormat.MMMM().format(date);
    final String year = intl.DateFormat.y().format(date);
    return '$dateDay $month$monthSeparator$year';
  }

  static String formatDate(
    DateTime date, {
    String separator = ' / ',
  }) {
    return '${date.day.toString().padLeft(2, '0')}$separator${date.month.toString().padLeft(2, '0')}$separator${date.year}';
  }

  static String formatMinutesDuration(Duration duration) {
    final int inSeconds = duration.inSeconds;
    final int seconds = inSeconds % 60;
    final int hour = inSeconds ~/ 3600;
    final int minutes = inSeconds ~/ 60;

    return '${'$hour'.padLeft(2, '0')}:'
        '${'$minutes'.padLeft(2, '0')}:'
        '${'$seconds'.padLeft(2, '0')}';
  }

  static String? phoneNumberBodyFrom(String phoneNumber) {
    phoneNumber = phoneNumber.removeAllSpaces;
    String phoneNumberBody = phoneNumber.length > 10
        ? phoneNumber.substring((phoneNumber.length - 10), phoneNumber.length)
        : '';
    if (phoneNumberBody.trim().isEmpty) return null;

    final List<String> chars = phoneNumberBody.chars
      ..insert(3, ' ')
      ..insert(
        8,
        ' ',
      );
    phoneNumberBody = chars.join();

    return phoneNumberBody.trim().nullIfEmpty;
  }

  static String formatTime(
    DateTime time, [
    bool addMeridian = true,
  ]) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    final String meridian = addMeridian
        ? time.hour < 12
            ? 'am'
            : 'pm'
        : '';
    return '$hour:$minute$meridian';
  }

  static ThemeMode themeModeFromName(String name) {
    name = name.trim();
    assert(
      ThemeMode.values.containsWhere((value) => value.name != name),
      'name: $name is not a ThemeMode',
    );
    return ThemeMode.values.firstWhere((element) => element.name == name);
  }

  static bool listEqual(List list1, List list2) {
    if (list1.length != list2.length) return false;
    final int listLength = list1.length;
    for (int i = 0; i < listLength; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
