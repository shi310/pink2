class MyTimer {
  /// 时间戳转时间
  static String getDate(int value) {
    var valueToString = value.toString();
    late int timeValue;

    if (valueToString.length < 13) {
      var length = 13 - valueToString.length;
      for (int i = 0; i < length; i++) {
        valueToString += '0';
      }
      timeValue = int.parse(valueToString);
    } else if (valueToString.length > 13) {
      timeValue = value ~/ 1000;
    } else {
      timeValue = value;
    }

    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeValue);
    DateTime now = DateTime.now();
    Duration cha = now.difference(time);

    String month = time.month < 10 ? '0${time.month}' : '${time.month}';
    String day = time.day < 10 ? '0${time.day}' : '${time.day}';

    if (cha.inDays > 365) {
      return '${time.year}-$month-$day';
    } else if (cha.inDays > 30) {
      return '${cha.inDays ~/ 30} 月前';
    } else if (cha.inHours > 72) {
      return '${cha.inDays} 天前';
    } else if (cha.inHours > 48) {
      return '前天';
    } else if (cha.inHours > 24) {
      return '昨天';
    } else if (cha.inMinutes > 60) {
      return '${cha.inHours} 小时前';
    } else if (cha.inMinutes > 5) {
      return '${cha.inMinutes} 分钟前';
    } else {
      return '刚刚';
    }
  }

  /// 时间格式化
  /// 把秒数转成：00:00:00的格式
  static String getDuration(int value) {
    // 初始化
    // 首先默认所有的时间都是 0
    int minute = 0;
    int second = 0;
    int hour = 0;

    // 第一步是看分钟的数量
    minute = value ~/ 60;
    second = value % 60;
    String secondString = second < 10 ? '0$second' : '$second';

    if (minute < 10) {
      return '0$minute:$secondString';
    } else if (minute < 60) {
      return '$minute:$secondString';
    } else {
      hour = minute ~/ 60;
      minute = minute % 60;
      String hourString = hour < 10 ? '0$hour' : '$hour';
      String minuteString = minute < 10 ? '0$minute' : '$minute';
      return '$hourString:$minuteString:$secondString';
    }
  }

  /// 等待
  static Future<dynamic> futureMill(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
