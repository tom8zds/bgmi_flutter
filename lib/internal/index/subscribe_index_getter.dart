import 'package:bgmi_flutter/internal/index/subscribe_index.dart';
import 'package:dio/dio.dart';

class GetSubscribeIndex {
  final Dio dio;

  GetSubscribeIndex(this.dio);

  Future<SubscribeIndex> call() async {
    Response response = await dio.get("http://192.168.3.1:10180/api/index",
        options: Options(responseType: ResponseType.json));
    return SubscribeIndex.fromJson(response.data);
  }
}
