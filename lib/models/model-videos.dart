
import 'dart:convert';

List<ModelVideos> modelVideosFromJson(String str) => List<ModelVideos>.from(json.decode(str).map((x) => ModelVideos.fromJson(x)));

String modelVideosToJson(List<ModelVideos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelVideos {
  ModelVideos({
    this.id,
    this.title,
    this.categoriesId,
    this.thumbnail,
    this.link,
    this.createdAt,
  });

  String id;
  String title;
  String categoriesId;
  String thumbnail;
  String link;
  DateTime createdAt;

  factory ModelVideos.fromJson(Map<String, dynamic> json) => ModelVideos(
    id: json["id"],
    title: json["title"],
    categoriesId: json["categories_id"],
    thumbnail: json["thumbnail"],
    link: json["link"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "categories_id": categoriesId,
    "thumbnail": thumbnail,
    "link": link,
    "createdAt": createdAt.toIso8601String(),
  };
}