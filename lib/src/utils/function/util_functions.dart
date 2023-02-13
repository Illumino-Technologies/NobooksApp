import 'package:nobook/src/utils/utils_barrel.dart';
import 'package:flutter/material.dart';

abstract class UtilFunctions {
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

  static String formatDate(
    DateTime date, {
    String separator = ' / ',
  }) {
    return '${date.day.toString().padLeft(2, '0')}$separator${date.month.toString().padLeft(2, '0')}$separator${date.year}';
  }

  static String formatMinutesDuration(Duration duration) {
    final int inSeconds = duration.inSeconds;
    final int seconds = inSeconds % 60;
    final int minutes = inSeconds ~/ 60;

    return '${'$minutes'.padLeft(2, '0')}:${'$seconds'.padLeft(2, '0')}';
  }

  static String? phoneNumberBodyFrom(String phoneNumber) {
    phoneNumber = phoneNumber.removeAllSpaces;
    String phoneNumberBody = phoneNumber.length > 10
        ? phoneNumber.substring((phoneNumber.length - 10), phoneNumber.length)
        : '';
    if (phoneNumberBody.trim().isEmpty) return null;

    final List<String> chars = phoneNumberBody.chars
      ..insert(3, ' ')
      ..insert(8, ' ');
    phoneNumberBody = chars.join();

    return phoneNumberBody.trim().nullIfEmpty;
  }

  static ThemeMode themeModeFromName(String name) {
    name = name.trim();
    assert(
      ThemeMode.values.containsWhere((value) => value.name != name),
      'name: $name is not a ThemeMode',
    );
    return ThemeMode.values.firstWhere((element) => element.name == name);
  }
}
