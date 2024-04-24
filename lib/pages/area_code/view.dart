import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';
import 'package:pinker/pages/area_code/library.dart';

class AreaCodeView extends GetView<AreaCodeController> {
  const AreaCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appbar
    var header = MyAppBar(
      isShowLine: true,
      center: MyText.text18('区号选择'),
      left: MyButton.back(),
    );

    var searchInput = MyInput(
      focusNode: controller.searchNode,
      controller: controller.searchController,
      hintText: '搜索国家/区号',
      borderRadius: BorderRadius.zero,
    );

    Widget getCodeButton({
      required String code,
      required String country,
      void Function()? onTap,
    }) {
      var codeText = MyText('+$code');
      var countryText = MyText(country);
      var buttonState = Obx(() => ConfigController.to.areaCode.value == code
          ? const Icon(Icons.check_circle, color: MyColors.primary, size: 24)
          : const SizedBox());

      var bodyChild = Row(children: [
        const SizedBox(width: 20),
        codeText,
        const SizedBox(width: 20),
        countryText,
        const Spacer(),
        buttonState,
        const SizedBox(width: 20),
      ]);

      return MyButton(
        borderRadius: BorderRadius.zero,
        onTap: onTap,
        child: SizedBox(height: 50, child: bodyChild),
      );
    }

    var bodyChild = Obx(() {
      return controller.state.showList.isEmpty
          ? Container()
          : MyListView(
              children: controller.state.showList
                  .map(
                    (item) => Obx(() {
                      var countryName = '';

                      if (ConfigController.to.locale.value ==
                          const Locale('zh', 'CN')) {
                        countryName = item.chineseName;
                      } else {
                        countryName = item.englishName;
                      }
                      return getCodeButton(
                          code: item.phoneCode,
                          country: countryName,
                          onTap: () {
                            ConfigController.to.areaCode.value = item.phoneCode;
                            ConfigController.to.areaName.value =
                                Get.locale == const Locale('zh', 'CN')
                                    ? item.chineseName
                                    : item.englishName;

                            ConfigController.to.areaShortName =
                                item.countryCode;
                            Get.back();
                          });
                    }),
                  )
                  .toList());
    });

    var body = Column(
      children: [searchInput, Expanded(child: Scrollbar(child: bodyChild))],
    );

    /// 页面构成
    return MyScaffold(header: header, body: body);
  }
}
