import 'package:get/get.dart';
import 'package:pinker/pages/application/community/cartoon/library.dart';

class CommunityCartoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityCartoomController>(() => CommunityCartoomController());
  }
}
