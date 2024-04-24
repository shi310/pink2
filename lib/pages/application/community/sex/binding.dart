import 'package:get/get.dart';
import 'package:pinker/pages/application/community/sex/library.dart';

class CommunitySexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunitySexController>(() => CommunitySexController());
  }
}
