import 'package:badminton_tracker/httpClient.dart';
import 'package:badminton_tracker/types/badminton.dart';
import 'package:badminton_tracker/widgets.dart';
import 'package:badminton_tracker/widgets/MWCard.dart';
import 'package:flutter/material.dart';

import 'constants.dart' as constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badminton Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Badminton Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BadmintonData badmintonData;
  bool isFetching = true;
  String? playerName;
  String? secondPlayerName;

  String? thirdPlayerName;
  String? fourthPlayerName;

  String? matchType;

  final playerScore = TextEditingController();
  final secondPlayerScore = TextEditingController();

  Future<void> fetchBadmintonData() async {
    final data = await getBadmintonData();
    setState(() {
      badmintonData = data;
      isFetching = false;
    });
  }

  Future<void> init() async {
    await fetchBadmintonData();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void saveMatchData() async {
    setState(() {
      final p = playerName;
      final p2 = secondPlayerName;
      final p3 = thirdPlayerName;
      final p4 = fourthPlayerName;

      if (p3 != null && p4 != null) {
        if (p != null && p2 != null) {
          badmintonData.matches.add(Match(
              date: DateTime.now(),
              players: [p, p2, p3, p4],
              score:
                  "${playerScore.value.text} - ${secondPlayerScore.value.text}"));
        }
      } else if (p != null && p2 != null) {
        badmintonData.matches.add(Match(
            date: DateTime.now(),
            players: [p, p2],
            score:
                "${playerScore.value.text} - ${secondPlayerScore.value.text}"));
      }
    });
    await updateBadmintonData(badmintonData);
    if (!mounted) return;
    Navigator.of(context).pop();
    await fetchBadmintonData();
  }

  List<Widget> doublesDialog() {
    return [
      Row(
        children: [
          Expanded(
            child: FormField(builder: (state) {
              final items = badmintonData.players
                  .map((e) => DropdownMenuItem<String>(
                      value: e.name,
                      child: Text(
                        e.name,
                        overflow: TextOverflow.ellipsis,
                      )))
                  .toList();
              return DropDownMenu(playerName, "Player 1", items, (p) {
                setState(() {
                  if (p != null) {
                    playerName = p;
                  }
                });
              });
            }),
          ),
          Expanded(child: FormField(builder: (state) {
            final items = badmintonData.players
                .map((e) => DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(
                      e.name,
                      overflow: TextOverflow.ellipsis,
                    )))
                .toList();
            return DropDownMenu(secondPlayerName, "Player 2", items, (p) {
              setState(() {
                if (p != null) {
                  secondPlayerName = p;
                }
              });
            });
          }))
        ],
      ),
      Container(padding: const EdgeInsets.all(10), child: const Text("VS")),
      Row(children: [
        Expanded(
          child: FormField(builder: (state) {
            final items = badmintonData.players
                .map((e) => DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(
                      e.name,
                      overflow: TextOverflow.ellipsis,
                    )))
                .toList();
            return DropDownMenu(thirdPlayerName, "Player 3", items, (p) {
              setState(() {
                if (p != null) {
                  thirdPlayerName = p;
                }
              });
            });
          }),
        ),
        Expanded(child: FormField(builder: (state) {
          final items = badmintonData.players
              .map((e) => DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(
                    e.name,
                    overflow: TextOverflow.ellipsis,
                  )))
              .toList();
          return DropDownMenu(fourthPlayerName, "Player 4", items, (p) {
            setState(() {
              if (p != null) {
                fourthPlayerName = p;
              }
            });
          });
        }))
      ]),
    ];
  }

  List<Widget> singlesDialog() {
    return [
      FormField(builder: (state) {
        final items = badmintonData.players
            .map((e) => DropdownMenuItem<String>(
                value: e.name,
                child: Text(
                  e.name,
                  overflow: TextOverflow.ellipsis,
                )))
            .toList();
        return DropDownMenu(playerName, "Select Player 1", items, (p) {
          setState(() {
            if (p != null) {
              playerName = p;
            }
          });
        });
      }),
      Container(padding: const EdgeInsets.all(10), child: const Text("VS")),
      FormField(builder: (state) {
        final items = badmintonData.players
            .map((e) => DropdownMenuItem<String>(
                value: e.name,
                child: Text(
                  e.name,
                  overflow: TextOverflow.ellipsis,
                )))
            .toList();
        return DropDownMenu(secondPlayerName, "Select Player 2", items, (p) {
          setState(() {
            if (p != null) {
              secondPlayerName = p;
            }
          });
        });
      }),
    ];
  }

  void addMatch() {
    showDialog(
        context: context,
        builder: (bc) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add new match"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    FormField(builder: (state) {
                      final items = constants.matchTypes
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList();
                      return DropDownMenu(matchType, "Select Match Type", items,
                          (p) {
                        setState(() {
                          if (p != null) {
                            matchType = p;
                          }
                        });
                      });
                    }),
                    const Divider(),
                    if (matchType == 'Singles')
                      ...singlesDialog()
                    else if (matchType == 'Doubles')
                      ...doublesDialog(),
                    // const Divider(),
                    // Text("Score"),
                    Row(
                      children: [
                        SizedBox(
                            width: 100,
                            child: TextFormField(
                              maxLength: 2,
                              validator: (value) {
                                if (value != null) {
                                  final s = int.tryParse(value);
                                  return value.isNotEmpty
                                      ? s != null
                                          ? null
                                          : "Enter valid score"
                                      : "Enter Player 1 Score";
                                }
                              },
                              controller: playerScore,
                              decoration: const InputDecoration(
                                  labelText: "Player 1 Score"),
                            )),
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: const Text(
                              "/",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            )),
                        SizedBox(
                            width: 100,
                            child: TextFormField(
                              maxLength: 2,
                              validator: (value) {
                                if (value != null) {
                                  final s = int.tryParse(value);
                                  return value.isNotEmpty
                                      ? s != null
                                          ? null
                                          : "Enter valid score"
                                      : "Enter Player 2 Score";
                                }
                              },
                              controller: secondPlayerScore,
                              decoration: const InputDecoration(
                                  labelText: "Player 2 Score"),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: saveMatchData,
                  color: Colors.blue,
                  child:
                      const Text("Save", style: TextStyle(color: Colors.white)),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.blue,
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: !isFetching
            ? ListView.builder(
                itemCount: badmintonData.matches.length,
                itemBuilder: (context, i) {
                  return MWCard(
                    matchData: badmintonData.matches[i],
                    onDeletePressed: () async {
                      setState(() {
                        badmintonData.matches.removeAt(i);
                      });
                      await updateBadmintonData(badmintonData);
                    },
                    onEditPressed: () {},
                  );
                })
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addMatch,
        tooltip: 'Add Match',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
