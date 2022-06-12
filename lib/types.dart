import 'dart:convert';

class BadmintonData {
  BadmintonData({
    required this.players,
    required this.matches,
  });

  final List<Player> players;
  final List<Match> matches;

  factory BadmintonData.fromRawJson(String str) => BadmintonData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BadmintonData.fromJson(Map<String, dynamic> json) => BadmintonData(
    players: List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
    matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "players": List<dynamic>.from(players.map((x) => x.toJson())),
    "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
  };
}

class Match {
  Match({
    required this.date,
    required this.players,
    required this.score,
  });

  final String date;
  final List<String> players;
  final String score;

  factory Match.fromRawJson(String str) => Match.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    date: json["date"],
    players: List<String>.from(json["players"].map((x) => x)),
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "players": List<dynamic>.from(players.map((x) => x)),
    "score": score,
  };
}

class Player {
  Player({
    required this.name,
    required this.added,
  });

  final String name;
  final String added;

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    name: json["name"],
    added: json["added"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "added": added,
  };
}
