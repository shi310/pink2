import 'package:dio/dio.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/utils/library.dart';

class PublicApi {
  /// 登陆
  static Future<ResponseData?> getNoticeList({
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().get(
      '/public/notice',
      options: Options(
        headers: {'token': UserController.to.token},
      ),
      errorCallBack: errorCallBack,
      cancelToken: cancelToken,
    );

    return response != null ? ResponseData.fromJson(response.data) : null;
  }
}
