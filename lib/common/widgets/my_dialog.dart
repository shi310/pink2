import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';

class DialogChild extends StatelessWidget {
  const DialogChild({
    Key? key,
    required this.child,
    this.isAutoBack = true,
  }) : super(key: key);

  final Widget child;
  final bool isAutoBack;

  static DialogChild oneButton({
    required String title,
    required String content,
    String buttonText = '确认',
    void Function()? onTap,
    int maxLines = 1,
  }) {
    var titleBox = MyText.gray18(title);

    var contentBox = MyText(content, maxLines: maxLines);

    var sureButton = MyButton(
      borderRadius: BorderRadius.zero,
      width: double.infinity,
      height: 50,
      child: MyText.primary(buttonText),
      onTap: onTap ?? () => Get.back(),
    );

    var contentBody = Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
      child: Column(
        children: [titleBox, const SizedBox(height: 20), contentBox],
      ),
    );

    var bodyChild = Column(
      children: [
        contentBody,
        Container(height: 1, color: MyColors.line),
        sureButton,
      ],
    );

    var child = Container(
      child: bodyChild,
      width: Get.width - 32 - 64,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: MyColors.secondBackground,
        borderRadius: MyStyle.borderRadius,
        shape: BoxShape.rectangle,
      ),
    );

    return DialogChild(child: child);
  }

  static DialogChild loading() {
    var child = MyButton(
      child: MyIcons.loading(),
      width: 80,
      height: 80,
      color: MyColors.input,
    );
    return DialogChild(
      child: child,
      isAutoBack: false,
    );
  }

  static DialogChild alert({
    required String title,
    required String content,
    void Function()? onTap,
  }) {
    void back() {
      Get.back();
      // MyHttp().cancelToken.cancel();
    }

    var titleBox = MyText.text20(title);

    var contentBox = MyText(content);

    var cancelButton = MyButton(
      width: double.infinity,
      height: 50,
      onTap: back,
      child: const MyText('取消'),
    );

    var sureButton = MyButton(
      width: double.infinity,
      height: 50,
      child: MyText.primary('确认'),
      onTap: onTap,
    );

    var contentBody = Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
      child: Column(
        children: [titleBox, const SizedBox(height: 20), contentBox],
      ),
    );

    var buttons = Row(
      children: [
        Expanded(child: cancelButton),
        Container(width: 1, height: 32, color: MyColors.line),
        Expanded(child: sureButton),
      ],
    );

    var body = Column(
      children: [
        contentBody,
        Container(height: 1, color: MyColors.line),
        buttons,
      ],
    );

    var child = Container(
      child: body,
      width: Get.width * 0.6,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: MyColors.secondBackground,
        borderRadius: MyStyle.borderRadius,
        shape: BoxShape.rectangle,
      ),
    );

    return DialogChild(child: child);
  }

  @override
  Widget build(BuildContext context) {
    void back() => Get.back();

    var button = MyButton(
      width: Get.width,
      height: Get.height,
      onTap: back,
    );

    var body = SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(children: [const Spacer(), child, const Spacer()]),
    );

    return Scaffold(
      body: isAutoBack ? Stack(children: [button, body]) : body,
      backgroundColor: MyColors.background88,
    );
  }
}

class MyDialog {
  /// 弹窗：重试
  static Future<void> getErrorDaliog(ErrorEntity eInfo) async {
    return getDaliog(
      child: DialogChild.oneButton(
        title: eInfo.message,
        content: '请点击重试按钮尝试重新连接',
        buttonText: '重试',
        onTap: () => Get.back(),
      ),
    );
  }

  /// 顶部弹窗
  static Future<void> getErrorSnakBar(ErrorEntity eInfo) async {
    getSnakBar(eInfo.message, '请稍后重试');
  }

  /// 弹窗：loading
  static Future<void> getLoadingBox() async {
    return getDaliog(child: DialogChild.loading());
  }

  /// 顶部弹窗的封装
  static void getSnakBar(String title, String message) {
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar(
      title,
      message,
      colorText: MyColors.secondText,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  /// 中间弹窗
  static Future<void> getDaliog({required Widget child}) {
    return Get.dialog(child, useSafeArea: false);
  }

  /// 底部弹窗
  static Future<void> getBottomSheet({
    bool isShowDirectly = false,
    required Widget child,
  }) {
    if (isShowDirectly) {
      var body = Stack(children: [
        MyButton(
          width: double.infinity,
          height: double.infinity,
          onTap: () {
            Get.back();
          },
        ),
        Column(children: [
          const Spacer(),
          child,
        ]),
      ]);
      return Get.bottomSheet(
        body,
        isScrollControlled: true,
      );
    } else {
      return Get.bottomSheet(
        child,
        isScrollControlled: true,
      );
    }
  }
}
