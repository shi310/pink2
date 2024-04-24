import 'package:get/get.dart';
import 'package:pinker/pages/application/community/drama/library.dart';

class CommunityDramaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityDramaController>(() => CommunityDramaController());
  }
}
