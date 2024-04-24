import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/api/library.dart';
import 'package:pinker/common/constant/storage.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/services/librart.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/my_dialog.dart';
import 'package:pinker/pages/search/library.dart';

class SearchViewController extends GetxController {
  final state = SearchState();

  final inputController = TextEditingController();
  final inputFocusNode = FocusNode();
  final scrollController = ScrollController();

  final cancelToken = CancelToken();

  /// 点击搜索历史记录的关键词的处理方法
  void history(int index) {
    /// 将内容放入输入框，并且把焦点置于文本末端
    // var textPosition = TextPosition(
    //   affinity: TextAffinity.downstream,
    //   offset: state.history[index].length,
    // );

    /// 焦点置于末端
    // inputController.value = TextEditingValue(
    //   text: state.history[index],
    //   selection: TextSelection.fromPosition(textPosition),
    // );

    /// 执行搜索程序
    inputFocusNode.unfocus();
    inputController.text = state.history[index];
    search(state.history[index]);
  }

  /// 清楚搜索历史记录的执行方法，弹窗确认后的真正清除
  void clearHistory() {
    state.history.clear();
    MyStorageService.to.remove(storageSearchHistoryKey);
    Get.back();
  }

  /// 清除搜索历史记录的按钮的点击事件
  /// 点击后显示确认弹窗
  void clear() {
    if (inputFocusNode.hasFocus) inputFocusNode.unfocus();
    MyDialog.getDaliog(
      child: DialogChild.alert(
        title: '清除记录',
        content: '是否确认继续操作',
        onTap: clearHistory,
      ),
    );
  }

  /// 搜索方法
  void search(String text) async {
    String _text = text;

    if (_text.isEmpty) {
      _text = ResourceController.to.searchWord;
      inputController.text = _text;
    }

    /// 开始搜索的时候，需要展示loading
    state.isShowLoading = true;

    // 添加记录
    state.history.add(_text);

    // 去重
    state.history = state.history.toSet().toList();

    // 保存
    MyStorageService.to.setList(storageSearchHistoryKey, state.history);

    /// 开始调用接口
    var getSearchList = await ResourceApi.getResourceList(
      type: 0,
      pageNo: 1,
      pageSize: 20,
      keyword: _text,
      cancelToken: cancelToken,
    );

    /// 如果拿到数据
    if (getSearchList != null && getSearchList.code == 200) {
      /// 格式化拿到的数据
      var searchList = ResourceDataList.fromJson(getSearchList.data);

      /// 更新结果
      state.resault.update((val) {
        val!.list = searchList.list;
        val.size = searchList.size;
      });

      /// 拿到数据就不需要重试了
      state.isRetryResault = false;
    }

    /// 如果没有拿到数据
    else {
      /// 没有拿到数据需要重试
      state.isRetryResault = true;
    }

    /// 搜索完成后，不管有没有拿到谁，关闭laoding的显示，展示搜索结果
    state.isShowLoading = false;
    state.isShowResault = true;
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  void onReady() async {
    super.onReady();

    inputController.addListener(() {
      if (inputController.text.isEmpty) {
        state.resault.update((val) {
          val!.list.clear();
          val.size = 0;
        });
        state.isShowResault = false;
      }
    });

    scrollController.addListener(() {
      if (state.offsetRx.value != 1.0) state.offsetRx.value = 1.0;
    });

    debounce(state.offsetRx, (double value) {
      if (value == 1.0) inputFocusNode.unfocus();
    }, time: const Duration(milliseconds: 100));

    inputFocusNode.addListener(() {
      if (inputFocusNode.hasFocus) state.offsetRx.value = 0.0;
    });

    await MyTimer.futureMill(300);
    inputFocusNode.requestFocus();
  }
}
