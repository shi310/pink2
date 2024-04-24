import 'package:get/get.dart';
import 'package:pinker/pages/add_bank/library.dart';

class AddBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankController>(() => AddBankController());
  }
}
