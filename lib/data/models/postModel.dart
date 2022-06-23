// ignore_for_file: file_names

import 'articlesModel.dart';

class PostModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  PostModel({this.status, this.totalResults, this.articles});

  PostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }
}
