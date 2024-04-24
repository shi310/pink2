import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/home/sex/library.dart';

class SexController extends GetxController {
  final state = SexState();
  final HomeController homeController = Get.find();
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
