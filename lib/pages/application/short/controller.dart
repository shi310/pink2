import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/application/short/library.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ShortController extends GetxController {
  final state = ShortState();
  final shortList = ResourceController.to.shortList;
  final ApplicationController applicationController = Get.find();

  int pageIndex = 0;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  // final customControls = const CupertinoControls(
  //   backgroundColor: MyColors.input,
  //   iconColor: MyColors.text,
  // );

  Future<void> videoPlay(String url) async {
    if (videoPlayerController != null) {
      await videoPlayerController!.dispose();
      videoPlayerController = null;
      if (chewieController != null) {
        chewieController!.dispose();
        chewieController = null;
      }
    }

    state.isShowLoading = true;
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController!.initialize();

    if (videoPlayerController!.value.isInitialized) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: true,
        customControls: Container(),
      );

      state.isShowLoading = false;
    } else {
      videoPlayerController!.dispose();
      videoPlayerController = null;
    }
  }

  void onPageChanged(int index) async {
    pageIndex = index;
    await videoPlay(shortList.value.list[index].shortUrl!);
  }

  @override
  void onReady() {
    super.onReady();
    WakelockPlus.enable();
  }
}
