import 'package:get/get.dart';

import 'package:pinker/pages/bank/library.dart';

class BankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankController>(() => BankController());
  }
}
