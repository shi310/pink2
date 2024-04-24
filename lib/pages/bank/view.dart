import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/user.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/bank/library.dart';

class BankView extends GetView<BankController> {
  const BankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var header = MyAppBar(
      isShowLine: true,
      left: MyButton.back(),
      center: const MyText('银行卡管理'),
    );

    Widget empty(String text, {void Function()? onTap}) {
      const icon = Icon(Icons.add_circle, color: MyColors.secondText);
      const spacer = SizedBox(width: 10);
      var textBox = MyText.gray16(text);

      var child = Row(
        children: [icon, spacer, textBox],
        mainAxisAlignment: MainAxisAlignment.center,
      );

      return MyButton(
        width: Get.width - 32,
        height: 150,
        color: MyColors.input,
        child: child,
        onTap: onTap,
      );
    }

    Widget haveData({
      required String imageUrl,
      required String number,
      required String name,
      void Function()? onTap,
      required Color color,
      required ImageProvider<Object> image,
    }) {
      var imageBox = MyImage(
        imageUrl: imageUrl,
        width: 48,
        height: 48,
        borderRadius: BorderRadius.circular(24),
      );
      var nameBox = MyText.text18(name);
      var numbaerBox = MyText.gray16(number);

      const spaceH = SizedBox(height: 5);
      const spaceW = SizedBox(width: 10);

      var nameAndNumber = Column(
        children: [spaceH, nameBox, spaceH, numbaerBox],
        crossAxisAlignment: CrossAxisAlignment.start,
      );
      var nameAndNumberAndImage = Row(
        children: [imageBox, spaceW, nameAndNumber],
        crossAxisAlignment: CrossAxisAlignment.start,
      );

      var button = MyButton(
        width: 90,
        height: 30,
        child: const MyText('删除'),
        onTap: onTap,
        color: MyColors.background50,
      );

      var text = '*新卡24小时后才能提现';

      var body = Column(children: [
        nameAndNumberAndImage,
        const Spacer(),
        Row(children: [MyText.gray14(text), const Spacer(), button]),
      ]);
      return Container(
        width: Get.width - 32,
        height: 150,
        child: body,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(16),
          color: color,
          shape: BoxShape.rectangle,
        ),
        clipBehavior: Clip.antiAlias,
      );
    }

    var body = Column(children: [
      const SizedBox(height: 16),
      Obx(() => UserController.to.userInfo.value.bank == null
          ? empty('添加银行卡', onTap: controller.addBank)
          : haveData(
              imageUrl: UserController.to.userInfo.value.bank!.image,
              image: const AssetImage('assets/images/bank.jpg'),
              number: UserController.to.userInfo.value.bank!.number,
              name: UserController.to.userInfo.value.bank!.name,
              onTap: controller.deleteBank,
              color: Colors.yellowAccent,
            )),
      const SizedBox(height: 16),
      Obx(() => UserController.to.userInfo.value.usdt == null
          ? empty('USDT-TRC', onTap: controller.addUsdt)
          : haveData(
              imageUrl: UserController.to.userInfo.value.usdt!.image,
              image: const AssetImage('assets/images/usdt.jpg'),
              number: UserController.to.userInfo.value.usdt!.number,
              name: UserController.to.userInfo.value.usdt!.name,
              onTap: controller.deleteUsdt,
              color: Colors.pink,
            )),
    ]);

    return MyScaffold(header: header, body: body);
  }
}
