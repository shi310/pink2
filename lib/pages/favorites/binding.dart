import 'package:get/get.dart';
import 'package:pinker/pages/favorites/library.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() => FavoritesController());
  }
}
