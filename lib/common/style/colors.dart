import 'package:flutter/widgets.dart';

class MyColors {
  /// 主色
  static const primary = Color(0XFF02BE02);

  /// 纯黑
  static const black = Color(0XFF000000);

  /// 透明
  static const transparent = Color(0X00000000);

  /// 主要文字
  static const text = Color(0XFFFFFFFF);

  /// 白色20的间距
  static const line = Color(0X10FFFFFF);

  /// 次要文字
  static const secondText = Color(0X88FFFFFF);

  /// Switch
  static const switchColor = Color(0XFFEEEEEE);

  /// primaryBackground
  static const background = Color(0XFF0E0E11);

  /// 背景色20透明度
  static const background20 = Color(0X200E0E11);

  /// 背景色88透明度
  static const background88 = Color(0X880E0E11);

  /// 错误颜色
  static const erro = Color(0XFFF92770);

  /// 背景色40透明度
  static const background50 = Color(0X500E0E11);

  /// 次要背景
  static const secondBackground = Color.fromARGB(255, 61, 61, 71);

  /// 禁用颜色
  static const enable = Color.fromARGB(255, 87, 87, 103);

  /// appbar
  static const appBar = Color(0XFF161619);

  /// input
  static const input = Color(0XFF25252B);

  /// 背景渐变色
  static const decorationColors = LinearGradient(
    colors: [Color(0XFF9331FF), Color(0XFF0090FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
