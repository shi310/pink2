import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    Key? key,
    required this.pageController,
    required this.pageIndex,
    required this.tabs,
    this.scrollController,
  }) : super(key: key);

  final PageController pageController;
  final RxInt pageIndex;
  final List<String> tabs;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(BuildContext buildContext, int index) {
      const space = SizedBox(width: 16);

      Widget obxBuild() {
        void onTap() async {
          // if (scrollController != null) {
          //   await scrollController!.animateTo(
          //     0.0,
          //     duration: const Duration(milliseconds: 200),
          //     curve: Curves.ease,
          //   );
          // }

          if (scrollController != null) {
            scrollController!.jumpTo(0);
          }

          pageIndex.value = index;
          pageController.jumpToPage(
            index,
            // duration: const Duration(milliseconds: 300),
            // curve: Curves.ease,
          );
        }

        const borderSide = BorderSide(color: MyColors.primary, width: 2);

        const border = Border(bottom: borderSide);

        var boxBorder = pageIndex.value == index ? border : null;

        var text18 = MyText.text18(tabs[index]);
        var text16 = MyText.gray16(tabs[index]);

        var myText = pageIndex.value == index ? text18 : text16;

        var decoration = BoxDecoration(border: boxBorder);

        var child = Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          decoration: decoration,
          child: Center(child: myText),
          height: 50,
        );

        return MyButton(
          child: child,
          onTap: pageIndex.value == index ? null : onTap,
          borderRadius: BorderRadius.zero,
        );
      }

      var button = Obx(obxBuild);

      var haveSpace = Row(children: [button, space]);

      return index == tabs.length ? button : haveSpace;
    }

    var listView = ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: tabs.length,
      scrollDirection: Axis.horizontal,
    );

    return SizedBox(
      width: Get.width,
      height: 50,
      child: listView,
    );
  }
}
