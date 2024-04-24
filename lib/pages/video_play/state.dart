import 'package:get/get.dart';
import 'package:pinker/common/data/library.dart';

class VideoPlayState {
  /// 是否展示视频正在加载的状态
  final _isShowLoading = true.obs;
  set isShowLoading(bool value) => _isShowLoading.value = value;
  bool get isShowLoading => _isShowLoading.value;

  /// 是否需要重试
  final _isRetry = false.obs;
  set isRetry(bool value) => _isRetry.value = value;
  bool get isRetry => _isRetry.value;

  /// 页面控制器
  final pageIndex = 0.obs;

  /// 按钮是否被选中的状态控制器
  final _chooise = [0, 0].obs;
  set chooise(List<int> value) => _chooise.value = value;
  List<int> get chooise => _chooise;

  /// 影片列表
  final resourceList = ResourceDataList.fromJson(ResourceDataList.child).obs;

  /// 当前没播放的影片数据
  final resourceData = ResourceData.fromJson(ResourceData.child).obs;
}
