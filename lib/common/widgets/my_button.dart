import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.width,
    this.height,
    this.onTap,
    this.child,
    this.borderRadius = MyStyle.borderRadius,
    this.color,
    this.padding,
  }) : super(key: key);

  final double? width;
  final double? height;
  final void Function()? onTap;
  final Widget? child;
  final BorderRadiusGeometry borderRadius;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  /// 关闭按钮
  static MyButton close({void Function()? onTap, double? size}) {
    return MyButton(onTap: onTap, child: MyIcons.close(size: size));
  }

  /// 消息按钮-未读
  static MyButton emailRead({void Function()? onTap}) {
    return MyButton(onTap: onTap, child: MyIcons.emialRead());
  }

  /// 消息按钮-已读
  static MyButton email({void Function()? onTap}) {
    return MyButton(onTap: onTap, child: MyIcons.emial());
  }

  /// 客服按钮
  static MyButton customer({void Function()? onTap}) {
    return MyButton(onTap: onTap, child: MyIcons.customer());
  }

  /// 我的页面哪些功能按钮的样式
  static MyButton my({
    required Widget icon,
    required String text,
    required void Function() onTap,
  }) {
    var children = [
      const SizedBox(height: 20),
      Expanded(child: icon),
      const SizedBox(height: 10),
      MyText(text),
      const SizedBox(height: 20),
    ];
    var child = Column(
      children: children,
      mainAxisAlignment: MainAxisAlignment.center,
    );
    return MyButton(
      onTap: onTap,
      child: child,
      width: (Get.width - 32 - 20) / 3,
      height: (Get.width - 32 - 20) / 3,
      color: MyColors.input,
    );
  }

  /// 搜索历史
  static Widget history({
    required String text,
    void Function()? onTap,
  }) {
    var buttonText = MyText(text);

    return MyButton(
      onTap: onTap,
      child: buttonText,
      color: MyColors.input,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    );
  }

  /// 返回按钮
  static MyButton back({void Function()? onTap}) {
    void _onTap() => Get.back();
    return MyButton(
      onTap: onTap ?? _onTap,
      child: MyIcons.back(),
      width: 50,
    );
  }

  /// 网络连接失败后，重新连接的按钮
  static MyButton retry({void Function()? onTap}) {
    const errorText = MyText(
      '网络连接失败',
      textAlign: TextAlign.center,
      color: MyColors.secondText,
    );

    const retryText = MyText(
      '点击重试',
      textAlign: TextAlign.center,
      color: MyColors.secondText,
    );

    var noDataChildren = [
      const SizedBox(height: 20),
      MyIcons.retry(),
      const SizedBox(height: 10),
      errorText,
      retryText,
    ];

    return MyButton(
      onTap: onTap,
      child: Column(children: noDataChildren),
      width: 50,
    );
  }

  /// 长按钮
  static MyButton infinity(
    String data, {
    void Function()? onTap,
  }) {
    const gradient = LinearGradient(
      colors: [Color.fromARGB(255, 46, 224, 30), Color(0xFF02be02)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    const decoration = BoxDecoration(gradient: gradient);

    var child = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: decoration,
      child: Center(child: MyText(data)),
    );

    return MyButton(
      onTap: onTap,
      width: double.infinity,
      height: 40,
      child: child,
    );
  }

  /// 长按钮
  static MyButton enable(String data, {double? width}) {
    return MyButton(
      child: MyText.gray16(data),
      height: 40,
      width: width,
      color: MyColors.secondBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnable = false.obs;

    void _onTap() async {
      if (onTap != null) onTap!();
      isEnable.value = true;
      await MyTimer.futureMill(500);
      isEnable.value = false;
    }

    var decoration = BoxDecoration(
      borderRadius: borderRadius,
      color: color,
      shape: BoxShape.rectangle,
    );

    var less = Container(
      width: width,
      height: height,
      decoration: decoration,
      clipBehavior: Clip.antiAlias,
      child: Center(child: child),
      padding: padding,
    );

    var button = GestureDetector(
      onTap: _onTap,
      child: Obx(() => Opacity(
            opacity: isEnable.value ? 0.5 : 1,
            child: less,
          )),
    );

    return onTap == null ? less : button;
  }
}
