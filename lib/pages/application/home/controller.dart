import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/library.dart';
import 'package:pinker/common/constant/library.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/user.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/services/librart.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/pages/application/home/cartoon/library.dart';
import 'package:pinker/pages/application/home/drama/library.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/home/movie/library.dart';
import 'package:pinker/pages/application/home/sex/library.dart';
import 'package:pinker/pages/application/home/show/library.dart';

class HomeController extends GetxController {
  final state = HomeState();
  final pageController = PageController();

  void onRead() {
    state.isRead = false;

    for (var i in state.noticeList.value.noticeList) {
      var isAlredRead = false;
      var noticeHaveReadId = MyStorageService.to.getList(storageNoticesIdKey);

      for (var j in noticeHaveReadId) {
        if (i.id.toString() == j) {
          isAlredRead = true;
          break;
        }
      }

      if (!isAlredRead) {
        state.isRead = true;
        break;
      }
    }
  }

  Future<void> getNoiiceList() async {
    var getNoiiceList = await PublicApi.getNoticeList();

    if (getNoiiceList != null && getNoiiceList.code == 200) {
      state.noticeList.value = NoticeList.fromJson(getNoiiceList.data);
      state.noticeList.update((val) {});
    }

    onRead();
  }

  void pageChanged(int index) async {
    state.pageIndexRx.value = index;

    /// 这里必须要停顿，否则多重动画会导致 scroller 未挂载视图的错误
    await MyTimer.futureMill(50);

    /// 这里处理页面的位置保活
    switch (index) {
      case 0:
        final controller = Get.find<MovieController>();
        state.opacity = controller.offset / 10;
        if (state.opacity > 1.0) {
          state.opacity = 1.0;
        } else {
          state.opacity = 0.0;
        }
        controller.scrollController.animateTo(
          controller.offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        break;
      case 1:
        final controller = Get.find<DramaController>();
        state.opacity = controller.offset / 10;
        if (state.opacity > 1.0) {
          state.opacity = 1.0;
        } else {
          state.opacity = 0.0;
        }
        controller.scrollController.animateTo(
          controller.offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        break;
      case 2:
        final controller = Get.find<ShowController>();
        state.opacity = controller.offset / 10;
        if (state.opacity > 1.0) {
          state.opacity = 1.0;
        } else {
          state.opacity = 0.0;
        }
        controller.scrollController.animateTo(
          controller.offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        break;
      case 3:
        final controller = Get.find<CartoonController>();
        state.opacity = controller.offset / 10;
        if (state.opacity > 1.0) {
          state.opacity = 1.0;
        } else {
          state.opacity = 0.0;
        }
        controller.scrollController.animateTo(
          controller.offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        break;
      default:
        final controller = Get.find<SexController>();
        state.opacity = controller.offset / 10;
        if (state.opacity > 1.0) {
          state.opacity = 1.0;
        } else {
          state.opacity = 0.0;
        }
        controller.scrollController.animateTo(
          controller.offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        break;
    }
  }

  void search() {
    Get.toNamed(MyRoutes.search);
  }

  @override
  void onReady() {
    log('用户token: ${UserController.to.token}');
    getNoiiceList();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<MovieController>(() => MovieController());
    Get.lazyPut<DramaController>(() => DramaController());
    Get.lazyPut<CartoonController>(() => CartoonController());
    Get.lazyPut<SexController>(() => SexController());
    Get.lazyPut<ShowController>(() => ShowController());
  }
}
