import 'package:bgmi_flutter/internal/setting/setting.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepo _repo = SettingRepo.instance;

  final dio = Dio();

  Future<bool> checkServer(server, secret) async {
    if (server != null && secret != null) {
      final response = await dio.post(
        "http://$server/api/auth",
        data: {"token": secret},
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200) {
        return true;
      }
    }
    return false;
  }

  SettingBloc() : super(SettingInitial()) {
    on<SettingEvent>((event, emit) async {
      if (event is ModifyServerEvent) {
        emit(SettingLoading());
        if (await checkServer(event.server, event.secret)) {
          _repo.setServer(event.server);
          _repo.setSecret(event.secret);
          emit(SettingIdle());
          return;
        }
        emit(SettingError());
      }
      if (event is CheckServerEvent) {
        emit(SettingLoading());
        String? server = _repo.getServer();
        String? secret = _repo.getSecret();
        bool flag = await checkServer(server, secret);
        if (flag) {
          emit(SettingIdle());
          return;
        }
        emit(SettingError());
      }
    });
  }
}
