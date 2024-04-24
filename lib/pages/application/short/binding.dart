import 'package:get/get.dart';
import 'package:pinker/pages/application/short/library.dart';

class ShortBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortController>(() => ShortController());
  }
}
