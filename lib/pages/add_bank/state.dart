import 'package:get/get.dart';

class AddBankState {
  /// 按钮是否禁用
  final _isEnable = true.obs;
  set isEnable(bool value) => _isEnable.value = value;
  bool get isEnable => _isEnable.value;
}
