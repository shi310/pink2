import 'package:get/get.dart';
import 'package:pinker/pages/application/community/show/library.dart';

class CommunityShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityShowController>(() => CommunityShowController());
  }
}
