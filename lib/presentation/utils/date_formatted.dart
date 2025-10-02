import 'package:intl/intl.dart';

final date = DateFormat('d MMM yyyy');
final dateHours = DateFormat('d MMM yyyy hh:mm');
final dateRange = DateFormat('yyyy-MM-dd');

String formatDate(DateTime? value) {
  if (value == null || value == DateTime(0001)) {
    return '';
  } else {
    return date.format(value);
  }
}

String formatDateYYYYMMdd(DateTime? value) {
  if (value != null) {
    return dateRange.format(value);
  } else {
    return "";
  }
}

String formatRangeDate(DateTime start, DateTime end) {
  return '${dateRange.format(start)} to ${dateRange.format(end)}';
}

String formatDateWithHours(DateTime value) {
  return dateHours.format(value);
}

String formatMoney(num number) {
  final formatter = NumberFormat.decimalPattern();
  return formatter.format(number);
}

String formatMoneyWithComma(num number) {
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(number);
}

String padWithLeadingZero(int num) {
  if (num == 0) {
    return "00";
  }
  String numStr = num.toString();
  return numStr.length < 2 ? numStr.padLeft(2, '0') : numStr;
}

String formatDateTimeString(String? dateTimeString) {
  if (dateTimeString == null || dateTimeString.trim().isEmpty) {
    return '';
  }

  try {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String datePart = dateTime.toIso8601String().substring(0, 10);

    String timePart =
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';

    return '$datePart | $timePart';
  } catch (e) {
    return dateTimeString;
  }
}
