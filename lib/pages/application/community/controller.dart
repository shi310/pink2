import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/community/cartoon/library.dart';
import 'package:pinker/pages/application/community/drama/library.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/community/movie/library.dart';
import 'package:pinker/pages/application/community/sex/library.dart';

import 'package:pinker/pages/application/community/show/library.dart';

class CommunityController extends GetxController {
  final state = CommunityState();

  final pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<CommunityMovieController>(() => CommunityMovieController());
    Get.lazyPut<CommunityDramaController>(() => CommunityDramaController());
    Get.lazyPut<CommunityCartoomController>(() => CommunityCartoomController());
    Get.lazyPut<CommunitySexController>(() => CommunitySexController());
    Get.lazyPut<CommunityShowController>(() => CommunityShowController());
  }

  void pageChanged(index) => state.pageIndex = index;
}
