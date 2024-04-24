import 'package:get/get.dart';
import 'package:pinker/pages/area_code/library.dart';

class AreaCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AreaCodeController>(() => AreaCodeController());
  }
}
