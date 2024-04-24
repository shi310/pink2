import 'package:get/get.dart';

class ShortState {
  /// 是否展示视频正在加载的状态
  final _isShowLoading = true.obs;
  set isShowLoading(bool value) => _isShowLoading.value = value;
  bool get isShowLoading => _isShowLoading.value;
}
