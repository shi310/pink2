import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/web_box/library.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebBoxView extends GetView<WebBoxController> {
  const WebBoxView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appbar
    var header = MyAppBar(
      isShowLine: true,
      center: Obx(() => MyText.text18(controller.state.title)),
      left: MyButton.back(onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        await MyTimer.futureMill(300);
        Get.back();
      }),
    );

    Widget bodyBuild() {
      var linearBox = LinearProgressIndicator(
        value: controller.state.progress,
        color: MyColors.primary,
        backgroundColor: MyColors.secondText,
      );

      var emptyBox = Container();

      var webView = const WebBoxView();

      return Stack(
        children: [
          controller.state.webUrl.isEmpty ? linearBox : webView,
          controller.state.progress < 1.0 ? linearBox : emptyBox,
        ],
      );
    }

    /// 页面构成
    return MyScaffold(header: header, body: Obx(bodyBuild));
  }
}
