import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/library.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/add_usdt/library.dart';

class AddUsdtController extends GetxController {
  final state = AddUsdtState();
  final inputController = TextEditingController();
  final inputFocusNode = FocusNode();

  /// 监听器：舰艇文本输入框
  void listener() {
    if (inputController.text.isEmpty) {
      state.isEnable = true;
    } else {
      state.isEnable = false;
    }
  }

  void addUsdt() async {
    if (inputFocusNode.hasFocus) inputFocusNode.unfocus();

    MyDialog.getDaliog(child: DialogChild.loading());
    var response = await UserApi.addUsdt(
      number: inputController.text,
    );
    if (response != null && response.code == 200) {
      var bankInfo = BankInfo.fromJson(response.data);
      UserController.to.userInfo.value.usdt = bankInfo;
      UserController.to.userInfo.update((val) {});
    }
    Get.back();
    Get.back();
  }

  @override
  void onReady() async {
    super.onReady();
    inputController.addListener(listener);

    await MyTimer.futureMill(300);
    inputFocusNode.requestFocus();
    // nameController.addListener(() {});
  }
}
