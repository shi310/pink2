import 'package:flutter/services.dart';
import 'package:pinker/common/style/library.dart';

class SystemStye {
  /// 将顶部状态栏和底部状态栏设置成透明
  static Future<void> setTransparentStatusBar() async {
    /// 显示顶部栏(隐藏底部栏，没有这个的话底部状态栏的透明度无法实现)
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    const style = SystemUiOverlayStyle(
      statusBarColor: MyColors.transparent,
      systemNavigationBarColor: MyColors.transparent,
      systemNavigationBarDividerColor: MyColors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );

    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 强制竖屏：用到了SystemChrome服务，所以需要初始化
  static Future<void> setPreferredOrientations() async {
    /// 强制竖屏：用到了SystemChrome服务，所以需要初始化
    /// 如：WidgetsFlutterBinding.ensureInitialized();
    var option = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
    await SystemChrome.setPreferredOrientations(option);
  }
}
