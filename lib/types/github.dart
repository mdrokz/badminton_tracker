// To parse this JSON data, do
//
//     final commitData = commitDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommitData {
  CommitData({
    required this.message,
    required this.committer,
    required this.content,
    required this.sha,
  });

  final String message;
  final Committer committer;
  final String content;
  final String sha;

  factory CommitData.fromRawJson(String str) => CommitData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommitData.fromJson(Map<String, dynamic> json) => CommitData(
    message: json["message"],
    committer: Committer.fromJson(json["committer"]),
    content: json["content"],
    sha: json["sha"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "committer": committer.toJson(),
    "content": content,
    "sha": sha,
  };
}

class Committer {
  Committer({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  factory Committer.fromRawJson(String str) => Committer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Committer.fromJson(Map<String, dynamic> json) => Committer(
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
}
