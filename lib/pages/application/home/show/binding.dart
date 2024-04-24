import 'package:get/get.dart';
import 'package:pinker/pages/application/home/show/library.dart';

class ShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowController>(() => ShowController());
  }
}
