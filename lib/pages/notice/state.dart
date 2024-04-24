import 'package:get/get.dart';

class NoticeState {
  /// 按钮是否禁用
  final _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
