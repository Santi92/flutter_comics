import 'dart:convert';

import 'package:intl/intl.dart';


ComicResponse comicResponseFromJson(String str) => ComicResponse.fromJson(json.decode(str));

class ComicResponse {
  ComicResponse({
    this.error,
    this.limit,
    this.offset,
    this.numberOfPageResults,
    this.numberOfTotalResults,
    this.statusCode,
    this.results,
  });

  String error;
  int limit;
  int offset;
  int numberOfPageResults;
  int numberOfTotalResults;
  int statusCode;
  List<Result> results;

  factory ComicResponse.fromJson(Map<String, dynamic> json) => ComicResponse(
    error: json["error"],
    limit: json["limit"],
    offset: json["offset"],
    numberOfPageResults: json["number_of_page_results"],
    numberOfTotalResults: json["number_of_total_results"],
    statusCode: json["status_code"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

}

class Result {
  Result({
    this.apiDetailUrl,
    this.coverDate,
    this.dateAdded,
    this.dateLastUpdated,
    this.description,
    this.id,
    this.image,
    this.issueNumber,
    this.name,
    this.siteDetailUrl,
    this.storeDate,
  });

  String apiDetailUrl;
  DateTime coverDate;
  DateTime dateAdded;
  DateTime dateLastUpdated;
  String description;
  int id;
  ImageModel image;
  String issueNumber;
  String name;
  String siteDetailUrl;
  DateTime storeDate;


  factory Result.fromJson(Map<String, dynamic> json) => Result(

    apiDetailUrl: json["api_detail_url"],
    coverDate: json["cover_date"] == null ? null : DateTime.parse(json["cover_date"]),
    dateAdded: DateTime.parse(json["date_added"]),
    dateLastUpdated: DateTime.parse(json["date_last_updated"]),
    description: json["description"] == null ? null : json["description"],
    id: json["id"],
    image: ImageModel.fromJson(json["image"]),
    issueNumber: json["issue_number"],
    name: json["name"] == null ? "-" : json["name"],
    siteDetailUrl: json["site_detail_url"],
    storeDate: json["store_date"] == null ? null : DateTime.parse(json["store_date"]),
  );

  Map<String, dynamic> toJson() => {
    "api_detail_url": apiDetailUrl,
    "cover_date": coverDate == null ? null : "${coverDate.year.toString().padLeft(4, '0')}-${coverDate.month.toString().padLeft(2, '0')}-${coverDate.day.toString().padLeft(2, '0')}",
    "date_added": dateAdded.toIso8601String(),
    "date_last_updated": dateLastUpdated.toIso8601String(),
    "description": description == null ? null : description,
    "id": id,
    "image": image.toJson(),
    "issue_number": issueNumber,
    "name": name == null ? "-" : name,
    "site_detail_url": siteDetailUrl,
    "store_date": storeDate == null ? null : "${storeDate.year.toString().padLeft(4, '0')}-${storeDate.month.toString().padLeft(2, '0')}-${storeDate.day.toString().padLeft(2, '0')}",
  };

  String dateFormat() => DateFormat.yMMMMEEEEd().format(dateAdded);
}

class ImageModel {
  ImageModel({
    this.iconUrl,
    this.mediumUrl,
    this.screenUrl,
    this.screenLargeUrl,
    this.smallUrl,
    this.superUrl,
    this.thumbUrl,
    this.tinyUrl,
    this.originalUrl
  });

  String iconUrl;
  String mediumUrl;
  String screenUrl;
  String screenLargeUrl;
  String smallUrl;
  String superUrl;
  String thumbUrl;
  String tinyUrl;
  String originalUrl;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    iconUrl: json["icon_url"],
    mediumUrl: json["medium_url"],
    screenUrl: json["screen_url"],
    screenLargeUrl: json["screen_large_url"],
    smallUrl: json["small_url"],
    superUrl: json["super_url"],
    thumbUrl: json["thumb_url"],
    tinyUrl: json["tiny_url"],
    originalUrl: json["original_url"],
  );

  Map<String, dynamic> toJson() => {
    "icon_url": iconUrl,
    "medium_url": mediumUrl,
    "screen_url": screenUrl,
    "screen_large_url": screenLargeUrl,
    "small_url": smallUrl,
    "super_url": superUrl,
    "thumb_url": thumbUrl,
    "tiny_url": tinyUrl,
    "original_url": originalUrl,
  };
}

