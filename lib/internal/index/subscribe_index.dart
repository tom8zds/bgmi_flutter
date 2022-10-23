// To parse this JSON data, do
//
//     final subscribeIndex = subscribeIndexFromJson(jsonString);
import 'dart:convert';

SubscribeIndex subscribeIndexFromJson(String str) =>
    SubscribeIndex.fromJson(json.decode(str));

String subscribeIndexToJson(SubscribeIndex data) => json.encode(data.toJson());

class SubscribeIndex {
  SubscribeIndex({
    required this.version,
    required this.latestVersion,
    required this.frontendVersion,
    required this.status,
    required this.lang,
    required this.danmakuApi,
    required this.data,
  });

  final String version;
  final String latestVersion;
  final String frontendVersion;
  final String status;
  final String lang;
  final String danmakuApi;
  final List<SubscribeItem> data;

  factory SubscribeIndex.fromJson(Map<String, dynamic> json) => SubscribeIndex(
        version: json["version"],
        latestVersion: json["latest_version"],
        frontendVersion: json["frontend_version"],
        status: json["status"],
        lang: json["lang"],
        danmakuApi: json["danmaku_api"],
        data: List<SubscribeItem>.from(
            json["data"].map((x) => SubscribeItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "latest_version": latestVersion,
        "frontend_version": frontendVersion,
        "status": status,
        "lang": lang,
        "danmaku_api": danmakuApi,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SubscribeItem {
  SubscribeItem({
    required this.name,
    required this.updateTime,
    required this.cover,
    required this.id,
    required this.bangumiName,
    required this.episode,
    required this.status,
    required this.updatedTime,
    required this.player,
  });

  final String name;
  final String updateTime;
  final String cover;
  final int id;
  final String bangumiName;
  final int episode;
  final int status;
  final int updatedTime;
  final Player player;

  factory SubscribeItem.fromJson(Map<String, dynamic> json) => SubscribeItem(
        name: json["name"],
        updateTime: json["update_time"],
        cover: json["cover"],
        id: json["id"],
        bangumiName: json["bangumi_name"],
        episode: json["episode"],
        status: json["status"],
        updatedTime: json["updated_time"],
        player: Player.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "update_time": updateTime,
        "cover": cover,
        "id": id,
        "bangumi_name": bangumiName,
        "episode": episode,
        "status": status,
        "updated_time": updatedTime,
        "player": player.toJson(),
      };
}

class Player {
  Player();

  factory Player.fromJson(Map<String, dynamic> json) => Player();

  Map<String, dynamic> toJson() => {};
}
