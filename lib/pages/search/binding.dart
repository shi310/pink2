import 'package:get/get.dart';
import 'package:pinker/pages/search/library.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchViewController>(() => SearchViewController());
  }
}
