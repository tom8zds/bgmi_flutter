class CalendarData {
  CalendarData({required this.content});

  final Map<UpdateTime, List<AnimeData>> content;

  factory CalendarData.fromJson(Map<String, dynamic> json) => CalendarData(
        content: json.map(
          (key, value) => MapEntry(
            updateTimeValues.map[key]!,
            List<AnimeData>.from(
              value.map((x) => AnimeData.fromJson(x)),
            ),
          ),
        ),
      );

  Map<String, dynamic> toJson() => content.map(
        (key, value) => MapEntry(
          key.name,
          List<dynamic>.from(
            value.map(
              (x) => x.toJson(),
            ),
          ),
        ),
      );
}

class AnimeData {
  AnimeData({
    required this.status,
    required this.episode,
    required this.id,
    required this.name,
    required this.subtitleGroup,
    required this.keyword,
    required this.updateTime,
    required this.cover,
  });

  final int status;
  final int episode;
  final int id;
  final String name;
  final List<dynamic> subtitleGroup;
  final String keyword;
  final UpdateTime updateTime;
  final String cover;

  factory AnimeData.fromJson(Map<String, dynamic> json) => AnimeData(
        status: json["status"] ?? -1,
        episode: json["episode"] ?? -1,
        id: json["id"],
        name: json["name"],
        subtitleGroup: List<dynamic>.from(json["subtitle_group"].map((x) => x)),
        keyword: json["keyword"],
        updateTime:
            updateTimeValues.map[json["update_time"]] ?? UpdateTime.unknown,
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "episode": episode,
        "id": id,
        "name": name,
        "subtitle_group": List<dynamic>.from(subtitleGroup.map((x) => x)),
        "keyword": keyword,
        "update_time": updateTimeValues.reverse[updateTime],
        "cover": cover,
      };
}

enum UpdateTime { fri, mon, sat, sun, thu, tue, unknown, wed }

final updateTimeValues = EnumValues({
  "fri": UpdateTime.fri,
  "mon": UpdateTime.mon,
  "sat": UpdateTime.sat,
  "sun": UpdateTime.sun,
  "thu": UpdateTime.thu,
  "tue": UpdateTime.tue,
  "unknown": UpdateTime.unknown,
  "wed": UpdateTime.wed
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap ??= map.map((k, v) => MapEntry(v, k));
  }
}
