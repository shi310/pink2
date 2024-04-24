import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/user.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/edit_password/library.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// AppBar: 标题是动态的
    var header = MyAppBar(
      isShowLine: true,
      center: MyText.text18('修改密码'),
      left: MyButton.back(),
    );

    var button = MyButton.infinity('提交', onTap: controller.changePassword);
    var enableButton = MyButton.enable('提交', width: double.infinity);

    var bodyChildren = [
      const SizedBox(height: 20),
      MyInput.getInfo(
        '当前密码',
        '请输入当前密码',
        controller: controller.oldController,
        focusNode: controller.oldFocusNode,
        obscureText: true,
      ),
      const SizedBox(height: 10),
      MyInput.getInfo(
        '新密码',
        '8-24位字母和数字组合,允许有符号',
        controller: controller.newController,
        focusNode: controller.newFocusNode,
        obscureText: true,
      ),
      const SizedBox(height: 10),
      MyInput.getInfo(
        '重复密码',
        '8-24位字母和数字组合,允许有符号',
        controller: controller.newReController,
        focusNode: controller.newReFocusNode,
        obscureText: true,
      ),
      const SizedBox(height: 32),
      Obx(() => controller.state.isEnable ? enableButton : button),
      const SizedBox(height: 10),
      if (!UserController.to.userInfo.value.isFirstSetPassword)
        MyButton(
          child: const MyText('忘记密码'),
          height: 40,
          onTap: () {},
        ),
    ];

    var bodyChild = Column(children: bodyChildren);

    var body = Padding(
      padding: const EdgeInsets.all(16),
      child: bodyChild,
    );
    return MyScaffold(header: header, body: body);
  }
}
