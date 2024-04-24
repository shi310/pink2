import 'package:get/get.dart';
import 'package:pinker/pages/video_play/library.dart';

class VideoPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayController>(() => VideoPlayController());
  }
}
