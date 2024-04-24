import 'package:get/get.dart';
import 'package:pinker/pages/add_usdt/library.dart';

class AddUsdtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUsdtController>(() => AddUsdtController());
  }
}
