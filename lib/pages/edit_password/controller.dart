import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/user.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/edit_password/library.dart';

class EditPasswordController extends GetxController {
  final state = EditPasswordState();

  final oldController = TextEditingController();
  final oldFocusNode = FocusNode();
  final newController = TextEditingController();
  final newFocusNode = FocusNode();
  final newReController = TextEditingController();
  final newReFocusNode = FocusNode();

  void lostFocus() {
    if (oldFocusNode.hasFocus) oldFocusNode.unfocus();
    if (newFocusNode.hasFocus) newFocusNode.unfocus();
    if (newReFocusNode.hasFocus) newReFocusNode.unfocus();
  }

  /// 监听器：舰艇文本输入框
  void listener() {
    if (oldController.text.isEmpty ||
        newController.text.isEmpty ||
        newReController.text.isEmpty) {
      state.isEnable = true;
    } else {
      state.isEnable = false;
    }
  }

  void changePassword() async {
    lostFocus();
    MyDialog.getLoadingBox();
    var response = await UserApi.editPassword(
      oldPassword: oldController.text,
      newPassword: newController.text,
    );

    if (response != null && response.code == 200) {
      Get.back();
      Get.back();
      MyDialog.getSnakBar('操作成功', '密码修改成功');
    } else {
      Get.back();
      MyDialog.getErrorSnakBar(ErrorEntity(code: -1, message: '操作失败'));
    }
  }

  @override
  void onReady() async {
    super.onReady();

    oldController.addListener(listener);
    newController.addListener(listener);
    newReController.addListener(listener);

    await MyTimer.futureMill(300);
    oldFocusNode.requestFocus();
  }
}
