import 'package:dio/dio.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/utils/library.dart';

class HomeApi {
  /// 获取首页数据
  static Future<ResponseData?> getHomeData({
    required int type,
    void Function(int, int)? onReceiveProgress,
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().get(
      '/home/getHomeData',
      queryParameters: {'type': type},
      onReceiveProgress: onReceiveProgress,
      errorCallBack: errorCallBack,
      cancelToken: cancelToken,
    );

    return response != null ? ResponseData.fromJson(response.data) : null;
  }

  /// 获取搜索关键字
  static Future<ResponseData?> getSearchWord({
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().get(
      '/home/searchWord',
      errorCallBack: errorCallBack,
      cancelToken: cancelToken,
    );
    return response != null ? ResponseData.fromJson(response.data) : null;
  }
}
