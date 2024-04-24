import 'package:get/get.dart';
import 'package:pinker/pages/application/home/sex/library.dart';

class SexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SexController>(() => SexController());
  }
}
