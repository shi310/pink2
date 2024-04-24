import 'package:get/get.dart';

class AddOrEditPhoneState {
  /// 是否禁用按钮
  final _isEnable = true.obs;
  set isEnable(bool value) => _isEnable.value = value;
  bool get isEnable => _isEnable.value;
}
