import 'package:get/get.dart';
import 'package:pinker/pages/notice/library.dart';

class NoticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeController>(() => NoticeController());
  }
}
