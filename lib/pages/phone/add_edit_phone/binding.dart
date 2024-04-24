import 'package:get/get.dart';
import 'package:pinker/pages/phone/add_edit_phone/controller.dart';

class AddOrEditPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrEditPhoneController>(() => AddOrEditPhoneController());
  }
}
