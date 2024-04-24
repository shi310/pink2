import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/utils/library.dart';

import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/home/movie/library.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/application/short/library.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  final shortList = ResourceController.to.shortList;
  int pageIndex = 0;

  bool isPlay = false;

  var pageController = PageController();

  void onPageChanged(int index) async {
    pageIndex = index;
    final ShortController shortController = Get.find();

    switch (index) {
      case 0:
        if (shortController.videoPlayerController != null) {
          await shortController.videoPlayerController!.pause();
        }

        final homeController = Get.find<HomeController>();
        final pageIndex = homeController.state.pageIndexRx.value;

        /// 这里必须要停顿，否则多重动画会导致 scroller 未挂载视图的错误
        await MyTimer.futureMill(50);
        homeController.pageController.jumpToPage(pageIndex);

        if (pageIndex == 0) {
          final controller = Get.find<MovieController>();
          await MyTimer.futureMill(50);
          controller.scrollController.animateTo(
            controller.offset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }

        break;
      case 1:
        if (shortController.videoPlayerController != null) {
          await shortController.videoPlayerController!.pause();
        }

        final communityController = Get.find<CommunityController>();
        final pageIndex = communityController.state.pageIndexRx.value;

        /// 这里必须要停顿，否则多重动画会导致 scroller 未挂载视图的错误
        await MyTimer.futureMill(50);
        communityController.pageController.jumpToPage(pageIndex);

        break;
      case 2:
        if (shortController.videoPlayerController != null) {
          await shortController.videoPlayerController!.play();
        } else {
          await shortController.videoPlay(
            shortList.value.list[shortController.pageIndex].shortUrl!,
          );
        }
        break;
      default:
        if (shortController.videoPlayerController != null) {
          await shortController.videoPlayerController!.pause();
        }
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CommunityController>(() => CommunityController());
    Get.lazyPut<ShortController>(() => ShortController());
    Get.lazyPut<MyController>(() => MyController());
  }
}
