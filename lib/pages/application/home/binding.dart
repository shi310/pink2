import 'package:get/get.dart';
import 'package:pinker/pages/application/home/library.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
