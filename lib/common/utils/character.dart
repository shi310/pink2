class MyCharacter {
  /// 格式化金额
  static String getMoney(
    double value, {
    int? fixed,
  }) {
    // 把传入的数精确到两位小数点
    List<String> valueStringList = [];

    // 整数部分用来在此计算
    int _value = 0;

    if (fixed == null || fixed == 0) {
      _value = value.toInt();
    } else {
      valueStringList = value.toStringAsFixed(fixed).split('.');
      _value = int.parse(valueStringList[0]);
    }

    // 用来装格式化好的数字
    List<String> _list = [];

    // 把整数部分格式化成 1,234,56 的形式
    while (_value > 1000) {
      if (_value % 1000 < 10) {
        _list.insert(0, '00' + (_value % 1000).toString());
      } else if (_value < 100) {
        _list.insert(0, '0' + (_value % 1000).toString());
      } else {
        _list.insert(0, (_value % 1000).toString());
      }

      _value = _value ~/ 1000;
    }

    // 把第一位放入容器
    _list.insert(0, _value.toString());

    var intResault = getListToString(_list, spacer: ',');

    // 返回完整的结构
    return fixed == null || fixed == 0
        ? intResault
        : intResault + '.' + valueStringList[1];
  }

  /// 数组转字符串
  static String getListToString(List value, {String? spacer}) {
    String _value = '';
    for (int i = 0; i < value.length; i++) {
      if (spacer == null || i == value.length - 1) {
        _value += value[i].toString();
      } else {
        _value += value[i].toString() + spacer;
      }
    }
    return _value;
  }

  /// 取字符串后两位:隐藏手机号码
  static String getLastTwo(String value) {
    if (value.isEmpty) return '';
    return value.substring(value.length - 2);
  }

  /// 隐藏邮箱地址
  static String getEmailHide(String value) {
    if (value.isEmpty) return '';
    List<String> part_1 = value.split('@');
    return getLastTwo(part_1[0]) + '@' + part_1[1];
  }

  /// 字符串去掉空白字符
  static String getClear(String value) {
    return value.replaceAll(RegExp(r"\s+\b|\b\s"), '');
  }
}
