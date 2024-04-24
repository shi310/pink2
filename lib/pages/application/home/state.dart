import 'package:get/get.dart';
import 'package:pinker/common/data/library.dart';

class HomeState {
  final _opacity = 0.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  final noticeList = NoticeList.fromJson(NoticeList.child).obs;

  final _isRead = false.obs;
  set isRead(bool value) => _isRead.value = value;
  bool get isRead => _isRead.value;

  final pageIndexRx = 0.obs;
}
