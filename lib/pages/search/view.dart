import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/search/library.dart';

class SearchView extends GetView<SearchViewController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = controller.state;
    var hot = ResourceController.to.hotList;

    /// appBar
    /// 由一个返回按钮 和 一个搜索框组成
    /// 返回按钮
    /// 搜索框
    var buttonBack = MyButton.back();

    /// 搜素框：高度35
    var searchInput = MyInput(
      controller: controller.inputController,
      focusNode: controller.inputFocusNode,
      prefixIcon: MyIcons.search(),
      height: 35,
      textInputAction: TextInputAction.search,
      hintText: ResourceController.to.searchWord,
      onSubmitted: controller.search,
    );

    /// appBar 的核心组成
    /// 返回按钮 和 搜索框组成
    var appBarChild = Row(children: [
      buttonBack,
      Expanded(child: searchInput),
      const SizedBox(width: 16),
    ]);

    /// appBar
    var header = MyAppBar(center: appBarChild, isShowLine: true);

    /// 获取历史记录组件的方法
    /// 页面组成
    /// 下面的方法是整个页面的刷新
    Widget bodyBuild() {
      /// 页面的主体部分
      /// 由未搜索页面 和 搜索结果两个不同的状态组成
      /// 未搜索状态的组件放这里：包含历史记录，热门搜索两个模块
      /// 历史记录的标题组成
      /// 搜索历史的标题
      var historyHeader = Row(children: [
        const Opacity(opacity: 0.5, child: MyText('最近搜索')),
        const Spacer(),
        MyButton.close(onTap: controller.clear, size: 18),
      ]);

      /// 搜索历史组建方法
      /// 这是一个listView的组件方法
      Widget historyitemBuilder(BuildContext context, int index) {
        void _onTap() => controller.history(index);
        return MyButton.history(text: state.history[index], onTap: _onTap);
      }

      /// 搜索历史的搜索按钮部分
      /// 搜索按钮只占一行
      var historyListView = ListView.separated(
        itemBuilder: historyitemBuilder,
        itemCount: state.history.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        scrollDirection: Axis.horizontal,
      );

      /// 搜索历史记录的按钮部分需要包裹在一个高度空间里
      /// 高度是34 只占一行
      var historyListViewSize = SizedBox(child: historyListView, height: 34);

      /// 热门搜索的标题
      const hotTitle = Opacity(opacity: 0.5, child: MyText('热门搜索'));

      /// 加载按钮
      var loadingBox = Padding(
        padding: const EdgeInsets.only(top: 20),
        child: MyIcons.loading(),
      );

      /// 有搜索结果的组件放这里
      /// 未搜索状态
      /// 搜索结果
      /// 热门搜索
      /// 获取热门搜索结果的组装方法
      var resaultChildren = state.resault.value.list
          .map((e) => MediaSearch(resourceData: e))
          .toList();

      /// 一共有三个状态
      /// 1、刚进来的时候，会展示搜索就（如果有的话）和 热门搜索（如果加载失败展示重试）
      /// 2、搜索的时候，先展示加载按钮
      /// 3、拿到数据后，展示搜索结果
      /// 4、加载失败的话，展示网络连接的重试按钮
      var noDataChildren = [
        if (state.history.isNotEmpty) historyHeader,
        if (state.history.isNotEmpty) const SizedBox(height: 16),
        if (state.history.isNotEmpty) historyListViewSize,
        if (state.history.isNotEmpty) const SizedBox(height: 20),
        if (hot.value.list.isNotEmpty) hotTitle,
        if (hot.value.list.isNotEmpty) const SizedBox(height: 16),
        if (hot.value.list.isNotEmpty)
          for (var e in hot.value.list) MediaHot(resourceData: e),
        if (!state.isRetryHot && hot.value.list.isEmpty) loadingBox,
      ];

      /// 搜索事件处理
      void search() => controller.search(controller.inputController.text);

      /// 页面的组成方式
      /// 如果是加载状态，整个列表都只展示加载的图标
      /// 如果不是加载状态且是展示结果的时候
      /// 如果加载结果的时候了重试情况
      /// 用重试状态
      /// 结果是空或者不是空的
      /// 搜索结果是空就展示空的
      /// 搜索结果不是空的，就展示
      var children = state.isShowLoading
          ? [loadingBox]
          : state.isShowResault
              ? state.isRetryResault
                  ? [MyButton.retry(onTap: search)]
                  : resaultChildren.isEmpty
                      ? [MyIcons.error()]
                      : resaultChildren
              : noDataChildren.isEmpty
                  ? [MyIcons.error()]
                  : noDataChildren;

      /// 最后返回一个listview列表
      return MyListView(
        children: children,
        controller: controller.scrollController,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      );
    }

    return MyScaffold(header: header, body: Obx(bodyBuild));
  }
}
