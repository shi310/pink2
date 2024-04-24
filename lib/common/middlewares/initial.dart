import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/routes/library.dart';

/// 第一次欢迎页面
class MiddlewareInitial extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (ConfigController.to.isHaveUsed) {
      return const RouteSettings(name: MyRoutes.application);
    } else {
      return const RouteSettings(name: MyRoutes.welcome);
    }
  }
}
