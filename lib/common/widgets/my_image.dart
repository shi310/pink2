import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/my_icons.dart';

// class MyImage extends StatefulWidget {
//   const MyImage({
//     Key? key,
//     required this.imageUrl,
//     this.width = 55.0,
//     this.height = 55.0,
//     this.borderRadius = MyStyle.borderRadius,
//   }) : super(key: key);

//   final String imageUrl;
//   final double width;
//   final double height;
//   final BorderRadiusGeometry borderRadius;

//   @override
//   State<MyImage> createState() => _MyImageState();
// }

// class _MyImageState extends State<MyImage> {
//   bool isShowImage = false;

//   @override
//   void initState() {
//     super.initState();

//     MyHttp()
//         .get(widget.imageUrl, errorCallBack: (error) async {})
//         .then((value) async {
//       if (value != null && value.statusCode == 200) {
//         await MyTimer.futureMill(500);
//         setState(() {
//           isShowImage = true;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Widget placeholder(context, url) {
//     //   return MyIcons.lottie('home');
//     // }

//     Widget errorWidget(BuildContext context, String url, erro) {
//       return Container(
//         width: widget.width,
//         height: widget.height,
//         color: MyColors.input,
//       );
//     }

//     Widget progressIndicatorBuilder(
//       BuildContext context,
//       String url,
//       DownloadProgress value,
//     ) {
//       return MyIcons.lottie('image_holder', fit: BoxFit.fill);
//     }

//     var imageBox = CachedNetworkImage(
//       imageUrl: widget.imageUrl,
//       width: widget.width,
//       height: widget.height,
//       fit: BoxFit.cover,
//       // placeholder: placeholder,
//       errorWidget: errorWidget,
//       progressIndicatorBuilder: progressIndicatorBuilder,
//       fadeInDuration: const Duration(milliseconds: 2000),
//     );

//     var decoration = BoxDecoration(
//       borderRadius: widget.borderRadius,
//       shape: BoxShape.rectangle,
//     );

//     return Container(
//       width: widget.width,
//       height: widget.height,
//       decoration: decoration,
//       clipBehavior: Clip.antiAlias,
//       child: isShowImage
//           ? imageBox
//           : MyIcons.lottie('image_holder', fit: BoxFit.fill),
//     );
//   }
// }

class MyImage extends StatelessWidget {
  const MyImage({
    Key? key,
    required this.imageUrl,
    this.width = 55.0,
    this.height = 55.0,
    this.borderRadius = MyStyle.borderRadius,
  }) : super(key: key);

  final String imageUrl;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    // Widget placeholder(context, url) {
    //   return MyIcons.lottie('home');
    // }

    Widget errorWidget(BuildContext context, String url, erro) {
      return Container(
        width: width,
        height: height,
        color: MyColors.input,
      );
    }

    Widget progressIndicatorBuilder(
      BuildContext context,
      String url,
      DownloadProgress value,
    ) {
      return MyIcons.lottie('image_holder', fit: BoxFit.fill);
    }

    var imageBox = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      // placeholder: placeholder,
      errorWidget: errorWidget,
      progressIndicatorBuilder: progressIndicatorBuilder,
      fadeInDuration: const Duration(milliseconds: 2000),
    );

    var decoration = BoxDecoration(
      borderRadius: borderRadius,
      shape: BoxShape.rectangle,
    );

    return Container(
      width: width,
      height: height,
      decoration: decoration,
      clipBehavior: Clip.antiAlias,
      child: imageBox,
    );
  }
}
