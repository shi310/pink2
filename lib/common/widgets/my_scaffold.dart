import 'package:flutter/material.dart';
import 'package:pinker/common/style/library.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    Key? key,
    this.header,
    this.body,
    this.footer,
    this.background,
  }) : super(key: key);

  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    /// 页面背景:默认是黑白交替的颜色
    var backgroundColor = Container(color: MyColors.background);

    /// AppBar和Body的组合成员
    var bodyChildren = [
      if (header != null) header!,
      if (body != null) Expanded(child: body!),
      if (footer != null) footer!,
    ];

    var bodyWidget = Column(
      children: bodyChildren,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );

    /// 页面的背景和Body的组成方式
    var stackChildren = [
      backgroundColor,
      if (background != null) background!,
      bodyWidget
    ];
    var stack = Stack(children: stackChildren);

    /// 根据参数返回页面的形态
    /// 如果有AppBar或者Body或者是Fotter里的任何一个则返回stack
    /// 如果都没有就返回页面背景
    return Scaffold(body: stack);
  }
}
