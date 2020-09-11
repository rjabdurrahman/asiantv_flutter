// To parse this JSON data, do
//
//     final modelLive = modelLiveFromJson(jsonString);

import 'dart:convert';

List<ModelLive> modelLiveFromJson(String str) =>
    List<ModelLive>.from(json.decode(str).map((x) => ModelLive.fromJson(x)));

String modelLiveToJson(List<ModelLive> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelLive {
  ModelLive({
    this.id,
    this.url,
    this.publishedAt,
  });

  String id;
  String url;
  DateTime publishedAt;

  factory ModelLive.fromJson(Map<String, dynamic> json) => ModelLive(
        id: json["id"],
        url: utf8.decode(base64Url.decode(json["url"])),
        publishedAt: DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "published_at": publishedAt.toIso8601String(),
      };
}
