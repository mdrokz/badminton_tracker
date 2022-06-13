import 'package:badminton_tracker/types.dart';
import 'package:badminton_tracker/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final badmintonData = BadmintonData(
      players: List.generate(
          3, (index) => Player(name: "Test $index", added: DateTime.now())),
      matches: []);
  String? playerName;
  String? secondPlayerName;

  final playerScore = TextEditingController();
  final secondPlayerScore = TextEditingController();

  void addMatch() {
    showDialog(
        context: context,
        builder: (bc) {
          return AlertDialog(
              title: const Text("Add new match"),
              content: SizedBox(
                height: 500,
                child: Column(
                  children: [
                    FormField(builder: (state) {
                      final items = badmintonData.players
                          .map((e) => DropdownMenuItem<String>(
                              value: e.name, child: Text(e.name)))
                          .toList();
                      return DropDownMenu(playerName, "Select Player 1", items,
                          (p) {
                        setState(() {
                          if (p != null) {
                            playerName = p;
                          }
                        });
                      });
                    }),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("VS")),
                    FormField(builder: (state) {
                      final items = badmintonData.players
                          .map((e) => DropdownMenuItem<String>(
                              value: e.name, child: Text(e.name)))
                          .toList();
                      return DropDownMenu(
                          secondPlayerName, "Select Player 2", items, (p) {
                        setState(() {
                          if (p != null) {
                            secondPlayerName = p;
                          }
                        });
                      });
                    }),
                    const Divider(),
                    // Text("Score"),
                    FormField(builder: (state) {
                      return TextField(
                        maxLength: 2,
                        controller: playerScore,
                        decoration:
                            InputDecoration(labelText: "Player 1 Score"),
                      );
                    }),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("To")),
                    FormField(builder: (state) {
                      return TextField(
                        maxLength: 2,
                        controller: secondPlayerScore,
                        decoration:
                            const InputDecoration(labelText: "Player 2 Score"),
                      );
                    }),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.blue,
                      child: const Text("Save",
                          style: TextStyle(color: Colors.white)),
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
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addMatch,
        tooltip: 'Add Match',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
