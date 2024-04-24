import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/user.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/add_bank/library.dart';

class AddBankController extends GetxController {
  final state = AddBankState();
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  final numberController = TextEditingController();
  final numberFocusNode = FocusNode();
  final bankNameController = TextEditingController();
  final bankNameFocusNode = FocusNode();

  /// 监听器：舰艇文本输入框
  void listener() {
    if (nameController.text.isEmpty ||
        numberController.text.isEmpty ||
        bankNameController.text.isEmpty) {
      state.isEnable = true;
    } else {
      state.isEnable = false;
    }
  }

  void addBank() async {
    if (nameFocusNode.hasFocus) nameFocusNode.unfocus();
    if (bankNameFocusNode.hasFocus) bankNameFocusNode.unfocus();
    if (numberFocusNode.hasFocus) numberFocusNode.unfocus();

    MyDialog.getDaliog(child: DialogChild.loading());
    var response = await UserApi.addBank(
      name: nameController.text,
      number: numberController.text,
      bankName: bankNameController.text,
    );
    if (response != null && response.code == 200) {
      var bankInfo = BankInfo.fromJson(response.data);
      UserController.to.userInfo.value.bank = bankInfo;
      UserController.to.userInfo.update((val) {});
    }
    Get.back();
    Get.back();
  }

  @override
  void onReady() async {
    super.onReady();

    nameController.addListener(listener);
    numberController.addListener(listener);
    bankNameController.addListener(listener);

    await MyTimer.futureMill(300);
    nameFocusNode.requestFocus();
  }
}
