import 'package:get/get.dart';
import 'package:pinker/pages/phone/library.dart';

class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneController>(() => PhoneController());
  }
}
