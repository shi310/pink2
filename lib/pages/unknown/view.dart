import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/unknown/library.dart';

class UnknownView extends GetView<UnknownController> {
  const UnknownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appbar
    var header = MyAppBar(
      isShowLine: true,
      center: MyText.text20('未知页面'),
      left: MyButton.back(),
    );

    /// 页面构成
    return MyScaffold(header: header);
  }
}
