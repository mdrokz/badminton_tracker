import 'dart:convert';
import 'dart:io';

import 'package:badminton_tracker/types/badminton.dart';
import 'package:badminton_tracker/types/github.dart';

import 'constants.dart' as constants;

final httpClient = HttpClient();

Future<BadmintonData> getBadmintonData() async {
  final req = await httpClient.getUrl(Uri.parse(constants.githubJsonBaseUrl));

  final res = await req.close();

  final jsonData = json.decode(await res.transform(utf8.decoder).join());

  final String content = jsonData["content"];

  final decodedData = String.fromCharCodes(base64Decode(content.replaceAll("\"", "")
      .replaceAll("\\", "").replaceAll("\n", "")));

  final badmintonData = decodedData.parseBadmintonData();

  return badmintonData;
}

Future<String> fetchJsonSha() async {
  final req = await httpClient.getUrl(
      Uri.parse(constants.githubAPIUrl));

  req.headers.set("Accept", constants.headers['Accept']!);

  final res = await req.close();

  final data = json.decode(await res.transform(utf8.decoder).join());

  return data["sha"];
}

Future<void> updateBadmintonData(BadmintonData badmintonData) async {
  final sha = await fetchJsonSha();

  final req = await httpClient.putUrl(Uri.parse(constants.githubAPIUrl));

  req.headers.set("Accept", constants.headers['Accept']!);
  req.headers.set("Authorization", constants.headers['Authorization']!);

  final body = base64Encode(badmintonData.toRawJson().codeUnits);

  final commit = CommitData(
      message: "Update Badminton Data",
      committer: Committer(
          name: "Badminton Tracker", email: "container.m12@gmail.com"),
      content: body,
      sha: sha);

  req.write(commit.toRawJson());

  await req.flush();

  final res = await req.close();

  if (res.statusCode == 200) {
  }
}
