import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';

class MediaSearch extends StatelessWidget {
  const MediaSearch({
    Key? key,
    required this.resourceData,
  }) : super(key: key);

  final ResourceData resourceData;

  @override
  Widget build(BuildContext context) {
    /// 顶部的类型
    // var title = MyText.gray14(type ?? '其他');

    /// 影片的图片
    var mediaImage = MyImage(
      imageUrl: resourceData.image,
      width: (Get.width - 40) / 3,
      height: ((Get.width - 40) / 3) * 36 / 26,
    );

    /// 影片的名字
    var mediaName = MyText.text18(resourceData.name);

    /// 影片的年份 ｜ 地区 ｜ 子类型
    var yearChildren = [
      if (resourceData.year != null) resourceData.year,
      if (resourceData.year != null) ' | ',
      if (resourceData.country != null) resourceData.country,
      if (resourceData.country != null) ' | ',
      if (resourceData.mediaType != null) resourceData.mediaType,
    ];

    var yearString = MyCharacter.getListToString(yearChildren);

    var mediaInfoChildren = <Widget>[
      mediaName,
      if (resourceData.score != null)
        MyText.primary14('★ ${resourceData.score!}'),
      if (yearChildren.isNotEmpty) MyText.gray14(yearString),
      if (resourceData.actors != null)
        MyText.gray14('演员: ${resourceData.actors!}'),
      if (resourceData.director != null)
        MyText.gray14('导演: ${resourceData.director!}'),
      if (resourceData.introduce != null)
        MyText.gray14('剧情: ${resourceData.introduce!}', maxLines: 2),
      if (resourceData.ranking != null)
        MyText.primary14('排名: ${resourceData.ranking!}'),
    ];

    var mediaInfoChild = Column(
      children: mediaInfoChildren,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    var mediaInfo = Expanded(child: mediaInfoChild);

    // var button = MyIcons.play();

    var bodyRowChildren = [mediaImage, const SizedBox(width: 10), mediaInfo];

    var bodyRow = Row(
      children: bodyRowChildren,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    var bodyChildren = [bodyRow, const SizedBox(height: 16)];

    void _videoPlay() {
      Get.toNamed(MyRoutes.videoPlay, arguments: resourceData);
    }

    var body = MyButton(
      onTap: _videoPlay,
      child: Column(children: bodyChildren),
    );

    return body;
  }
}
