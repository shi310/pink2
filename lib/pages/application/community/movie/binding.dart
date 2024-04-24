import 'package:get/get.dart';
import 'package:pinker/pages/application/community/movie/library.dart';

class CommunityMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityMovieController>(() => CommunityMovieController());
  }
}
