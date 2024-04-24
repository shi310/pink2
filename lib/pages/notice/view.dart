import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/constant/storage.dart';
import 'package:pinker/common/services/storage.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/common/widgets/my_refresher.dart';
import 'package:pinker/pages/notice/library.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = controller.homeController.state;

    /// appbar
    var header = MyAppBar(
      isShowLine: true,
      center: MyText.text20('我的消息'),
      left: MyButton.back(),
    );

    Widget buildNoticeBox({
      required String title,
      required int id,
      required String content,
      required String timer,
      required Widget Function() readBox,
      void Function()? onTap,
    }) {
      var button = MyButton(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        color: MyColors.input,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.text18(title),
                readBox(),
              ],
            ),
            const SizedBox(height: 16),
            MyText.gray16(content, maxLines: 2),
            const SizedBox(height: 16),
            MyText.gray14(MyTimer.getDate(int.parse(timer))),
          ],
        ),
      );

      return Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: button,
          ),
        ],
      );
    }

    Widget buildListView(BuildContext context, int index) {
      var isRead = false.obs;

      var noticeBox = Obx(() => buildNoticeBox(
            content: state.noticeList.value.noticeList[index].content,
            id: state.noticeList.value.noticeList[index].id,
            timer: state.noticeList.value.noticeList[index].timer,
            title: state.noticeList.value.noticeList[index].title,
            readBox: () {
              var noticeHaveReadId =
                  MyStorageService.to.getList(storageNoticesIdKey);
              for (var i in noticeHaveReadId) {
                if (state.noticeList.value.noticeList[index].id.toString() ==
                    i) {
                  isRead.value = true;
                  break;
                }
              }

              return !isRead.value
                  ? const CircleAvatar(
                      backgroundColor: MyColors.erro,
                      radius: 5,
                    )
                  : const SizedBox();
            },
            onTap: () {
              var noticeHaveReadId =
                  MyStorageService.to.getList(storageNoticesIdKey);
              noticeHaveReadId
                  .add(state.noticeList.value.noticeList[index].id.toString());
              MyStorageService.to
                  .setList(storageNoticesIdKey, noticeHaveReadId);
              isRead.value = true;

              controller.homeController.onRead();

              MyDialog.getDaliog(
                child: DialogChild.oneButton(
                  maxLines: 20,
                  title: state.noticeList.value.noticeList[index].title,
                  content: state.noticeList.value.noticeList[index].content,
                ),
              );
            },
          ));

      return index == state.noticeList.value.noticeList.length - 1
          ? Column(children: [noticeBox, const SizedBox(height: 16)])
          : noticeBox;
    }

    /// 页面构成
    return MyScaffold(
      header: header,
      body: Obx(() {
        return MyRefresher(
          isPullUp: false,
          controller: controller.refreshController,
          child: ListView.builder(
            itemBuilder: buildListView,
            itemCount: state.noticeList.value.noticeList.length,
          ),
          onRefresh: controller.onRefresh,
        );
      }),
    );
  }
}
