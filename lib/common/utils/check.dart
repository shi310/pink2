class MyCheck {
  /// 检查密码长度,是否符合指定要求
  static bool isLength(String? input, int length) {
    if (input == null || input.isEmpty) return false;
    return input.length >= length;
  }

  /// 手机号验证
  static bool isChinaPhone(String str) {
    return RegExp(
            r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }

  /// 纯数字验证
  static bool isNumber(String str) {
    return RegExp(r"^\d{8}$").hasMatch(str);
  }

  /// 邮箱验证
  static bool isEmail(String str) {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(str);
  }

  /// 验证URL
  static bool isUrl(String value) {
    return RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+").hasMatch(value);
  }

  /// 字符串检索
  static bool isInclude(String value, String match) {
    return RegExp(r"(" + match + ")").hasMatch(value);
  }

  /// 验证身份证
  static bool isIdCard(String value) {
    return RegExp(r"\d{17}[\d|x]|\d{15}").hasMatch(value);
  }

  /// 验证中文
  static bool isChinese(String value) {
    return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
  }

  /// 匹配中文，英文字母
  static bool isChar(String value) {
    return RegExp(r"^[a-zA-Z0-9_\u4e00-\u9fa5]+$").hasMatch(value);
  }

  /// 验证码密码：8-16位，至少包含一个字母一个数字，其他不限制
  /// r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
  static bool isPassword(String value) {
    return RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[^]{8,16}$").hasMatch(value);
  }

  /// 验证用户名 6-16位的字母和数字组合
  static bool isUserName(String value) {
    return RegExp(r"^[a-zA-Z](?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]{5,15}$")
        .hasMatch(value);
  }

  /// 验证用户名 6-16位 字母开头，可以包含数字和下划线
  static bool isUserNameSenond(String value) {
    return RegExp(r"^[a-zA-Z]\w{5,15}$").hasMatch(value);
  }
}
