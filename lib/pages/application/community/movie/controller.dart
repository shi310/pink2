import 'package:get/get.dart';
import 'package:pinker/common/api/library.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/pages/application/community/movie/library.dart';

class CommunityMovieController extends GetxController {
  final state = CommunityMovieState();
  final type = 1;
  final medias = ResourceController.to.movieList;
  final types = ResourceController.to.movieTypeList;

  List<int> chooseIndex = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  void typesClick(int typeIndex, String typaName, int index) {
    state.isRetry = false;

    chooseIndex[typeIndex] = index;

    state.data.update((val) {
      val!.country = index;
    });
  }

  Future<void> getMedias({
    required int type,
    int? mediaType,
    int? pageNo,
    int? pageSize,
    int? country,
    String? keyword,
    int? year,
    int? sort,
  }) async {
    var _getMedias = await ResourceApi.getResourceList(
      type: type,
      mediaType: mediaType,
      pageNo: pageNo,
      pageSize: pageSize,
      country: country,
      keyword: keyword,
      year: year,
      sort: sort,
    );

    if (_getMedias != null && _getMedias.code == 200) {
      var _medias = ResourceDataList.fromJson(_getMedias.data);

      medias.update((val) {
        val!.list = _medias.list;
        val.size = _medias.size;
      });

      state.isRetry = false;
    } else {
      state.isRetry = true;
    }
  }

  @override
  void onReady() async {
    super.onReady();

    debounce(state.data, (ResourceResponseData value) async {
      medias.update((val) {
        val!.list.clear();
        val.size = 0;
      });

      await getMedias(
        type: value.type,
        mediaType: value.mediaType,
        pageNo: value.pageNo,
        pageSize: value.pageSize,
        country: value.country,
        keyword: value.keyword,
        year: value.year,
        sort: value.sort,
      );
    }, time: const Duration(milliseconds: 1500));
  }
}
