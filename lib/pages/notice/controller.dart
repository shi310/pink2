import 'package:get/get.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/notice/library.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NoticeController extends GetxController {
  final state = NoticeState();
  final homeController = Get.find<HomeController>();
  final refreshController = RefreshController();

  void onRefresh() async {
    await homeController.getNoiiceList();
    refreshController.refreshCompleted();
  }
}
