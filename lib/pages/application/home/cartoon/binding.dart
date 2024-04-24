import 'package:get/get.dart';
import 'package:pinker/pages/application/home/cartoon/library.dart';

class CartoonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartoonController>(() => CartoonController());
  }
}
