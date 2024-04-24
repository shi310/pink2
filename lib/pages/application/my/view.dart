import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/utils/library.dart';

import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/application/my/library.dart';

class MyView extends GetView<MyController> {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = UserController.to.userInfo;

    /// appBar 的子内容
    var appBarChildren = [
      MyButton.customer(onTap: controller.onCustomer),
      const SizedBox(width: 40),
      Obx(() => controller.homeController.state.isRead
          ? MyButton.emailRead(onTap: controller.onNotice)
          : MyButton.email(onTap: controller.onNotice)),
      const SizedBox(width: 20),
    ];

    var appBarChild = Row(
      children: appBarChildren,
      mainAxisAlignment: MainAxisAlignment.end,
    );

    /// appBar 的组成
    var appBar = MyAppBar(isTransparent: true, center: appBarChild);

    /// appBar 的动态背景
    Widget obxBuild() {
      var container = Container(color: MyColors.primary);

      var opcatiy = Opacity(opacity: 0.5, child: container);

      var filter = ImageFilter.blur(sigmaX: 16, sigmaY: 16);

      var backdropFilter = BackdropFilter(filter: filter, child: opcatiy);

      var clipRect = ClipRect(child: backdropFilter);

      return Positioned(
        child: Opacity(opacity: controller.state.opacity, child: clipRect),
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
      );
    }

    /// APPBAR
    var header = Stack(children: [Obx(obxBuild), appBar]);

    /// 下面是底部的内容
    var bannerImage = SvgPicture.asset(
      'assets/svg/my_banner.svg',
      width: Get.width,
    );

    /// 钱包的样式
    const diamondBoxDecoration = BoxDecoration(
      borderRadius: MyStyle.borderRadius,
      color: MyColors.input,
    );

    /// 钱包的标题
    const diamonTitle = MyText('钻石账户');

    /// 充值按钮
    var rechargeButton = MyButton(
      child: const MyText('充值'),
      width: 60,
      height: 36,
      color: MyColors.primary,
      onTap: controller.recharge,
    );

    /// 提现按钮
    var pickButton = MyButton(
      child: const MyText('提现'),
      width: 60,
      height: 36,
      color: const Color.fromARGB(255, 146, 62, 235),
      onTap: controller.pick,
    );

    /// 钱包标题的子内容
    var diamonTitleBoxChildren = [
      MyIcons.diamond(),
      const SizedBox(width: 10),
      diamonTitle,
    ];

    /// 钱包标题
    var diamonTitleBox = Row(children: diamonTitleBoxChildren);

    var balance = Obx(() {
      if (userInfo.value.balance <= 9999999.99) {
        var balance = userInfo.value.balance;
        return MyText.welcom(MyCharacter.getMoney(balance, fixed: 2));
      } else {
        var balance = (userInfo.value.balance ~/ 10000).toDouble();
        return Row(
          children: [
            MyText.welcom(MyCharacter.getMoney(balance)),
            const SizedBox(width: 10),
            MyText.text24('万')
          ],
        );
      }
    });

    /// 钱包内容的子内容
    var diamonContentBoxChildren = [
      balance,
      const Spacer(),
      pickButton,
      const SizedBox(width: 10),
      rechargeButton,
    ];

    /// 钱包的内容
    var diamonContentBox = Row(children: diamonContentBoxChildren);

    /// 钱包的标题和内容的组合数组
    var diamonBoxChildren = [
      diamonTitleBox,
      const SizedBox(height: 16),
      Container(height: 1, width: double.infinity, color: Colors.white10),
      const SizedBox(height: 32),
      diamonContentBox,
      const SizedBox(height: 16),
    ];

    /// 钱包的组合
    var diamonBox = Container(
      width: Get.width - 32,
      decoration: diamondBoxDecoration,
      child: Column(children: diamonBoxChildren),
      padding: const EdgeInsets.all(16),
    );

    /// 钱包的安全位置
    var diamondBoxSafe = SafeArea(bottom: false, child: diamonBox);

    /// 钱包和顶部的距离
    var diamondBoxPadding = SafeArea(
      child: Padding(
        child: diamondBoxSafe,
        padding: const EdgeInsets.only(top: 100),
      ),
      bottom: false,
    );

    var textNoLogin = MyText.text20('亲, 您还未登陆哦');
    var textLogin = MyText.text20('欢迎回来, 亲');

    var userName = Positioned(
      child: SafeArea(
        child: Obx(() => userInfo.value.userId == 0 ? textNoLogin : textLogin),
      ),
      top: 54,
      left: 28,
    );

    /// 钱包和banner的结合
    var bannerChildren = [
      bannerImage,
      userName,
      diamondBoxPadding,
    ];

    /// 钱包和banner的组合
    var banner = Stack(
      alignment: AlignmentDirectional.topCenter,
      children: bannerChildren,
    );

    Widget buttonBuild() {
      /// 第一排按钮的内容
      var commonChildren = [
        MyButton.my(
          icon: MyIcons.history(),
          text: '收藏夹',
          onTap: controller.history,
        ),
        MyButton.my(
          icon: MyIcons.bank(),
          text: '银行卡',
          onTap: controller.bank,
        ),
        MyButton.my(
          icon: MyIcons.phone(),
          text: '手机',
          onTap: controller.phone,
        ),
        MyButton.my(
          icon: MyIcons.password(),
          text: '密码',
          onTap: controller.password,
        ),
        MyButton.my(
          icon: MyIcons.password(),
          text: '代理',
          onTap: controller.password,
        ),
        if (userInfo.value.userId != 0)
          MyButton.my(
            icon: MyIcons.exit(),
            text: '退出登录',
            onTap: controller.loginOut,
          ),
      ];
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: commonChildren,
      );
    }

    var commonBox = Obx(buttonBuild);

    var bodyChildren = [
      banner,
      const SizedBox(height: 10),
      commonBox,
      const SizedBox(height: 10),
    ];

    var background = Stack(children: [
      Obx(
        () => Container(
          color: controller.state.scrollOffset >= 0
              ? MyColors.background
              : MyColors.primary,
        ),
      ),
      SingleChildScrollView(
        child: Container(
          child: Column(children: bodyChildren),
          color: MyColors.background,
        ),
        controller: controller.scrollController,
      )
    ]);

    return MyScaffold(
      header: header,
      background: background,
    );
  }
}
