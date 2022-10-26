import 'package:hive_flutter/hive_flutter.dart';

const String serverKey = "server";
const String secretKey = "secret";

class SettingRepo {
  final Box _box;

  static SettingRepo? _instance;

  static SettingRepo get instance => _instance!;

  SettingRepo(this._box) {
    _instance = this;
  }

  String? getServer() {
    var server = _box.get(serverKey);
    if (server is String) {
      return server;
    }
    return null;
  }

  void setServer(String server) {
    _box.put(serverKey, server);
  }

  String? getSecret() {
    var secret = _box.get(secretKey);
    if (secret is String) {
      return secret;
    }
    return null;
  }

  void setSecret(String secret) {
    _box.put(secretKey, secret);
  }
}
