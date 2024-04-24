import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/home/library.dart';

import 'package:pinker/pages/application/home/show/library.dart';

class ShowController extends GetxController {
  final state = ShowState();
  final scrollController = ScrollController();
  final pageController = PageController();
  final homeController = Get.find<HomeController>();

  void onPageChanged(int index) => state.pageIndex = index;
  double offset = 0.0;

  @override
  void onReady() {
    scrollController.addListener(() {
      offset = scrollController.offset;

      homeController.state.opacity = scrollController.offset / 10;
      if (homeController.state.opacity > 1.0) {
        homeController.state.opacity = 1.0;
      } else {
        homeController.state.opacity = 0.0;
      }
    });
    super.onReady();
  }
}
