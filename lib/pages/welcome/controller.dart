import 'package:get/get.dart';
import 'package:pinker/common/api/library.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/welcome/library.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();

  /// 获取用户信息
  Future<void> getUserInfo() async {
    /// 调用获取用户信息的接口
    var _getUserInfo = await UserApi.getUserInfo(
      errorCallBack: MyDialog.getErrorDaliog,
    );

    /// 请求成功
    if (_getUserInfo != null && _getUserInfo.code == 200) {
      /// 格式化获取到的数据
      var userInfo = UserInfo.fromJson(_getUserInfo.data);

      /// 更新数据
      UserController.to.userInfo.value = userInfo;
      UserController.to.userInfo.update((val) {});
    }

    /// 请求失败
    else {
      await getUserInfo(); // 重新请求
    }
  }

  /// 获取热门搜索的数据
  Future<void> getHotList() async {
    /// 开始调用接口
    var _getHotList = await ResourceApi.getResourceList(
      pageNo: 1,
      type: 0,
      pageSize: 20,
      sort: 4,
      errorCallBack: MyDialog.getErrorDaliog,
    );

    /// 数据获取成功
    if (_getHotList != null && _getHotList.code == 200) {
      /// 格式化获取到的数据
      var hotList = ResourceDataList.fromJson(_getHotList.data);

      /// 更新数据
      ResourceController.to.hotList.update((val) {
        val!.list = hotList.list;
        val.size = hotList.size;
      });
    }

    /// 数据获取失败
    else {
      await getHotList();
    }
  }

  /// 获取影片的数据
  /// 根据ID获取
  Future<void> getFavorites() async {
    if (ResourceController.to.favoritesId.isNotEmpty) {
      for (var item in ResourceController.to.favoritesId) {
        int id = int.fromEnvironment(item);
        var getResourceData = await ResourceApi.getResourceData(
          id: id,
          errorCallBack: MyDialog.getErrorDaliog,
        );

        if (getResourceData != null && getResourceData.code == 200) {
          var resourceData = ResourceData.fromJson(getResourceData.data);

          ResourceController.to.favoritesList.update((val) {
            val!.list.add(resourceData);
            val.size += 1;
          });
        } else {
          ResourceController.to.favoritesList.update((val) {
            val!.list.clear();
            val.size = 0;
          });
          getFavorites();
        }
      }
    }
  }

  /// 获取分类的信息
  Future<void> getMediaList() async {
    /// 调用获取影片列表的接口
    var _getMediaList = await ResourceApi.getResourceList(
      pageNo: 1,
      type: 6,
      pageSize: 20,
      errorCallBack: MyDialog.getErrorDaliog,
    );

    /// 请求失败拦截：重新调用接口方法
    if (_getMediaList != null && _getMediaList.code == 200) {
      /// 格式化获取到的影片数据
      var _mediaList = ResourceDataList.fromJson(_getMediaList.data);

      /// 更新影片数据
      ResourceController.to.shortList.update((val) {
        val!.list = _mediaList.list;
        val.size = _mediaList.size;
      });
    } else {
      await getMediaList();
    }
  }

  /// 获取搜索关键字
  Future<void> getSearchWord() async {
    /// 调用获取搜索关键字接口
    var _getSearchWord = await HomeApi.getSearchWord(
      errorCallBack: MyDialog.getErrorDaliog,
    );

    /// 请求成功
    if (_getSearchWord != null && _getSearchWord.code == 200) {
      /// 格式化获取到的数据
      var searchWord = SearchWordData.fromJson(_getSearchWord.data);

      /// 更新数据
      ResourceController.to.searchWord = searchWord.searchWord;
    }

    /// 请求失败
    else {
      await getSearchWord(); // 重新请求
    }
  }

  /// 获取分类的信息
  Future<void> getData({
    required int type,
    required Rx<HomeData> homeDataRx,
    required Rx<ResourceDataList> mediaListRx,
    required Rx<MediaTypeList> mediaTypeListRx,
  }) async {
    /// 调用获取首页信息的接口：包括banner等信息,影片的标题和列表数据
    var _getHomeData = await HomeApi.getHomeData(
      type: type,
      errorCallBack: MyDialog.getErrorDaliog,
    );

    /// 请求成功
    if (_getHomeData != null && _getHomeData.code == 200) {
      /// 格式化获取到的首页数据
      var homeData = HomeData.fromJson(_getHomeData.data);

      /// 更新首页数据
      homeDataRx.update((val) {
        val!.banner = homeData.banner;
        val.medias = homeData.medias;
      });
    } else {
      await getData(
        type: type,
        homeDataRx: homeDataRx,
        mediaListRx: mediaListRx,
        mediaTypeListRx: mediaTypeListRx,
      );
    }

    /// 调用获取影片列表的接口
    var _getMediaList = await ResourceApi.getResourceList(
      pageNo: 1,
      type: type,
      pageSize: 20,
      errorCallBack: MyDialog.getErrorDaliog,
    );

    /// 请求失败拦截：重新调用接口方法
    if (_getMediaList != null && _getMediaList.code == 200) {
      /// 格式化获取到的影片数据
      var mediaList = ResourceDataList.fromJson(_getMediaList.data);

      /// 更新影片数据
      mediaListRx.update((val) {
        val!.list = mediaList.list;
        val.size = mediaList.size;
      });
    } else {
      await getData(
        type: type,
        homeDataRx: homeDataRx,
        mediaListRx: mediaListRx,
        mediaTypeListRx: mediaTypeListRx,
      );
    }

    /// 调用获取电影类目的检索类型
    var _getResourceType = await ResourceApi.getResourceType(
      type: type,
      errorCallBack: MyDialog.getErrorDaliog,
    );

    if (_getResourceType != null && _getResourceType.code == 200) {
      var types = MediaTypeList.fromJson(_getResourceType.data);

      mediaTypeListRx.update((val) {
        val!.list = types.list;
        val.size = types.size;
      });
    } else {
      await getData(
        type: type,
        homeDataRx: homeDataRx,
        mediaListRx: mediaListRx,
        mediaTypeListRx: mediaTypeListRx,
      );
    }
  }

  @override
  void onReady() async {
    super.onReady();

    /// 获取首页电影的banner信息和影片列表
    /// 获取发现页面的检索类型和初始化影片列表
    await getData(
      type: 1,
      homeDataRx: ResourceController.to.homeMoiveData,
      mediaListRx: ResourceController.to.movieList,
      mediaTypeListRx: ResourceController.to.movieTypeList,
    );

    /// 进度条更新
    state.loadingValue = 0.1;

    /// 获取首页电视剧的banner信息和影片列表
    /// 获取发现页面的检索类型和初始化影片列表
    await getData(
      type: 2,
      homeDataRx: ResourceController.to.homeDramaData,
      mediaListRx: ResourceController.to.dramaList,
      mediaTypeListRx: ResourceController.to.dramaTypeList,
    );

    /// 进度条更新
    state.loadingValue = 0.2;

    /// 获取首页综艺的banner信息和影片列表
    await getData(
      type: 3,
      homeDataRx: ResourceController.to.homeShowData,
      mediaListRx: ResourceController.to.showList,
      mediaTypeListRx: ResourceController.to.showTypeList,
    );

    /// 进度条更新
    state.loadingValue = 0.3;

    /// 获取首页卡通的banner信息和影片列表
    await getData(
      type: 4,
      homeDataRx: ResourceController.to.homeCartoonData,
      mediaListRx: ResourceController.to.cartoonList,
      mediaTypeListRx: ResourceController.to.cartoonTypeList,
    );

    /// 进度条更新
    state.loadingValue = 0.4;

    /// 获取首页成人的banner信息和影片列表
    await getData(
      type: 5,
      homeDataRx: ResourceController.to.homeSexData,
      mediaListRx: ResourceController.to.sexList,
      mediaTypeListRx: ResourceController.to.sexTypeList,
    );

    /// 进度条更新
    state.loadingValue = 0.5;

    /// 获取搜索关键词
    await getSearchWord();

    /// 进度条更新
    state.loadingValue = 0.6;

    await getHotList();

    /// 进度条更新
    state.loadingValue = 0.7;

    /// 如果存在token，则请求用户数据
    if (UserController.to.token != '') await getUserInfo();

    /// 进度条更新
    state.loadingValue = 0.8;

    /// 获取收藏的推文数组
    await getFavorites();

    /// 进度条更新
    state.loadingValue = 0.9;

    await getMediaList();

    /// 进度条更新
    state.loadingValue = 1;

    /// 请求完成，进入首页
    Get.offAllNamed(MyRoutes.application);
  }
}
