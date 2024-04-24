import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    var backImage = MyImage(
      imageUrl: imageUrl,
      height: 480,
      width: Get.width,
    );

    var dark = [MyColors.background, MyColors.transparent];

    var colorTop = LinearGradient(
      colors: dark,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    var colorBottom = LinearGradient(
      colors: dark,
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    var decorationTop = BoxDecoration(gradient: colorTop);
    var decorationBottom = BoxDecoration(gradient: colorBottom);

    var containerTop = Container(decoration: decorationTop);
    var containerBottom = Container(decoration: decorationBottom);

    var postionTop = Positioned(
      child: containerTop,
      top: 0,
      left: 0,
      height: 180,
      width: Get.width,
    );

    var postionBottom = Positioned(
      child: containerBottom,
      bottom: 0,
      left: 0,
      height: 120,
      width: Get.width,
    );

    var playIcon = MyIcons.play();

    var bannerText = MyText(title);

    const space = SizedBox(height: 10);

    var column = SizedBox(
      height: 70,
      child: Column(
        children: [playIcon, space, bannerText],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );

    var bannerContent = Padding(
      padding: const EdgeInsets.all(20),
      child: column,
    );

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        backImage,
        postionTop,
        postionBottom,
        bannerContent,
      ],
    );
  }
}
