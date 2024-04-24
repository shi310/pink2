import 'package:get/get.dart';
import 'package:pinker/common/constant/storage.dart';
import 'package:pinker/common/data/resource_data.dart';
import 'package:pinker/common/services/storage.dart';

class SearchState {
  /// 搜索结果，这里是一个影片列表
  final resault = ResourceDataList.fromJson(ResourceDataList.child).obs;

  /// 搜索历史，是一组字符串
  final _history = MyStorageService.to.getList(storageSearchHistoryKey).obs;
  set history(List<String> value) => _history.value = value;
  List<String> get history => _history;

  /// 是否展示loading
  final _isShowLoading = false.obs;
  set isShowLoading(bool value) => _isShowLoading.value = value;
  bool get isShowLoading => _isShowLoading.value;

  /// 是否显示结果
  final _isShowResault = false.obs;
  set isShowResault(bool value) => _isShowResault.value = value;
  bool get isShowResault => _isShowResault.value;

  /// 是否正在重试
  final _isRetryHot = false.obs;
  set isRetryHot(bool value) => _isRetryHot.value = value;
  bool get isRetryHot => _isRetryHot.value;

  /// 结果是否需要重试：搜索失败的时候会展示重试按钮
  final _isRetryResault = false.obs;
  set isRetryResault(bool value) => _isRetryResault.value = value;
  bool get isRetryResault => _isRetryResault.value;

  /// 页面的滑动距离
  final offsetRx = 0.0.obs;
}
