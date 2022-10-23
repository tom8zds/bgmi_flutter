import 'package:bgmi_flutter/internal/index/subscribe_index.dart';
import 'package:bgmi_flutter/internal/index/subscribe_index_getter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("index api", () async {
    GetSubscribeIndex getSubscribeIndex = GetSubscribeIndex(Dio());
    SubscribeIndex index = await getSubscribeIndex();
    print(index.toJson());
  });
}
