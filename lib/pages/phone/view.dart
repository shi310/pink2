import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/global/user.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/phone/library.dart';

class PhoneView extends GetView<PhoneController> {
  const PhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = UserController.to.userInfo;
    var header = MyAppBar(
      isShowLine: true,
      left: MyButton.back(),
      center: const MyText('手机'),
    );

    void addPhone() {
      Get.toNamed(MyRoutes.phone + MyRoutes.addOrEditPhone);
    }

    void changePhone() {
      Get.toNamed(MyRoutes.phone + MyRoutes.addOrEditPhone);
    }

    Widget obxBuild() {
      var icon = userInfo.value.phone == null || userInfo.value.phone!.isEmpty
          ? Icons.phonelink_erase
          : Icons.mobile_friendly;

      var color = userInfo.value.phone == null || userInfo.value.phone!.isEmpty
          ? MyColors.erro
          : MyColors.primary;

      var decoration = BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      );

      var text = userInfo.value.phone == null || userInfo.value.phone!.isEmpty
          ? const MyText('您还未绑定手机')
          : const MyText('您已绑定手机');

      var iconBox = Container(
        child: Icon(icon, size: 32, color: MyColors.text),
        width: 70,
        height: 70,
        decoration: decoration,
      );

      var onTap = userInfo.value.phone == null || userInfo.value.phone!.isEmpty
          ? addPhone
          : changePhone;

      var buttonText =
          userInfo.value.phone == null || userInfo.value.phone!.isEmpty
              ? '立即绑定手机'
              : '更改手机';

      var button = Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: MyButton.infinity(buttonText, onTap: onTap),
      );

      return Column(children: [
        const SizedBox(height: 40),
        iconBox,
        const SizedBox(height: 20),
        text,
        if (userInfo.value.phone != null && userInfo.value.phone!.isNotEmpty)
          const SizedBox(height: 8),
        if (userInfo.value.phone != null && userInfo.value.phone!.isNotEmpty)
          MyText.gray14('+${userInfo.value.code!} ${userInfo.value.phone!}'),
        const SizedBox(height: 40),
        button,
        // const SizedBox(height: 20),
        // if (userInfo.value.phone != null && userInfo.value.phone!.isNotEmpty)
        //   Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20),
        //     child: MyButton(
        //       color: MyColors.secondBackground,
        //       height: 40,
        //       child: const MyText('解绑手机', color: MyColors.primary),
        //       onTap: () {},
        //     ),
        //   )
      ]);
    }

    var body = Obx(obxBuild);

    return MyScaffold(header: header, body: body);
  }
}
