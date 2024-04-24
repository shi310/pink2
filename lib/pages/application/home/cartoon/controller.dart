import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/home/cartoon/library.dart';
import 'package:pinker/pages/application/home/library.dart';

class CartoonController extends GetxController {
  final state = CartoonState();

  final homeController = Get.find<HomeController>();
  final pageController = PageController();
  final scrollController = ScrollController();

  double offset = 0.0;

  void onPageChanged(int index) => state.pageIndex = index;

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
