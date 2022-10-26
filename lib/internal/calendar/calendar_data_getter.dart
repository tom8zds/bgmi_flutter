import 'dart:convert';

import 'package:bgmi_flutter/internal/calendar/calendar_data.dart';
import 'package:bgmi_flutter/internal/common/api_response.dart';
import 'package:bgmi_flutter/internal/index/subscribe_index.dart';
import 'package:dio/dio.dart';

import '../setting/setting.dart';

class GetCalendar {
  final Dio dio;
  final SettingRepo _repo = SettingRepo.instance;

  GetCalendar(this.dio);

  Future<CalendarData> call() async {
    Response response = await dio.get("http://${_repo.getServer()}/api/cal",
        options: Options(responseType: ResponseType.json));
    ApiResponse apiResponse = ApiResponse.fromJson(response.data);
    return CalendarData.fromJson(json.decode(apiResponse.data));
  }
}
