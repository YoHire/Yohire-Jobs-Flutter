import 'package:intl/intl.dart';

class DateServices {
  static String dateDifference({
    required DateTime today,
    required DateTime date,
    required String expiryDate,
  }) {
    today = DateTime(today.year, today.month, today.day, today.hour,
        today.minute, today.second);
    date = DateTime(
        date.year, date.month, date.day, date.hour, date.minute, date.second);
    var val = (today.difference(date).inHours).round();

    // Parse expiryDate
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    DateTime expiryDateTime = formatter.parse(expiryDate);
    expiryDateTime = expiryDateTime.add(const Duration(hours: 5, minutes: 30));
    // If the difference is more than 2 days, check expiry
    if (val > 48) {
      final expiryDifference = expiryDateTime.difference(today);

      if (expiryDifference.isNegative) {
        return 'Expired';
      }

      final weeks = expiryDifference.inDays ~/ 7;
      final days = expiryDifference.inDays % 7;
      final hours = expiryDifference.inHours % 24;
      final minutes = expiryDifference.inMinutes % 60;

      if (weeks > 0) {
        return 'Expires in $weeks week${weeks > 1 ? 's' : ''}';
      } else if (days > 0) {
        return 'Expires in $days day${days > 1 ? 's' : ''}';
      } else if (hours > 0) {
        return 'Expires in $hours hour${hours > 1 ? 's' : ''}';
      } else if (minutes > 0) {
        return 'Expires in $minutes minute${minutes > 1 ? 's' : ''}';
      } else {
        return 'Expires in less than a minute';
      }
    }

    // Original logic for differences less than or equal to 2 days
    if (val == 0) {
      if ((today.difference(date).inMinutes) == 0) {
        if ((today.difference(date).inSeconds) <= 10) {
          return 'Posted Just now';
        } else {
          return 'Posted ${(today.difference(date).inSeconds)} Seconds ago';
        }
      }
      if ((today.difference(date).inMinutes) == 1) {
        return 'Posted 1 Minute ago';
      } else {
        return 'Posted ${(today.difference(date).inMinutes)} Minutes ago';
      }
    }
    if (val > 24) {
      if (val ~/ 24 == 1) {
        return 'Posted 1 Day ago';
      } else {
        return 'Posted ${val ~/ 24} Days ago';
      }
    }
    if (val > 168) {
      if (val ~/ 168 == 1) {
        return 'Posted 1 Week ago';
      } else {
        return 'Posted ${val ~/ 168} Weeks ago';
      }
    }
    if (val == 1) {
      return 'Posted 1 Hour ago';
    } else {
      return 'Posted $val Hours ago';
    }
  }

  static String calculateDateDifference(
      String startDateStr, String endDateStr) {
    // Parse the input date strings
    DateTime startDate = DateFormat('yyyy-MM-dd').parse(startDateStr);
    DateTime endDate;

    // Handle the case where the end date is closer to 1900 or invalid
    try {
      endDate = DateFormat('yyyy-MM-dd').parse(endDateStr);
      if (endDate.year < 1900) {
        endDate = DateTime.now();
      }
    } catch (e) {
      endDate = DateTime.now();
    }

    // Calculate the difference between dates
    Duration difference = endDate.difference(startDate);

    // Convert the difference to years, months, days
    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = (difference.inDays % 365) % 30;
    int weeks = days ~/ 7;

    // Build the result string
    String result = '';
    if (years > 0) result += '$years year${years > 1 ? 's' : ''} ';
    if (months > 0) result += '$months month${months > 1 ? 's' : ''} ';
    if (weeks > 0 && years == 0 && months == 0) {
      result += '$weeks week${weeks > 1 ? 's' : ''} ';
    }
    if (days > 0 && weeks == 0 && years == 0 && months == 0) {
      result += '$days day${days > 1 ? 's' : ''}';
    }

    if (result == '') {
      result = 'today';
    }

    // Trim and return the result string
    return result.trim();
  }

  static bool isNotExpired(String dateString) {
    DateTime inputDate = DateTime.parse(dateString);

    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);

    DateTime inputDateWithoutTime =
        DateTime(inputDate.year, inputDate.month, inputDate.day);

    return inputDateWithoutTime.isAtSameMomentAs(today) ||
        inputDateWithoutTime.isAfter(today);
  }

  static String formatDateString(String dateString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Create a DateFormat for the desired format
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    // Format day with appropriate suffix
    String day = '${dateTime.day}${daySuffix(dateTime.day)}';

    // Format month and year
    String month = DateFormat('MMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);

    // Combine day, month, and year
    return '$day $month $year';
  }

  static int calculateAge(String dobString) {
    // Parse the string into a DateTime object
    DateTime dob = DateTime.parse(dobString);

    // Get the current date
    DateTime today = DateTime.now();

    // Calculate the difference in years
    int age = today.year - dob.year;

    // Adjust the age if the birthday hasn't occurred yet this year
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    return age;
  }
}
