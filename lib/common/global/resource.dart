import 'package:get/get.dart';
import 'package:pinker/common/constant/storage.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/services/librart.dart';

class ResourceController extends GetxController {
  static ResourceController get to => Get.find();

  /// 首页电影数据
  final homeMoiveData = HomeData.fromJson(HomeData.child).obs;
  final movieList = ResourceDataList.fromJson(ResourceDataList.child).obs;
  final movieTypeList = MediaTypeList.fromJson(MediaTypeList.child).obs;

  /// 首页成人影院数据
  final homeSexData = HomeData.fromJson(HomeData.child).obs;
  final sexList = ResourceDataList.fromJson(ResourceDataList.child).obs;
  final sexTypeList = MediaTypeList.fromJson(MediaTypeList.child).obs;

  /// 首页电视剧数据
  final homeDramaData = HomeData.fromJson(HomeData.child).obs;
  final dramaList = ResourceDataList.fromJson(ResourceDataList.child).obs;
  final dramaTypeList = MediaTypeList.fromJson(MediaTypeList.child).obs;

  /// 首页综艺数据
  final homeShowData = HomeData.fromJson(HomeData.child).obs;
  final showList = ResourceDataList.fromJson(ResourceDataList.child).obs;
  final showTypeList = MediaTypeList.fromJson(MediaTypeList.child).obs;

  /// 首页动漫数据
  final homeCartoonData = HomeData.fromJson(HomeData.child).obs;
  final cartoonList = ResourceDataList.fromJson(ResourceDataList.child).obs;
  final cartoonTypeList = MediaTypeList.fromJson(MediaTypeList.child).obs;

  /// 搜索关键字
  String searchWord = '';

  /// 影片类型的名称
  final types = ['电影', '电视剧', '综艺', '动漫', '午夜剧场'];

  /// 收藏记录：ID
  final favoritesId = MyStorageService.to.getList(storageFavoritesIdKey).obs;
  final favoritesList = ResourceDataList.fromJson(ResourceDataList.child).obs;

  /// 热门搜索
  final hotList = ResourceDataList.fromJson(ResourceDataList.child).obs;

  /// 短视频列表
  final shortList = ResourceDataList.fromJson(ResourceDataList.child).obs;

  /// 视频播放
  static void videoPlay(ResourceData resourceData) {
    Get.toNamed(MyRoutes.videoPlay, arguments: resourceData);
  }
}
