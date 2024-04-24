import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';

class MediaHot extends StatelessWidget {
  const MediaHot({
    Key? key,
    required this.resourceData,
  }) : super(key: key);

  final ResourceData resourceData;

  @override
  Widget build(BuildContext context) {
    var left = MyImage(
      imageUrl: resourceData.image,
      width: 150,
      height: 100,
      borderRadius: BorderRadius.zero,
    );

    var nameBox = MyText(resourceData.name);

    /// 影片的年份 ｜ 地区 ｜ 子类型
    var yearChildren = [
      if (resourceData.year != null) resourceData.year,
      if (resourceData.year != null) ' | ',
      if (resourceData.country != null) resourceData.country,
      if (resourceData.country != null) ' | ',
      if (resourceData.mediaType != null) resourceData.mediaType,
    ];

    var yearString = MyCharacter.getListToString(yearChildren);

    var centerChildren = [
      const SizedBox(height: 8),
      nameBox,
      if (resourceData.introduction != null)
        MyText.gray14(resourceData.introduction!),
      const Spacer(),
      if (yearString.isNotEmpty) MyText.gray14(yearString)
    ];

    var sizedColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: centerChildren,
    );

    var center = SizedBox(height: 90, child: sizedColumn);

    var leftRowChildren = [
      left,
      const SizedBox(width: 10),
      Expanded(child: center),
    ];

    var leftRow = Row(children: leftRowChildren);

    var bodyChildren = [
      Expanded(child: leftRow),
      const SizedBox(width: 16),
      MyIcons.play(size: 24),
      const SizedBox(width: 16),
    ];

    void _videoPlay() {
      Get.toNamed(MyRoutes.videoPlay, arguments: resourceData);
    }

    var bodyButton = MyButton(
      child: Row(children: bodyChildren),
      onTap: _videoPlay,
      color: MyColors.appBar,
    );

    var columnChildren = [bodyButton, const SizedBox(height: 16)];

    return Column(children: columnChildren);
  }
}
