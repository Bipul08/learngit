// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  int? page;
  int? perPage;
  List<Video>? videos;
  int? totalResults;
  String? url;

  SearchModel({
    this.page,
    this.perPage,
    this.videos,
    this.totalResults,
    this.url,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    page: json["page"],
    perPage: json["per_page"],
    videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
    totalResults: json["total_results"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
    "total_results": totalResults,
    "url": url,
  };
}

class Video {
  int? id;
  int? width;
  int? height;
  int? duration;
  dynamic fullRes;
  List<dynamic>? tags;
  String? url;
  String? image;
  dynamic avgColor;
  User? user;
  List<VideoFile>? videoFiles;
  List<VideoPicture>? videoPictures;

  Video({
    this.id,
    this.width,
    this.height,
    this.duration,
    this.fullRes,
    this.tags,
    this.url,
    this.image,
    this.avgColor,
    this.user,
    this.videoFiles,
    this.videoPictures,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    duration: json["duration"],
    fullRes: json["full_res"],
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
    url: json["url"],
    image: json["image"],
    avgColor: json["avg_color"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    videoFiles: json["video_files"] == null ? [] : List<VideoFile>.from(json["video_files"]!.map((x) => VideoFile.fromJson(x))),
    videoPictures: json["video_pictures"] == null ? [] : List<VideoPicture>.from(json["video_pictures"]!.map((x) => VideoPicture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "duration": duration,
    "full_res": fullRes,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "url": url,
    "image": image,
    "avg_color": avgColor,
    "user": user?.toJson(),
    "video_files": videoFiles == null ? [] : List<dynamic>.from(videoFiles!.map((x) => x.toJson())),
    "video_pictures": videoPictures == null ? [] : List<dynamic>.from(videoPictures!.map((x) => x.toJson())),
  };
}

class User {
  int? id;
  String? name;
  String? url;

  User({
    this.id,
    this.name,
    this.url,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}

class VideoFile {
  int? id;
  String? quality;
  String? fileType;
  int? width;
  int? height;
  int? fps;
  String? link;

  VideoFile({
    this.id,
    this.quality,
    this.fileType,
    this.width,
    this.height,
    this.fps,
    this.link,
  });

  factory VideoFile.fromJson(Map<String, dynamic> json) => VideoFile(
    id: json["id"],
    quality: json["quality"],
    fileType: json["file_type"],
    width: json["width"],
    height: json["height"],
    fps: json["fps"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quality": quality,
    "file_type": fileType,
    "width": width,
    "height": height,
    "fps": fps,
    "link": link,
  };
}

class VideoPicture {
  int? id;
  int? nr;
  String? picture;

  VideoPicture({
    this.id,
    this.nr,
    this.picture,
  });

  factory VideoPicture.fromJson(Map<String, dynamic> json) => VideoPicture(
    id: json["id"],
    nr: json["nr"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nr": nr,
    "picture": picture,
  };
}
