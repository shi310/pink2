import 'package:get/get.dart';
import 'package:pinker/pages/application/community/library.dart';

class CommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityController>(() => CommunityController());
  }
}
