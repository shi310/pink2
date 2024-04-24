import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/application/home/cartoon/view.dart';
import 'package:pinker/pages/application/home/drama/view.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/home/movie/view.dart';
import 'package:pinker/pages/application/home/sex/library.dart';
import 'package:pinker/pages/application/home/show/view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 顶层部分
    /// 包含 AppBar 和 TabBar
    /// 下方是 Appbar
    var logo = MyIcons.logo();

    var searchText = MyText.gray14(ResourceController.to.searchWord);

    var lineDark = Container(
      width: 1,
      height: 24,
      color: Colors.black26,
    );

    var lineLight = Container(
      width: 1,
      height: 24,
      color: Colors.white12,
    );

    var searchRight = Row(children: [
      Row(children: [lineDark, lineLight]),
      const SizedBox(width: 16),
      MyIcons.search(),
    ]);

    var searchButtonChild = Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(children: [searchText, const Spacer(), searchRight]),
    );

    var searchButton = MyButton(
      child: searchButtonChild,
      width: double.infinity,
      height: 35,
      onTap: controller.search,
      color: Colors.white10,
    );

    var rowChildren = [
      logo,
      const SizedBox(width: 20),
      Expanded(child: searchButton)
    ];

    var appBarChild = Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(children: rowChildren),
    );

    var appBar = MyAppBar(
      isTransparent: true,
      center: appBarChild,
    );

    var tabBar = MyTabBar(
      pageController: controller.pageController,
      pageIndex: controller.state.pageIndexRx,
      tabs: ResourceController.to.types,
      // scrollController: controller.scrollController,
    );

    var headerColumn = Column(children: [appBar, tabBar]);

    Widget obxBuild() {
      var container = Container(color: MyColors.input);

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

    var header = Stack(children: [Obx(obxBuild), headerColumn]);

    const pages = [
      MovieView(),
      DramaView(),
      ShowView(),
      CartoonView(),
      SexView(),
    ];

    /// 这里开始是整个页面的组合部分
    var body = PageView(
      controller: controller.pageController,
      onPageChanged: controller.pageChanged,
      children: pages,
      physics: const NeverScrollableScrollPhysics(),
    );

    var scaffold = MyScaffold(
      background: body,
      header: header,
    );

    return scaffold;
  }
}
