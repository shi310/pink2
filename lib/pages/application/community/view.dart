import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/application/community/cartoon/library.dart';
import 'package:pinker/pages/application/community/drama/library.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/community/movie/library.dart';
import 'package:pinker/pages/application/community/sex/library.dart';
import 'package:pinker/pages/application/community/show/library.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tabBar = MyTabBar(
      pageController: controller.pageController,
      pageIndex: controller.state.pageIndexRx,
      tabs: ResourceController.to.types,
    );

    var appBar = MyAppBar(center: tabBar, isShowLine: true);

    const pages = [
      CommunityMovieView(),
      CommunityDramaView(),
      CommunityShowView(),
      CommunityCartoomView(),
      CommunitySexView(),
    ];

    /// 这里开始是整个页面的组合部分
    var body = PageView(
      controller: controller.pageController,
      onPageChanged: controller.pageChanged,
      children: pages,
    );

    return MyScaffold(
      header: appBar,
      body: body,
    );
  }
}
