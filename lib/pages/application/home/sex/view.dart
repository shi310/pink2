import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';

import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/application/home/sex/library.dart';

class SexView extends GetView<SexController> {
  const SexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 背景部分
    /// 背景是该页面的下层，也就是主要的内容展示区
    /// 因此背景的排版就是页面的排版
    /// 下方是背景部分的banner顶层的播放按钮和文字
    /// 下方是背景部分：banner的组合

    final _data = ResourceController.to.homeSexData;

    Widget itemBuilder(context, index) {
      var banner = HomeBanner(
        imageUrl: _data.value.banner[index].image,
        title: _data.value.banner[index].title,
      );

      return banner;
    }

    var bannerPage = PageView.builder(
      itemBuilder: itemBuilder,
      itemCount: _data.value.banner.length,
      onPageChanged: controller.onPageChanged,
      controller: controller.pageController,
      scrollDirection: Axis.horizontal,
    );

    var bannerPageBox = SizedBox(height: 480, child: bannerPage);

    const noChanceDecoration = BoxDecoration(
      color: MyColors.text,
      borderRadius: MyStyle.borderRadius,
    );

    var noChance = Container(
      width: 8,
      height: 8,
      decoration: noChanceDecoration,
    );

    const chanceDecoration = BoxDecoration(
      color: MyColors.primary,
      borderRadius: MyStyle.borderRadius,
    );

    var chance = Container(
      width: 16,
      height: 8,
      decoration: chanceDecoration,
    );

    Widget toElement(int index) {
      var children = [
        Obx(() => index == controller.state.pageIndex ? chance : noChance),
        if (index < _data.value.banner.length - 1) const SizedBox(width: 10),
        if (index == _data.value.banner.length - 1) const SizedBox(width: 20),
      ];
      return Row(children: children);
    }

    var indexBox = Row(
      children: _data.value.banner.asMap().keys.map(toElement).toList(),
      mainAxisAlignment: MainAxisAlignment.end,
    );

    var bannerBox = Stack(
      children: [bannerPageBox, Positioned(child: indexBox, bottom: 28)],
      alignment: AlignmentDirectional.bottomEnd,
    );

    var bodyChildren = [
      bannerBox,
      for (int i = 0; i < _data.value.medias.length; i++)
        MediaBox(
          mediaDataList: _data.value.medias[i].list,
          title: _data.value.medias[i].title,
        )
    ];

    var bodyChild = ListView(
      children: bodyChildren,
      controller: controller.scrollController,
    );

    var body = Container(child: bodyChild, color: MyColors.background);

    // Widget obxBuild() {
    //   return controller.state.title.isEmpty ? lottie : body;
    // }

    return body;
  }
}
