import 'package:dio/dio.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/utils/library.dart';

class AccountApi {
  /// 登陆
  static Future<ResponseData?> signIn({
    required String account,
    required String password,
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().post(
      '/account/signIn',
      data: {
        'account': account,
        'password': password,
      },
      errorCallBack: errorCallBack,
      cancelToken: cancelToken,
    );

    return response != null ? ResponseData.fromJson(response.data) : null;
  }
}
