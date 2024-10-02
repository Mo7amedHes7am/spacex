import 'package:flutter/cupertino.dart';

class ExploreModel{

  String id, datatype, source, sourcelink, subtitle, title;
  int type, datetime;
  List<String> content;
  ImageProvider imgurl;

  ExploreModel({
    required this.id,
    required this.datatype,
    required this.imgurl,
    required this.source,
    required this.sourcelink,
    required this.subtitle,
    required this.title,
    required this.type,
    required this.content,
    required this.datetime,
  });

  factory ExploreModel.fromMap(Map<String, dynamic> map) {
    return ExploreModel(
      id: map["id"],
      datatype: map["datatype"],
      imgurl: NetworkImage(map["imgurl"]),
      source: map["source"],
      sourcelink: map["sourcelink"],
      subtitle: map["subtitle"],
      title: map["title"],
      datetime: map["datetime"],
      type: map["type"],
      content: List<String>.from(map["content"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datetime': datetime,
      'datatype': datatype,
      'imgurl': imgurl,
      'source': source,
      'sourcelink': sourcelink,
      'subtitle': subtitle,
      'title': title,
      'type': type,
      'content': List<String>.from(content),
    };
  }
}

