import 'package:get/get.dart';

import 'package:pinker/pages/application/home/movie/library.dart';

class MovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController());
  }
}
