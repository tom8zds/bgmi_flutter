import 'dart:convert';

import 'package:bgmi_flutter/internal/calendar/calendar_data.dart';
import 'package:bgmi_flutter/internal/common/api_response.dart';
import 'package:bgmi_flutter/internal/index/subscribe_index.dart';
import 'package:dio/dio.dart';

class GetCalendar {
  final Dio dio;

  GetCalendar(this.dio);

  Future<CalendarData> call() async {
    Response response = await dio.get("http://192.168.3.1:10180/api/cal",
        options: Options(responseType: ResponseType.json));
    ApiResponse apiResponse = ApiResponse.fromJson(response.data);
    return CalendarData.fromJson(json.decode(apiResponse.data));
  }
}
