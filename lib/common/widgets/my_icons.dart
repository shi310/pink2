import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pinker/common/style/colors.dart';

class MyIcons {
  static Widget diamond() => SvgPicture.asset('assets/svg/diamond.svg');

  static Widget right() => SvgPicture.asset('assets/svg/right.svg');

  static Widget back() => SvgPicture.asset('assets/svg/back.svg');

  static Widget set() => SvgPicture.asset('assets/svg/set.svg');

  static Widget check_1() => SvgPicture.asset('assets/svg/check_1.svg');

  static Widget check_2() => SvgPicture.asset('assets/svg/check_2.svg');

  static Widget customer() => SvgPicture.asset('assets/svg/my_customer.svg');

  static Widget emial() => SvgPicture.asset('assets/svg/my_email.svg');
  static Widget emialRead() => SvgPicture.asset('assets/svg/my_email_1.svg');

  static Widget bank() => Image.asset('assets/images/my_bank.png', width: 28);

  static Widget phone() => Image.asset('assets/images/my_phone.png', width: 28);

  static Widget exit() => Image.asset('assets/images/my_exit.png', width: 28);

  static Widget like() => SvgPicture.asset('assets/svg/like.svg', width: 28);

  static Widget play({double? size}) {
    return SvgPicture.asset('assets/svg/play.svg', width: size);
  }

  static Widget error() {
    return SvgPicture.asset('assets/svg/error_3.svg', width: 80);
  }

  static Widget retry() {
    return SvgPicture.asset('assets/svg/error_2.svg', width: 80);
  }

  static Widget likePress() {
    return SvgPicture.asset('assets/svg/like_press.svg', width: 28);
  }

  static Widget password() {
    return Image.asset('assets/images/my_password.png', width: 28);
  }

  static Widget broken() {
    return Image.asset('assets/images/my_broken.png', width: 28);
  }

  static Widget logo() {
    return SvgPicture.asset('assets/svg/logo.svg');
  }

  static Widget lottie(String url, {BoxFit? fit}) {
    return LottieBuilder.asset(
      'assets/lottie/$url.zip',
      fit: fit ?? BoxFit.fitWidth,
    );
  }

  static Widget close({double? size}) {
    return Icon(Icons.cancel, color: MyColors.primary, size: size ?? 16);
  }

  static Widget search() {
    var icon = SvgPicture.asset('assets/svg/search.svg', height: 20, width: 20);
    return SizedBox(child: Center(child: icon), height: 20, width: 20);
  }

  static Widget history() {
    return Image.asset('assets/images/my_history.png', width: 28);
  }

  static Widget loading() {
    const loadingBox = CircularProgressIndicator(
      backgroundColor: MyColors.secondText,
      color: MyColors.primary,
      strokeWidth: 3,
    );

    const child = SizedBox(width: 24, height: 24, child: loadingBox);

    return const Center(child: child);
  }
}
