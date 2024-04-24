import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/video_play/library.dart';

class VideoPlayView extends GetView<VideoPlayController> {
  const VideoPlayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 状态控制器
    var state = controller.state;

    /// 资源的信息
    var resourceData = state.resourceData;

    /// 资源列表
    var resourceList = state.resourceList;

    /// AppBar: 标题是动态的
    var header = MyAppBar(
      isShowLine: true,
      center: Obx(() => MyText.text18('正在播放: ${resourceData.value.name}')),
      left: MyButton.back(),
    );

    /// 加载动画
    var lottie = MyIcons.lottie('image_holder');

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

    Widget buildVideoBox() {
      /// 视频的封面
      var imageBox = MyImage(
        imageUrl: resourceData.value.image,
        borderRadius: BorderRadius.zero,
      );

      var loadingBox = Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: resourceData.value.image.isEmpty ? lottie : imageBox,
        ),
        Positioned(child: mark, top: 0, left: 0, bottom: 0, right: 0),
        Positioned(child: lottieOpcaty, top: 0, left: 0, bottom: 0, right: 0),
        loadingContent,
      ]);

      /// 加载中的组成方式：
      /// 封面图放最底下
      /// 遮罩罩住封面图
      /// 加载动画
      /// 最后把加载中放到顶层
      return state.isShowLoading || controller.chewieController == null
          ? loadingBox
          : Chewie(controller: controller.chewieController!);
    }

    /// 如果在加载中，那就是展示加载的样式
    /// 如果是在播放，那就展示播放的内容
    var videoBoxChild = Obx(buildVideoBox);

    /// 播放区域的样式
    const videoBoxChildDecortion = BoxDecoration(
      shape: BoxShape.rectangle,
      color: MyColors.black,
    );

    /// 播放器的容器
    var videBox = Container(
      width: Get.width,
      height: Get.width * 720 / 1280,
      child: videoBoxChild,
      decoration: videoBoxChildDecortion,
      clipBehavior: Clip.hardEdge,
    );

    Widget buildContentBox() {
      var _value = resourceData.value;

      /// 下方开始是影片的信息部分
      /// 影片的标题，采用24dp的大小
      var title = MyText.text24(resourceData.value.name);

      /// 收藏部分组件：喜欢构建
      Widget _likeBuilder(bool _) => _ ? MyIcons.likePress() : MyIcons.like();

      /// 收藏控件组件：内容组件
      Widget _countBuilder(int? count, bool isLiked, String text) {
        return MyText.gray14(controller.isFavorites ? '已收藏' : '收藏');
      }

      /// 收藏控件
      var favorites = LikeButton(
        onTap: controller.onFavorites,
        size: 20,
        isLiked: controller.isFavorites,
        likeCountPadding: const EdgeInsets.only(left: 8),
        likeCount: 0,
        likeBuilder: _likeBuilder,
        mainAxisAlignment: MainAxisAlignment.start,
        countBuilder: _countBuilder,
        likeCountAnimationType: LikeCountAnimationType.part,
      );

      /// 第一部分：影片的标题和收藏按钮
      var titleBox = Row(children: [title, const Spacer(), favorites]);

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

      /// 这是播放地址的标题
      var playUrlsTitle = MyTabBar(
        pageController: controller.pageController,
        pageIndex: state.pageIndex,
        tabs: resourceData.value.playUrls.map((e) => e.title).toList(),
      );

      /// 这里是 listView 的构建方法
      /// 不同分组的按钮点击同一个位置，都是不同处理
      Widget _listViewBuild(int buttonIndex) {
        return Obx(() {
          /// 颜色定义
          var primaryColor = MyColors.primary;
          var inputColor = MyColors.input;

          /// 集数的点击事件，更换播放链接
          void _onTap() async {
            state.chooise = [state.pageIndex.value, buttonIndex];

            /// 然后传入新的播放地址，重新初始化播放器
            await controller.videoPlay(
              resourceData
                  .value.playUrls[state.pageIndex.value].urls[buttonIndex],
            );

            // if (controller.videoPlayerController.value.isInitialized) {
            //   /// 更换播放链接之前要把播放器控制器释放
            //   await controller.videoPlayerController.dispose();
            //   controller.chewieController.dispose();

            //   /// 确认哪个位置的按钮被选中
            //   state.chooise = [state.pageIndex.value, buttonIndex];

            //   /// 然后传入新的播放地址，重新初始化播放器
            //   await controller.videoPlay(
            //     playUrls[state.pageIndex.value].urls[buttonIndex],
            //   );
            // }
          }

          /// 是否被选中
          var isChooise = state.pageIndex.value == state.chooise[0] &&
              buttonIndex == state.chooise[1];

          /// 是否显示loading
          // var isShowLoading = state.isShowLoading;

          /// 是否在加载中
          // var isLoading = isChooise || isShowLoading;

          /// 播放按钮的文件间距
          var buttonChild = Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: MyText('第 ${buttonIndex + 1} 集'),
          );

          /// 播放按钮
          return MyButton(
            child: buttonChild,
            color: isChooise ? primaryColor : inputColor,
            onTap: isChooise ? null : _onTap,
          );
        });
      }

      /// 页面 pageView 的构建方法
      /// 选用构建方式是因为需要index判断
      Widget pageViewBuild(BuildContext context, int pageIndex) {
        return Obx(() => ListView.separated(
              itemBuilder: (context, index) => _listViewBuild(index),
              itemCount: resourceData.value.playUrls[pageIndex].urls.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
            ));
      }

      /// 下方是播放地址的组件
      /// 播放地址可能不是一个，所以播放地址用的是滑动组件
      /// 播放地址这里是动态的，所以需要obx包裹
      var partsBox = SizedBox(
        height: 40,
        child: PageView.builder(
          itemBuilder: pageViewBuild,
          itemCount: resourceData.value.playUrls.length,
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
        ),
      );

      /// 影片介绍部分的综合组成
      /// 标题 和 收藏
      /// 影片介绍
      /// 播放地址
      var contentBoxChildren = [
        /// 第一部分：影片的标题和收藏按钮
        titleBox,

        /// 间距
        const SizedBox(height: 8),

        /// 年份信息，包含评分，年份等信息
        if (yearChildren.isNotEmpty) MyText.gray14(yearChildrenString),

        /// 影片的演员表
        if (resourceData.value.actors != null)
          MyText.gray14('演员: ${resourceData.value.actors!}'),

        /// 影片的导演
        if (resourceData.value.director != null)
          MyText.gray14('导演: ${resourceData.value.director!}'),

        /// 影片的详细介绍，只展示三行
        if (resourceData.value.introduce != null)
          MyText.gray14('剧情: ${resourceData.value.introduce!}', maxLines: 3),

        /// 间距
        const SizedBox(height: 8),

        /// 播放地址的标题，可能会被用来区分语言
        playUrlsTitle,

        /// 间距
        const SizedBox(height: 16),

        /// 播放地址
        partsBox,
      ];

      /// 影片介绍部分：竖版排列
      return Column(
        children: contentBoxChildren,
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    }

    /// 给影片介绍的内容增加边距
    var contentBox = Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Obx(buildContentBox),
    );

    /// 猜你喜欢部分：这部分也是动态的
    /// 分成没有内容或者有内容两种情况
    var guessBox = Obx(() {
      /// 有内容
      var data = MediaBox(
        mediaDataList: resourceList.value.list,
        title: resourceList.value.list.isEmpty ? null : '猜你喜欢',
        onTap: controller.guessPlay,
      );

      /// 加载中
      var loading = Padding(
        padding: const EdgeInsets.only(top: 32),
        child: MyIcons.loading(),
      );

      /// 如果实在加载中，或者是重新加载中，就显示加载的样式
      /// 如果拿到了数据，就展示数据
      return !state.isRetry && resourceList.value.list.isEmpty ? loading : data;
    });

    /// 页面组成：不包含播放器的部分
    var content = SingleChildScrollView(
      child: Column(children: [contentBox, guessBox]),
      controller: controller.scrollController,
    );

    /// 页面组成
    var body = Column(children: [
      // const SizedBox(height: 10),
      videBox,
      const SizedBox(height: 10),
      Expanded(child: content)
    ]);

    return MyScaffold(header: header, body: body);
  }
}
