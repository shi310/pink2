import 'package:flutter/material.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyRefresher extends StatelessWidget {
  const MyRefresher({
    Key? key,
    required this.controller,
    required this.child,
    this.isPullUp = true,
    this.onRefresh,
    this.onLoading,
    this.scrollController,
    this.header,
  }) : super(key: key);

  final RefreshController controller;
  final Widget child;
  final bool isPullUp;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final ScrollController? scrollController;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    const loadingBox = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        backgroundColor: MyColors.text,
        color: MyColors.primary,
        strokeWidth: 2,
      ),
    );
    return SmartRefresher(
      enablePullDown: true,
      scrollController: scrollController,
      controller: controller,
      enablePullUp: isPullUp,
      physics: const BouncingScrollPhysics(),
      child: child,
      header: header ??
          WaterDropHeader(
            complete: MyText.gray14('刷新成功'),
            idleIcon: const Icon(
              Icons.autorenew,
              size: 20,
              color: MyColors.primary,
            ),
            waterDropColor: MyColors.secondText,
            refresh: loadingBox,
          ),
      footer: isPullUp
          ? CustomFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = MyText.gray14("加载完成");
                } else if (mode == LoadStatus.loading) {
                  body = loadingBox;
                } else if (mode == LoadStatus.failed) {
                  body = const MyText("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = const MyText("释放刷新");
                } else {
                  body = const MyText("没有更多数据了!");
                }
                return Center(
                  child: Padding(
                    child: body,
                    padding: const EdgeInsets.only(top: 20),
                  ),
                );
              },
            )
          : null,
      onRefresh: onRefresh,
      onLoading: onLoading,
    );
  }
}
