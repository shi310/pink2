import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/library.dart';
import 'package:pinker/common/constant/library.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/services/librart.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';

class LoginBox extends StatelessWidget {
  const LoginBox({
    Key? key,
    this.forgotCallBack,
    this.loginCallBack,
    this.registerCallBack,
  }) : super(key: key);

  final void Function()? loginCallBack;
  final void Function()? registerCallBack;
  final void Function()? forgotCallBack;

  @override
  Widget build(BuildContext context) {
    final accountController = TextEditingController();
    final accountFocusNode = FocusNode();
    final passwordController = TextEditingController();
    final passwordFocusNode = FocusNode();

    final isLoading = false.obs;
    final isOnTap = false.obs;
    final obscureText = true.obs;

    final cancelToken = CancelToken();

    void linster() {
      if (accountController.text.isEmpty || passwordController.text.isEmpty) {
        isOnTap.value = false;
      } else {
        isOnTap.value = true;
      }
    }

    accountController.addListener(linster);
    passwordController.addListener(linster);

    void signIn() async {
      isLoading.value = true;
      isOnTap.value = false;

      var _signIn = await AccountApi.signIn(
        account: accountController.text,
        password: passwordController.text,
        errorCallBack: MyDialog.getErrorSnakBar,
        cancelToken: cancelToken,
      );

      if (_signIn == null || _signIn.code != 200) {
        isLoading.value = false;
        isOnTap.value = true;
        return;
      }

      var _getUserInfo = await UserApi.getUserInfo(
        errorCallBack: MyDialog.getErrorSnakBar,
      );

      if (_getUserInfo == null || _getUserInfo.code != 200) {
        isLoading.value = false;
        isOnTap.value = true;
        return;
      }

      UserController.to.token = _signIn.data['token'];
      await MyStorageService.to.setString(
        storageUserTokenKey,
        UserController.to.token,
      );

      var userInfo = UserInfo.fromJson(_getUserInfo.data);
      UserController.to.userInfo.value = userInfo;
      UserController.to.userInfo.update((val) {});

      Get.back();
      MyDialog.getSnakBar('操作成功', '您已成功登陆');
    }

    var closeButtonChildren = [
      const Spacer(),
      MyButton.close(
        onTap: () {
          cancelToken.cancel();
          Get.back();
        },
        size: 20,
      ),
      const SizedBox(width: 10),
    ];

    var accountInput = Obx(() => MyInput(
          controller: accountController,
          focusNode: accountFocusNode,
          autofocus: true,
          hintText: '账号',
          width: Get.width - 80 - 40,
          enabled: !isLoading.value,
          textInputAction: TextInputAction.next,
        ));

    Widget passwordObxBuild() {
      Widget suffixIconObxBuild() {
        var icon = obscureText.value ? Icons.visibility : Icons.visibility_off;
        return MyButton(
          child: Icon(icon, color: MyColors.primary, size: 16),
          onTap: () => obscureText.value = !obscureText.value,
        );
      }

      return MyInput(
        controller: passwordController,
        focusNode: passwordFocusNode,
        autofocus: true,
        hintText: '密码',
        obscureText: obscureText.value,
        width: Get.width - 80 - 40,
        enabled: !isLoading.value,
        suffixIcon: Obx(suffixIconObxBuild),
        textInputAction: TextInputAction.go,
        onSubmitted: isOnTap.value ? (text) => signIn() : null,
      );
    }

    var passwordInput = Obx(passwordObxBuild);

    var signInButton = Obx(() {
      var text = MyText(
        '登陆',
        color: isOnTap.value ? MyColors.text : MyColors.secondText,
      );

      var loading = SizedBox(
        width: 16,
        height: 16,
        child: MyIcons.loading(),
      );
      return MyButton(
        child: isLoading.value ? loading : text,
        color: isOnTap.value ? MyColors.primary : MyColors.enable,
        width: Get.width - 80 - 40,
        height: 35,
        onTap: isOnTap.value ? signIn : null,
      );
    });

    var forgotButton = MyButton(
      child: const MyText('忘记密码'),
      onTap: isLoading.value ? null : () {},
    );

    var signUpButton = MyButton(
      child: const MyText('注册账号'),
      onTap: isLoading.value ? null : () {},
    );

    var forgotAndSignUp = Row(
      children: [
        const SizedBox(width: 25),
        signUpButton,
        const Spacer(),
        forgotButton,
        const SizedBox(width: 25),
      ],
    );

    var bodyChild = Column(
      children: [
        const SizedBox(height: 10),

        /// 关闭按钮
        Row(children: closeButtonChildren),

        /// 标题
        MyText.text20('登陆'),

        const SizedBox(height: 32),

        /// 账号输入框
        accountInput,

        const SizedBox(height: 5),

        /// 密码输入框
        passwordInput,

        const SizedBox(height: 32),

        /// 登陆那妞
        signInButton,

        const SizedBox(height: 10),

        /// 注册和忘记密码
        forgotAndSignUp,

        const SizedBox(height: 32),
      ],
    );

    const decoration = BoxDecoration(
      color: MyColors.secondBackground,
      borderRadius: MyStyle.borderRadius,
      shape: BoxShape.rectangle,
    );

    var child = Container(
      child: bodyChild,
      width: Get.width - 80,
      clipBehavior: Clip.antiAlias,
      decoration: decoration,
    );

    return DialogChild(child: child, isAutoBack: false);
  }
}
