import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';

class MyFooterBar extends StatelessWidget {
  const MyFooterBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  /// 需要传入页面控制器，用来控制跳转不同的页面
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    /// 当前选中的状态
    /// 该状态可以改变界面
    final indexObx = 0.obs;

    /// 获取按钮图标的公共方法
    Widget item(
      String image_1,
      String image_2,
      int index, {
      String? title,
    }) {
      /// 按钮的默认状态
      var _image_1 = SvgPicture.asset(
        'assets/svg/$image_1.svg',
        height: 24,
        width: 24,
      );

      /// 按钮的选中状态
      var _image_2 = SvgPicture.asset(
        'assets/svg/$image_2.svg',
        height: 24,
        width: 24,
      );

      /// 按钮的上下边距
      var padding = Padding(
        padding: const EdgeInsets.fromLTRB(0, 13.0, 0, 13.0),
        child: indexObx.value == index ? _image_2 : _image_1,
      );

      /// 按钮的文本，可选
      var _title = MyText(title ?? '');

      /// 按钮图标和文本的组成
      var columnChildren = [padding, if (title != null && title != '') _title];
      var column = Column(
        children: columnChildren,
        mainAxisAlignment: MainAxisAlignment.center,
      );

      /// 按钮最终形态
      var child = Center(child: column);

      void _onTap() {
        indexObx.value = index;
        pageController.jumpToPage(index);
      }

      /// 返回按钮
      return MyButton(
        width: double.infinity,
        child: child,
        onTap: indexObx.value == index ? null : _onTap,
      );
    }

    var rowChildren = [
      Expanded(child: Obx(() => item('bottom_home_1', 'bottom_home_2', 0))),
      Expanded(child: Obx(() => item('bottom_sear_1', 'bottom_sear_2', 1))),
      Expanded(child: Obx(() => item('bottom_it_1', 'bottom_it_2', 2))),
      Expanded(child: Obx(() => item('bottom_my_1', 'bottom_my_2', 3))),
    ];

    var body = Row(children: rowChildren);

    /// 安全区
    var safeArea = SafeArea(top: false, child: body);

    /// 动态的下边框颜色
    const bottomSide = BorderSide(color: Color(0xFF24242B));
    const border = Border(top: bottomSide);

    /// 样式
    const decoration = BoxDecoration(
      color: MyColors.background,
      border: border,
    );

    return Container(decoration: decoration, child: safeArea);
  }
}
