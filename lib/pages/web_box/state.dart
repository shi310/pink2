import 'package:get/get.dart';

class WebBoxState {
  /// title
  final _title = ''.obs;
  set title(String value) => _title.value = value;
  String get title => _title.value;

  /// 网页地址
  final _webUrl = ''.obs;
  set webUrl(String value) => _webUrl.value = value;
  String get webUrl => _webUrl.value;

  /// 进度
  final _progress = 0.1.obs;
  set progress(double value) => _progress.value = value;
  double get progress => _progress.value;
}
