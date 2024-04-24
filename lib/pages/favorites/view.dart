import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/favorites/library.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    var header = MyAppBar(
      isShowLine: true,
      left: MyButton.back(),
      center: const MyText('收藏夹'),
    );

    Widget obxBuild() {
      /// 有结果的状态
      var listChildren = ResourceController.to.favoritesList.value.list
          .map((e) => MediaHot(resourceData: e))
          .toList();

      /// 暂无数据的文字
      const noDataText = MyText(
        '暂无数据',
        textAlign: TextAlign.center,
        color: MyColors.secondText,
      );

      /// 没有数据的状态
      var noDataChildren = [
        const SizedBox(height: 20),
        MyIcons.error(),
        const SizedBox(height: 10),
        noDataText,
      ];

      /// 根据条件动态组成
      var children = ResourceController.to.favoritesList.value.list.isEmpty
          ? noDataChildren
          : listChildren;

      /// listview
      return MyListView(
        children: children,
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      );
    }

    /// 返回带有安全区域的listview
    var body = Obx(obxBuild);

    return MyScaffold(header: header, body: body);
  }
}
