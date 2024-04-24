import 'package:flutter/material.dart';
import 'package:pinker/common/style/colors.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';

class CommunityButtonTabBar extends StatefulWidget {
  const CommunityButtonTabBar({
    Key? key,
    required this.list,
    required this.onTap,
    required this.typeName,
    required this.chooseIndex,
    required this.typeIndex,
  }) : super(key: key);

  final List<String> list;
  final void Function(int typeIndex, String typeName, int index) onTap;
  final String typeName;
  final int chooseIndex;
  final int typeIndex;

  @override
  State<CommunityButtonTabBar> createState() => _CommunityButtonTabBarState();
}

class _CommunityButtonTabBarState extends State<CommunityButtonTabBar> {
  int buttonIndex = 0;

  @override
  void initState() {
    super.initState();
    buttonIndex = widget.chooseIndex;
  }

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(BuildContext buildContext, int index) {
      const space = SizedBox(width: 8);

      var myText = MyText(
        widget.list[index],
        color: index == buttonIndex ? MyColors.primary : MyColors.secondText,
      );

      var buttonText = Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: myText,
      );

      void onTap() {
        // await controller.scrollController.animateTo(
        //   0.0,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.ease,
        // );
        setState(() => buttonIndex = index);

        widget.onTap(widget.typeIndex, widget.typeName, index);
      }

      var button = MyButton(
        color: index == buttonIndex ? MyColors.input : null,
        child: buttonText,
        onTap: index == buttonIndex ? null : onTap,
        height: 40,
      );

      var children = [
        if (index == 0) space,
        button,
        space,
      ];

      return Row(children: children);
    }

    var listView = ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: widget.list.length,
      scrollDirection: Axis.horizontal,
    );

    var haveData = SizedBox(
      height: 40,
      child: listView,
      width: double.infinity,
    );

    const noData = SizedBox();

    var body = widget.list.isEmpty ? noData : haveData;

    return Column(children: [body, const SizedBox(height: 4)]);
  }
}
