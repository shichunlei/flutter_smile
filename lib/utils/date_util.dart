import 'package:flutter/foundation.dart';

/// 输出四位数年份
///
/// Example:
///     formatDate(DateTime(1989), [yyyy]);
///     // => 1989
const String yyyy = 'yyyy';

/// 输出两位数年份
///
/// Example:
///     formatDate(DateTime(1989), [yy]);
///     // => 89
const String yy = 'yy';

/// 输出两位数月份
///
/// Example:
///     formatDate(DateTime(1989, 11), [mm]);
///     // => 11
///     formatDate(DateTime(1989, 5), [mm]);
///     // => 05
const String mm = 'mm';

/// 输出月份（小于10月的前面不补0）
///
/// Example:
///     formatDate(DateTime(1989, 11), [mm]);
///     // => 11
///     formatDate(DateTime(1989, 5), [m]);
///     // => 5
const String m = 'm';

/// 输出英文月份
///
/// Example:
///     formatDate(DateTime(1989, 2), [MM]);
///     // => february
const String MM = 'MM';

/// 输出英文月份（缩写）
///
/// Example:
///     formatDate(DateTime(1989, 2), [M]);
///     // => feb
const String M = 'M';

/// 输出中文月份
///
/// Example:
///     formatDate(DateTime(1989, 2), [MM]);
///     // => 二月
const String MM_ZH = 'MM_ZH';

/// 输出两位数天
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [dd]);
///     // => 21
///     formatDate(DateTime(1989, 2, 5), [dd]);
///     // => 05
const String dd = 'dd';

/// 输出天（小于10月的前面不补0）
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [d]);
///     // => 21
///     formatDate(DateTime(1989, 2, 5), [d]);
///     // => 5
const String d = 'd';

/// 输出该日期所在该月的周数
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [w]);
///     // => 4
const String w = 'w';

/// 输出该日期所在年的周数（两位，小于10的周数前面补0）
///
/// Example:
///     formatDate(DateTime(1989, 12, 31), [W]);
///     // => 53
///     formatDate(DateTime(1989, 2, 21), [W]);
///     // => 08
const String WW = 'WW';

/// 输出该日期所在年的周数
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [W]);
///     // => 8
const String W = 'W';

/// Outputs week day as long name
///
/// Example:
///     formatDate(DateTime(2018, 1, 14), [DD]);
///     // => sunday
const String EEEE_EN = 'EEEE_EN';

/// Outputs week day as long name
///
/// Example:
///     formatDate(DateTime(2018, 1, 14), [D]);
///     // => sun
const String EE_EN = 'EE_EN';

/// Outputs week day as long name
///
/// Example:
///     formatDate(DateTime(2018, 1, 14), [DD]);
///     // => 星期日
const String EEEE_ZH = 'EEEE_ZH';

/// Outputs week day as long name
///
/// Example:
///     formatDate(DateTime(2018, 1, 14), [D]);
///     // => 周日
const String EE_ZH = 'EE_ZH';

/// Outputs hour (0 - 11) as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15), [hh]);
///     // => 03
const String hh = 'hh';

/// Outputs hour (0 - 11) compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15), [h]);
///     // => 3
const String h = 'h';

/// Outputs hour (0 to 23) as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15), [HH]);
///     // => 15
const String HH = 'HH';

/// Outputs hour (0 to 23) compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 5), [H]);
///     // => 5
const String H = 'H';

/// Outputs minute as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40), [nn]);
///     // => 40
///     formatDate(DateTime(1989, 02, 1, 15, 4), [nn]);
///     // => 04
const String nn = 'nn';

/// Outputs minute compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 4), [n]);
///     // => 4
const String n = 'n';

/// Outputs second as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10), [ss]);
///     // => 10
///     formatDate(DateTime(1989, 02, 1, 15, 40, 5), [ss]);
///     // => 05
const String ss = 'ss';

/// Outputs second compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 5), [s]);
///     // => 5
const String s = 's';

/// Outputs millisecond as three digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 999), [SSS]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 99), [SS]);
///     // => 099
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0), [SS]);
///     // => 009
const String SSS = 'SSS';

/// Outputs millisecond compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 999), [SSS]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 99), [SS]);
///     // => 99
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 9), [SS]);
///     // => 9
const String SS = 'S';

/// Outputs microsecond as three digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 999), [uuu]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 99), [uuu]);
///     // => 099
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 9), [uuu]);
///     // => 009
const String uuu = 'uuu';

/// Outputs millisecond compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 999), [u]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 99), [u]);
///     // => 99
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 9), [u]);
///     // => 9
const String u = 'u';

/// 输出所在时间为 AM or PM
///
/// Example:
///     print(formatDate(DateTime(1989, 02, 1, 5), [am]));
///     // => AM
///     print(formatDate(DateTime(1989, 02, 1, 15), [am]));
///     // => PM
const String am = 'am';

/// 输出上午/下午
///
/// Example:
///     print(formatDate(DateTime(1989, 02, 1, 5), [am]));
///     // => 上午
///     print(formatDate(DateTime(1989, 02, 1, 15), [am]));
///     // => 下午
const String am_ZH = 'am_ZH';

/// Outputs timezone as time offset
///
/// Example:
///
const String z = 'z';
const String Z = 'Z';

const List<String> monthShort = const <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

const List<String> monthLong = const <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

const List<String> monthZH = const <String>[
  '正月',
  '二月',
  '三月',
  '四月',
  '五月',
  '六月',
  '七月',
  '八月',
  '九月',
  '十月',
  '冬月',
  '腊月'
];

const List<String> weekdaysShort = const [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun'
];

const List<String> weekdaysLong = const [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const List<String> weekdaysShortZH = const [
  '周一',
  '周二',
  '周三',
  '周四',
  '周五',
  '周六',
  '周日'
];

const List<String> weekdaysLongZH = const [
  '星期一',
  '星期二',
  '星期三',
  '星期四',
  '星期五',
  '星期六',
  '星期日'
];

const int MILLISECONDS = 24 * 60 * 60 * 1000;

class DateUtils {
  DateUtils();

  static String formatDateByMs(int microseconds, {List<String> formats}) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(microseconds),
        formats: formats);
  }

  static String formatDateByStr(String datetimeStr, {List<String> formats}) {
    return formatDate(DateTime.parse(datetimeStr), formats: formats);
  }

  static String formatDate(DateTime date, {List<String> formats}) {
    final sb = StringBuffer();
    if (null == formats) {
      formats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss];
    }
    for (String format in formats) {
      if (format == yyyy) {
        sb.write(_digits(date.year, 4));
      } else if (format == yy) {
        sb.write(_digits(date.year % 100, 2));
      } else if (format == mm) {
        sb.write(_digits(date.month, 2));
      } else if (format == m) {
        sb.write(date.month);
      } else if (format == MM) {
        sb.write(monthLong[date.month - 1]);
      } else if (format == MM_ZH) {
        sb.write(monthZH[date.month - 1]);
      } else if (format == M) {
        sb.write(monthShort[date.month - 1]);
      } else if (format == dd) {
        sb.write(_digits(date.day, 2));
      } else if (format == d) {
        sb.write(date.day);
      } else if (format == w) {
        sb.write((date.day + 7) ~/ 7);
      } else if (format == W) {
        sb.write((dayInYear(date) + 7) ~/ 7);
      } else if (format == WW) {
        sb.write(_digits((dayInYear(date) + 7) ~/ 7, 2));
      } else if (format == EEEE_EN) {
        sb.write(weekdaysLong[date.weekday - 1]);
      } else if (format == EE_EN) {
        sb.write(weekdaysShort[date.weekday - 1]);
      } else if (format == EEEE_ZH) {
        sb.write(weekdaysLongZH[date.weekday - 1]);
      } else if (format == EE_ZH) {
        sb.write(weekdaysShortZH[date.weekday - 1]);
      } else if (format == HH) {
        sb.write(_digits(date.hour, 2));
      } else if (format == H) {
        sb.write(date.hour);
      } else if (format == hh) {
        int hour = date.hour % 12;
        if (hour == 0) hour = 12;
        sb.write(_digits(hour, 2));
      } else if (format == h) {
        int hour = date.hour % 12;
        if (hour == 0) hour = 12;
        sb.write(hour);
      } else if (format == am) {
        sb.write(date.hour < 12 ? 'AM' : 'PM');
      } else if (format == am_ZH) {
        sb.write(date.hour < 12 ? '上午' : '下午');
      } else if (format == nn) {
        sb.write(_digits(date.minute, 2));
      } else if (format == n) {
        sb.write(date.minute);
      } else if (format == ss) {
        sb.write(_digits(date.second, 2));
      } else if (format == s) {
        sb.write(date.second);
      } else if (format == SSS) {
        sb.write(_digits(date.millisecond, 3));
      } else if (format == SS) {
        sb.write(date.second);
      } else if (format == uuu) {
        sb.write(_digits(date.microsecond, 2));
      } else if (format == u) {
        sb.write(date.microsecond);
      } else if (format == z) {
        if (date.timeZoneOffset.inMinutes == 0) {
          sb.write('Z');
        } else {
          if (date.timeZoneOffset.isNegative) {
            sb.write('-');
            sb.write(_digits((-date.timeZoneOffset.inHours) % 24, 2));
            sb.write(_digits((-date.timeZoneOffset.inMinutes) % 60, 2));
          } else {
            sb.write('+');
            sb.write(_digits(date.timeZoneOffset.inHours % 24, 2));
            sb.write(_digits(date.timeZoneOffset.inMinutes % 60, 2));
          }
        }
      } else if (format == Z) {
        sb.write(date.timeZoneName);
      } else {
        sb.write(format);
      }
    }

    return sb.toString();
  }

  static int dayInYear(DateTime date) =>
      date.difference(DateTime(date.year, 1, 1)).inDays;

  static String _digits(int value, int length) {
    String ret = '$value';
    if (ret.length < length) {
      ret = '0' * (length - ret.length) + ret;
    }
    return ret;
  }

  static String today({List<String> formats}) {
    if (null == formats) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    String today = formatDate(DateTime.now(), formats: formats);

    return today;
  }

  static bool isToday(String dateStr, {List<String> formats}) {
    if (null == formats) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    DateTime dateTime = DateTime.parse(dateStr);
    String date = formatDate(dateTime, formats: formats);

    debugPrint(date);

    return date == today(formats: formats);
  }

  /// 判断某日期是否为闰年
  ///
  static bool isLeapYear({String dateStr}) {
    int _year = DateTime.now().year;
    if (dateStr == null) {
      _year = DateTime.parse(dateStr)?.year;
      if (_year == null) {
        _year = DateTime.now().year;
      }
    }
    return (_year % 4 == 0 && _year % 100 != 0) || _year % 400 == 0;
  }

  /// 求给定日期所在周的周一的日期
  static String monday({String dateStr, List<String> formats}) {
    String monday = '';

    if (formats == null) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    int weekday = dateTime.weekday - 1;

    print("========$weekday");

    int microseconds = weekday * MILLISECONDS;

    monday = formatDateByMs(dateTime.millisecondsSinceEpoch - microseconds,
        formats: formats);

    return monday;
  }

  static String sunday({String dateStr, List<String> formats}) {
    String sunday = '';

    if (formats == null) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    int weekday = dateTime.weekday;

    print("========$weekday");

    int microseconds = (7 - weekday) * MILLISECONDS;

    sunday = formatDateByMs(dateTime.millisecondsSinceEpoch + microseconds,
        formats: formats);

    return sunday;
  }

  /// 求给定日期所在月第一天的日期
  ///
  static String firstDayOfMonth({String dateStr, List<String> formats}) {
    String day = '';

    if (formats == null) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    day = formatDate(DateTime(dateTime.year, dateTime.month), formats: formats);

    return day;
  }

  /// 得到给定日期所在月份天数
  ///
  static int daysOfMouth(String dateStr) {
    List<int> monthDays = [
      31,
      isLeapYear(dateStr: dateStr) ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];

    return monthDays[DateTime.parse(dateStr).month - 1];
  }

  /// 返回两个日期相差的天数
  ///
  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ MILLISECONDS -
          b.millisecondsSinceEpoch ~/ MILLISECONDS;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      if (v < 0) v = -v;
      return v ~/ MILLISECONDS;
    }
  }

  static List<String> weekdays(String dateStr, {List<String> formats}) {
    List<String> weekdays = [];

    if (formats == null) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    int weekday = dateTime.weekday;

    debugPrint("============> $weekday");

    if (weekday == 7) {
      weekday = 0;
    }

    for (int i = 0; i < DateTime.daysPerWeek; i++) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          dateTime.millisecondsSinceEpoch + (i - weekday) * MILLISECONDS);

      weekdays.add(formatDate(date, formats: formats));
    }

    debugPrint(weekdays.toString());

    return weekdays;
  }

  static List<String> monthDays(String dateStr, {List<String> formats}) {
    List<String> monthDays = [];

    if (formats == null) {
      formats = [yyyy, '-', mm, '-', dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    int day = dateTime.day;

    int days = daysOfMouth(dateStr);

    debugPrint("$days");

    for (int i = 1; i <= days; i++) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          dateTime.millisecondsSinceEpoch + (i - day) * MILLISECONDS);

      monthDays.add(formatDate(date, formats: formats));
    }

    debugPrint(monthDays.toString());

    return monthDays;
  }

  static String nextMonth(String dateStr, {List<String> formats}) {
    if (formats == null) {
      formats = [yyyy, '-', mm, "-", dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    int month = dateTime.month;
    int year = dateTime.year;

    if (month == 12) {
      year += 1;
      month = 1;
    } else {
      month += 1;
    }

    return formatDate(DateTime(year, month), formats: formats);
  }

  static String prevMonth(String dateStr, {List<String> formats}) {
    if (formats == null) {
      formats = [yyyy, '-', mm, "-", dd];
    }

    DateTime dateTime;
    if (dateStr == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateStr);
    }

    int month = dateTime.month;
    int year = dateTime.year;

    if (month == 1) {
      year -= 1;
      month = 12;
    } else {
      month -= 1;
    }

    return formatDate(DateTime(year, month), formats: formats);
  }
}
