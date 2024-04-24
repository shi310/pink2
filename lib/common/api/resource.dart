import 'package:dio/dio.dart';
import 'package:pinker/common/data/library.dart';
import 'package:pinker/common/global/user.dart';
import 'package:pinker/common/utils/library.dart';

class ResourceApi {
  static Future<ResponseData?> getResourceList({
    required int type,
    int? pageNo,
    void Function(int, int)? onReceiveProgress,
    int? pageSize,
    int? sort,
    int? mediaType,
    int? country,
    String? keyword,
    int? year,
    int? guessId,
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().get(
      '/resource/getResourceList',
      options: Options(headers: {'token': UserController.to.token}),
      queryParameters: {
        'type': type,
        'pageNo': pageNo,
        'pageSize': pageSize ?? 20,
        'sort': sort,
        'mediaType': mediaType,
        'country': country,
        'keyword': keyword,
        'year': year,
        'guessId': guessId,
      },
      onReceiveProgress: onReceiveProgress,
      errorCallBack: errorCallBack,
      cancelToken: cancelToken,
    );

    return response != null ? ResponseData.fromJson(response.data) : null;
  }

  static Future<ResponseData?> getResourceType({
    required int type,
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().get(
      '/resource/getResourceType',
      errorCallBack: errorCallBack,
      queryParameters: {'type': type},
      cancelToken: cancelToken,
    );
    return response != null ? ResponseData.fromJson(response.data) : null;
  }

  static Future<ResponseData?> getResourceData({
    required int id,
    Future<void> Function(ErrorEntity)? errorCallBack,
    CancelToken? cancelToken,
  }) async {
    Response? response = await MyHttp().get(
      '/resource/getResourceData',
      errorCallBack: errorCallBack,
      queryParameters: {'id': id},
      options: Options(headers: {'token': UserController.to.token}),
      cancelToken: cancelToken,
    );
    return response != null ? ResponseData.fromJson(response.data) : null;
  }
}
