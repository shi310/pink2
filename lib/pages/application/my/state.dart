import 'package:get/get.dart';

class MyState {
  final _opacity = 0.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  final _scrollOffset = 0.0.obs;
  set scrollOffset(double value) => _scrollOffset.value = value;
  double get scrollOffset => _scrollOffset.value;
}
