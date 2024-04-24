import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/data/resource_data.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/widgets/library.dart';

class MediaBox extends StatelessWidget {
  const MediaBox({
    Key? key,
    this.title,
    required this.mediaDataList,
    this.onTap,
  }) : super(key: key);

  final String? title;
  final List<ResourceData> mediaDataList;
  final void Function(ResourceData resourceData)? onTap;

  @override
  Widget build(BuildContext context) {
    Widget mediaBox = const SizedBox();
    Widget titleBox(String text) {
      /// 影片阵列
      /// 影片的分类标题
      var title = MyText.text18(text);
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: title,
      );
    }

    Widget mediaColumn(ResourceData resourceData) {
      /// 影片的图片
      var movieImage = MyImage(
        imageUrl: resourceData.image,
        width: double.infinity,
        height: ((Get.width - 40) / 3) * 36 / 26,
      );

      /// 影片的图片、名称、说明文字的组装
      var children = [
        movieImage,
        const SizedBox(height: 10),
        MyText(resourceData.name),
        if (resourceData.introduction != null)
          MyText.gray14(resourceData.introduction!)
      ];

      /// 返回
      var child = Column(
        children: children,
        crossAxisAlignment: CrossAxisAlignment.start,
      );

      void _onTap() {
        if (onTap != null) {
          onTap!(resourceData);
        } else {
          Get.toNamed(MyRoutes.videoPlay, arguments: resourceData);
        }
      }

      return MyButton(
        child: child,
        onTap: _onTap,
      );
    }

    /// 空白的影片展位空间
    const emptyBox = SizedBox(width: double.infinity);

    /// 空白的影片展位空间 - 自适应宽度
    const emptyBoxExpended = Expanded(child: emptyBox);

    /// 影片的内容，二次封装
    Widget content(int index) {
      var child = mediaColumn(mediaDataList[index]);
      return Expanded(child: child);
    }

    var length = mediaDataList.length;
    const space = SizedBox(width: 10);

    /// 根据传入的数据，组成想要的排列
    /// 这个方法是这个组件的核心
    Widget column(int index) {
      var row = Row(
        children: [
          space,
          index * 3 < length ? content(index * 3) : emptyBoxExpended,
          space,
          index * 3 + 1 < length ? content(index * 3 + 1) : emptyBoxExpended,
          space,
          index * 3 + 2 < length ? content(index * 3 + 2) : emptyBoxExpended,
          space,
        ],
      );
      return Column(
        children: [
          row,
          // if (index + 1 < (length / 3).ceil()) const SizedBox(height: 20)
          const SizedBox(height: 20)
        ],
      );
    }

    mediaBox = Column(
      children: [for (int i = 0; i < (length / 3).ceil(); i++) column(i)],
    );

    var bodyChildren = [
      if (title != null) const SizedBox(height: 20),
      if (title != null) titleBox(title!),
      const SizedBox(height: 20),
      mediaBox,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bodyChildren,
    );
  }
}
