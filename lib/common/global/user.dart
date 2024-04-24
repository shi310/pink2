import 'package:get/get.dart';
import 'package:pinker/common/constant/library.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/services/librart.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  //// 令牌 token
  var token = MyStorageService.to.getString(storageUserTokenKey);

  /// 保存 token
  void setToken(String value) {
    token = value;
    MyStorageService.to.setString(storageUserTokenKey, value);
  }

  /// 用户信息
  var userInfo = UserInfo.fromJson(UserInfo.child).obs;
}
