import 'dart:convert';
import 'dart:io';

import 'package:badminton_tracker/types/badminton.dart';
import 'package:badminton_tracker/types/github.dart';

import 'constants.dart' as constants;

final httpClient = HttpClient();

Future<BadmintonData> getBadmintonData() async {
  final req = await httpClient.getUrl(Uri.parse(constants.githubJsonBaseUrl));

  req.headers.set("User-Agent",
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.125 Safari/537.36 Vivaldi/5.3.2679.55");
  req.headers.set("Accept", "application/json");

  final res = await req.close();

  final badmintonData =
      (await res.transform(utf8.decoder).join()).parseBadmintonData();

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

  // final req = await httpClient.open(
  //     "PUT", "https", 443, constants.githubAPIUrl);
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
