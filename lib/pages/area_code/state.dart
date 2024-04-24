import 'package:get/get.dart';
import 'package:pinker/common/data/library.dart';

class AreaCodeState {
  /// 检索后，用来显示的列表
  final RxList<AreaCodeData> _showList =
      [AreaCodeData.fromJson(AreaCodeData.child)].obs;
  set showList(List<AreaCodeData> value) => _showList;
  List<AreaCodeData> get showList => _showList;

  /// 字符串检索
  final RxString searchRx = ''.obs;
  set searchValue(String value) => searchRx.value = value;
  String get searchValue => searchRx.value;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
