import 'package:flutter/material.dart';
import 'package:pinker/common/style/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    this.isTransparent = false,
    this.isShowLine = false,
    this.left,
    this.center,
    this.right,
  }) : super(key: key);

  final bool isTransparent;
  final bool isShowLine;
  final Widget? left;
  final Widget? center;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    /// 左侧
    /// 用row包裹是为了保持组建的原有大小
    var leftWidget = Row(
      children: [left ?? const SizedBox()],
    );

    /// 中间
    var centerWidget = Center(
      child: center ?? const SizedBox(),
    );

    /// 右侧
    /// 用row包裹是为了保持组建的原有大小
    var rightWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [right ?? const SizedBox()],
    );

    /// appBar 的组成成员
    var children = [
      Expanded(child: leftWidget),
      Expanded(child: centerWidget, flex: 2),
      Expanded(child: rightWidget),
    ];

    /// 有左侧 或着 有右侧
    var leftOrRight = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );

    /// 内容组装
    var content = SizedBox(
      width: double.infinity,
      height: 50,
      child: left == null && right == null ? centerWidget : leftOrRight,
    );

    /// 动态组装

    /// 动态背景

    const bottomSide = BorderSide(
      color: MyColors.input,
    );
    const border = Border(bottom: bottomSide);

    /// 安全区
    var safeArea = SafeArea(
      bottom: false,
      child: content,
    );

    /// 样式
    var decoration = BoxDecoration(
      color: isTransparent ? null : MyColors.background,
      border: isShowLine ? border : null,
    );
    return Container(
      decoration: decoration,
      child: safeArea,
    );
  }
}
