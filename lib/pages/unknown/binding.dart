import 'package:get/get.dart';
import 'package:pinker/pages/unknown/library.dart';

class UnknownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnknownController>(() => UnknownController());
  }
}
