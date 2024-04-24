import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/add_bank/library.dart';

class AddBankView extends GetView<AddBankController> {
  const AddBankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var header = MyAppBar(
      isShowLine: true,
      left: MyButton.back(),
      center: const MyText('添加银行卡'),
    );

    var button = MyButton.infinity('提交', onTap: controller.addBank);
    var enableButton = MyButton.enable('提交', width: double.infinity);

    var bodyChildren = [
      MyText.gray14('持卡人姓名绑定成功后不可修改，请认真填写您的信息'),
      const SizedBox(height: 20),
      MyInput.getInfo(
        '账户姓名',
        '张三',
        controller: controller.nameController,
        focusNode: controller.nameFocusNode,
      ),
      const SizedBox(height: 10),
      MyInput.getInfo(
        '银行卡号',
        '622848 0000 0000',
        controller: controller.numberController,
        focusNode: controller.numberFocusNode,
      ),
      const SizedBox(height: 10),
      MyInput.getInfo('银行名称', '招商银行',
          controller: controller.bankNameController,
          focusNode: controller.bankNameFocusNode),
      const SizedBox(height: 32),
      Obx(() => controller.state.isEnable ? enableButton : button),
    ];

    var bodyChild = Column(children: bodyChildren);

    var body = Padding(
      padding: const EdgeInsets.all(16),
      child: bodyChild,
    );

    return MyScaffold(header: header, body: body);
  }
}
