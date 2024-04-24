import 'package:get/get.dart';
import 'package:pinker/pages/web_box/library.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// 页面传参
class WebBoxArguments {
  WebBoxArguments({
    required this.title,
    required this.url,
  });

  // 导航栏标题
  String title;
  // url
  String url;
}

class WebBoxController extends GetxController {
  final state = WebBoxState();
  final WebBoxArguments arguments = Get.arguments;

  void onProgress(int progress) {
    state.progress = progress / 100;
  }

  @override
  void onInit() {
    // if (GetPlatform.isAndroid) WebView.platform = AndroidWebView();
    super.onInit();
  }

  @override
  void onReady() {
    state.title = arguments.title;
    state.webUrl = arguments.url;
    super.onReady();
  }
}
