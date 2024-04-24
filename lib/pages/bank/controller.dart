import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/user.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/bank/library.dart';

class BankController extends GetxController {
  final state = BankState();

  final inputController = TextEditingController();
  final inputFocusNode = FocusNode();

  void addBank() {
    Get.toNamed(MyRoutes.addBank);
  }

  void addUsdt() {
    Get.toNamed(MyRoutes.addUsdt);
  }

  void deleteBank() {
    final isLoading = false.obs;
    void _onTap() async {
      isLoading.value = true;
      var response = await UserApi.deleteBank(type: 1);
      if (response != null && response.code == 200) {
        UserController.to.userInfo.update((val) {
          val!.bank = null;
        });
      }
      Get.back();
    }

    var alert = DialogChild.alert(
      title: '删除银行卡',
      content: '是否确认继续操作',
      onTap: _onTap,
    );

    MyDialog.getDaliog(
        child: Obx(() => isLoading.value ? DialogChild.loading() : alert));
  }

  void deleteUsdt() {
    final isLoading = false.obs;
    void _onTap() async {
      isLoading.value = true;
      var response = await UserApi.deleteBank(type: 2);
      if (response != null && response.code == 200) {
        UserController.to.userInfo.update((val) {
          val!.usdt = null;
        });
      }
      Get.back();
    }

    var alert = DialogChild.alert(
      title: '删除USDT',
      content: '是否确认继续操作',
      onTap: _onTap,
    );

    MyDialog.getDaliog(
        child: Obx(() => isLoading.value ? DialogChild.loading() : alert));
  }
}
