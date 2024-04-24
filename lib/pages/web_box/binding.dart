import 'package:get/get.dart';
import 'package:pinker/pages/web_box/library.dart';

class WebBoxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebBoxController>(() => WebBoxController());
  }
}
