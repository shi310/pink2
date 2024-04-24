import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/application/community/sex/library.dart';
import 'package:pinker/pages/application/community/widgets/library.dart';

class CommunitySexView extends GetView<CommunitySexController> {
  const CommunitySexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 骨架动画
    // var lottie = SingleChildScrollView(
    //   child: MyIcons.lottie('home'),
    //   controller: controller.communityController.scrollController,
    // );

    void getData() async {
      controller.state.isRetry = false;
      await controller.getMedias(type: controller.type);
    }

    Widget obxBuild() {
      var loading = Padding(
        padding: const EdgeInsets.only(top: 20),
        child: MyIcons.loading(),
      );
      var children = [
        const SizedBox(height: 20),
        for (int i = 0; i < controller.types.value.list.length; i++)
          CommunityButtonTabBar(
            typeName: controller.types.value.list[i].mediaTypeName,
            list: controller.types.value.list[i].typelist,
            onTap: controller.typesClick,
            chooseIndex: controller.chooseIndex[i],
            typeIndex: i,
          ),
        MediaBox(mediaDataList: controller.medias.value.list),
        if (!controller.state.isRetry &&
            (controller.types.value.list.isEmpty ||
                controller.medias.value.list.isEmpty))
          loading,
        if (controller.state.isRetry &&
            (controller.types.value.list.isEmpty ||
                controller.medias.value.list.isEmpty))
          MyButton.retry(onTap: getData),
      ];

      return MyListView(children: children);
    }

    return Container(
      child: Obx(obxBuild),
      color: MyColors.background,
    );
  }
}
