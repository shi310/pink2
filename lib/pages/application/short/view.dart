import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/routes/library.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/application/short/library.dart';

class ShortView extends GetView<ShortController> {
  const ShortView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    final shortList = ResourceController.to.shortList;

    Widget itemBuilder(BuildContext context, int index) {
      /// 加载动画
      var lottie = MyIcons.lottie('image_holder', fit: BoxFit.fill);

      /// 视频的封面图
      var videoImage = Obx(() {
        var imageBox = MyImage(
          imageUrl: shortList.value.list[index].image,
          borderRadius: BorderRadius.zero,
        );
        return shortList.value.list[index].image.isEmpty ? lottie : imageBox;
      });

      /// 视频区的遮罩，主要是遮住封面图
      var mark = Container(color: Colors.black54);

      /// 视频加载动画只需要 0.5 的透明度，这里是处理透明度的
      var lottieOpcaty = Opacity(opacity: 0.5, child: lottie);

      /// 加载中的组成部分
      var loadingContentChildren = <Widget>[
        MyIcons.loading(),
        const SizedBox(height: 20),
        const MyText('精彩即将开始...'),
        const SizedBox(height: 8),
        MyText.gray16('(影片加载中无法切换视频)'),
      ];

      /// 加载中：精彩即将开始。。。
      var loadingContent = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: loadingContentChildren,
      );

      /// 加载中的组成方式：
      /// 封面图放最底下
      /// 遮罩罩住封面图
      /// 加载动画
      /// 最后把加载中放到顶层
      var loadingBox = Stack(children: [
        Positioned(child: videoImage, top: 0, left: 0, bottom: 0, right: 0),
        Positioned(child: mark, top: 0, left: 0, bottom: 0, right: 0),
        Positioned(child: lottieOpcaty, top: 0, left: 0, bottom: 0, right: 0),
        loadingContent,
      ]);

      /// 如果在加载中，那就是展示加载的样式
      /// 如果是在播放，那就展示播放的内容
      var videoBoxChild = Obx(() =>
          state.isShowLoading || controller.chewieController == null
              ? loadingBox
              : Chewie(controller: controller.chewieController!));

      /// 播放区的样式
      const videoBoxChildDecortion = BoxDecoration(
        shape: BoxShape.rectangle,
        color: MyColors.black,
      );

      /// 下方开始是影片的信息部分
      /// 影片的标题，采用24dp的大小
      var title = Obx(() => MyText.text24(shortList.value.list[index].name));

      var _value = shortList.value.list[index];

      /// 影片的年份 ｜ 地区 ｜ 子类型
      var yearChildren = [
        if (_value.score != null) '★ ${_value.score!}',
        if (_value.score != null) ' | ',
        if (_value.year != null) _value.year,
        if (_value.year != null) ' | ',
        if (_value.country != null) _value.country,
        if (_value.country != null) ' | ',
        if (_value.mediaType != null) _value.mediaType,
        if (_value.mediaType != null) ' | ',
        if (_value.ranking != null) '排名: ${_value.ranking!}'
      ];

      /// 年份那一排文字转成字符串
      var yearChildrenString = MyCharacter.getListToString(yearChildren);

      /// 收藏部分组件：喜欢构建
      // Widget _likeBuilder(bool _) => _ ? MyIcons.likePress() : MyIcons.like();

      // bool isFavorites = false;
      // for (var data in ResourceController.to.favoritesId) {
      //   if (data == shortList.value.list[index].id.toString()) {
      //     isFavorites = true;
      //   }
      // }

      /// 收藏控件组件：内容组件
      // Widget _countBuilder(int? count, bool isLiked, String text) {
      //   return MyText.gray14(isFavorites ? '已收藏' : '收藏');
      // }

      // Future<bool> _onFavorites(bool value) async {
      //   isFavorites = !isFavorites;
      //   var favoritesId = ResourceController.to.favoritesId;

      //   if (isFavorites) {
      //     favoritesId.add(shortList.value.list[index].id.toString());
      //     ResourceController.to.favoritesList.update((val) {
      //       val!.list.add(shortList.value.list[index]);
      //       val.size += 1;
      //     });
      //   } else {
      //     favoritesId.remove(shortList.value.list[index].id.toString());
      //     ResourceController.to.favoritesList.update((val) {
      //       val!.list.remove(shortList.value.list[index]);
      //       val.size -= 1;
      //     });
      //   }

      //   MyStorageService.to.setList(storageFavoritesIdKey, favoritesId);
      //   return isFavorites;
      // }

      /// 收藏控件
      // var favorites = LikeButton(
      //   onTap: _onFavorites,
      //   size: 20,
      //   isLiked: isFavorites,
      //   likeCountPadding: const EdgeInsets.only(left: 8),
      //   likeCount: 0,
      //   likeBuilder: _likeBuilder,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   countBuilder: _countBuilder,
      //   likeCountAnimationType: LikeCountAnimationType.part,
      // );

      var playButton = MyButton(
        onTap: () async {
          if (controller.videoPlayerController != null) {
            await controller.videoPlayerController!.pause();

            await Get.toNamed(MyRoutes.videoPlay,
                arguments: shortList.value.list[index]);

            await controller.videoPlayerController!.play();
          }
        },
        child: const MyText('查看完整版'),
        color: MyColors.primary,
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      );

      /// 影片介绍部分的综合组成
      /// 标题 和 收藏
      /// 影片介绍
      /// 播放地址
      var contentBoxChildren = [
        /// 第一部分：影片的标题和收藏按钮
        Row(children: [title, const Spacer(), playButton]),

        /// 间距
        const SizedBox(height: 8),

        /// 年份信息，包含评分，年份等信息
        if (yearChildren.isNotEmpty) MyText.gray14(yearChildrenString),

        /// 影片的演员表
        if (shortList.value.list[index].actors != null)
          MyText.gray14('演员: ${shortList.value.list[index].actors!}'),

        /// 影片的导演
        if (shortList.value.list[index].director != null)
          MyText.gray14('导演: ${shortList.value.list[index].director!}'),

        /// 影片的详细介绍，只展示三行
        if (shortList.value.list[index].introduce != null)
          MyText.gray14('剧情: ${shortList.value.list[index].introduce!}',
              maxLines: 1),
      ];

      /// 影片介绍部分：竖版排列
      var videoInfoChild = Column(
        children: contentBoxChildren,
        crossAxisAlignment: CrossAxisAlignment.start,
      );

      var videoInfo = Column(children: [
        const Spacer(),
        Padding(
          child: videoInfoChild,
          padding: const EdgeInsets.all(20),
        ),
      ]);

      /// 播放器的容器
      var videoBox = Container(
        width: Get.width,
        height: Get.height,
        child: videoBoxChild,
        decoration: videoBoxChildDecortion,
        clipBehavior: Clip.hardEdge,
      );

      return Stack(children: [videoBox, videoInfo]);
    }

    var body = Obx(() {
      const neverScroll = NeverScrollableScrollPhysics();
      var physics = state.isShowLoading ? neverScroll : null;
      return PageView.builder(
        itemBuilder: itemBuilder,
        itemCount: shortList.value.list.length,
        scrollDirection: Axis.vertical,
        onPageChanged: controller.onPageChanged,
        physics: physics,
      );
    });

    return MyScaffold(body: body);
  }
}
