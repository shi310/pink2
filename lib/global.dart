import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/services/librart.dart';

/// 全局静态数据
class Global {
  /// 初始化
  static Future<void> init() async {
    /// 运行初始, 用到了servis就需要处初始化，否则会报错
    WidgetsFlutterBinding.ensureInitialized();

    /// 本地储存初始化
    await Get.putAsync<MyStorageService>(() => MyStorageService().init());

    /// 导入全局控制器
    /// config：系统控制器
    Get.put(ConfigController());

    /// user：户信息控制器
    Get.put(UserController());

    /// resource：影片信息控制器
    Get.put(ResourceController());
  }
}
