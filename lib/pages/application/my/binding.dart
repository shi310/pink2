import 'package:get/get.dart';

import 'package:pinker/pages/application/my/library.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
  }
}
