import 'package:get/get.dart';
import 'package:pinker/pages/edit_password/library.dart';

class EditPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPasswordController>(() => EditPasswordController());
  }
}
