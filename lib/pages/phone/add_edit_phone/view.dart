import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/phone/add_edit_phone/library.dart';

class AddOrEditPhoneView extends GetView<AddOrEditPhoneController> {
  const AddOrEditPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = UserController.to.userInfo;
    var phone = userInfo.value.phone;
    var state = controller.state;

    var header = MyAppBar(
      isShowLine: true,
      left: MyButton.back(),
      center: MyText(phone == null || phone.isEmpty ? '添加手机' : '更改手机'),
    );

    var text_1 = MyText.gray14('输入你想要与账户关联的手机号码', maxLines: 2);
    var text_2 = MyText.gray14('即将通过此号码接收验证码', maxLines: 2);

    var codeButtonChild = Row(children: [
      const SizedBox(width: 8),
      Obx(() => MyText.primary(
          '+${ConfigController.to.areaCode.value}  ${ConfigController.to.areaName.value}')),
      const Spacer(),
      MyIcons.right(),
      const SizedBox(width: 4),
    ]);

    var bodyChild = Column(children: [
      const SizedBox(height: 12),
      text_1,
      const SizedBox(height: 4),
      text_2,
      const SizedBox(height: 32),
      MyButton(child: codeButtonChild, onTap: controller.countryCode),
      const SizedBox(height: 32),
      MyInput(
        controller: controller.inputController,
        focusNode: controller.inputFocusNode,
        hintText: '手机号码',
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 32),
      Obx(() {
        return state.isEnable
            ? MyButton.enable('确认')
            : MyButton.infinity('确认', onTap: controller.onSure);
      }),
    ]);

    var body = Padding(padding: const EdgeInsets.all(20), child: bodyChild);

    return MyScaffold(header: header, body: body);
  }
}
