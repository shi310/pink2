import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/lang/translation_service.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/welcome/library.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = controller.state;

    /// 标题和副标题的组合
    var top = Column(children: [
      MyText.welcom(Lang.welcomeTitle.tr),
      const SizedBox(height: 10),
      MyText.gray18(Lang.welcomeSecondTitle.tr),
    ]);

    /// 中间图片部分
    var image = Image.asset('assets/images/welcome.png');

    Widget obxBuild() {
      /// 进度条
      var loadingBoxChild = LinearProgressIndicator(
        value: state.loadingValue,
        minHeight: 16,
        backgroundColor: MyColors.secondText,
        color: MyColors.primary,
      );

      /// 进度条的组成：提示语 和 带圆角的进度条
      return Column(children: [
        MyText.gray14('正在加载影片数据...  ${state.loadingValue * 100} %'),
        const SizedBox(height: 16),
        MyButton(child: loadingBoxChild),
      ]);
    }

    /// 页面的排列方式
    var column = Column(children: [
      Column(children: [image, top]),
      const Spacer(),
      Obx(obxBuild),
    ]);

    /// 页面的左右上下边距
    var padding = Padding(
      padding: const EdgeInsets.fromLTRB(60, 80, 60, 80),
      child: column,
    );

    /// 页面的安全区域
    var body = SafeArea(child: padding);

    /// 背景图片
    var backgroundImage = Image.asset(
      'assets/images/bg.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );

    /// 页面构造
    return MyScaffold(
      body: body,
      background: backgroundImage,
    );
  }
}
