import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/main/utils/Lipsum.dart' as lipsum;

import '../utils/AppWidget.dart';
import '../utils/Icons.dart';

import '../types.dart';

class MWCard extends StatefulWidget {
  final Match matchData;

  final VoidCallback? onEditPressed;

  final VoidCallback? onDeletePressed;

  const MWCard(
      {Key? key,
      required this.matchData,
      required this.onEditPressed,
      required this.onDeletePressed})
      : super(key: key);

  @override
  MWCardState createState() => MWCardState();
}

class MWCardState extends State<MWCard> with SingleTickerProviderStateMixin {
  late final Match matchData;
  @override
  void initState() {
    super.initState();
    setState(() {
      matchData = widget.matchData;
    });
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              color: context.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CustomIcons.badminton_icon,
                    color: Colors.blue, size: 40),
                8.height,
                Text(
                    "${matchData.date.day} / ${matchData.date.month} / ${matchData.date.year}",
                    style: boldTextStyle(size: 20)),
                8.height,
                Text("${matchData.date.hour} : ${matchData.date.minute}",
                    style: secondaryTextStyle()),
                8.height,
                TextIcon(
                  edgeInsets: const EdgeInsets.only(
                      left: 0, right: 8, bottom: 4, top: 4),
                  prefix: const Icon(Icons.person_sharp, size: 20),
                  text: matchData.players.join(" VS "),
                  textStyle: primaryTextStyle(size: 14),
                ),
                TextIcon(
                  edgeInsets: const EdgeInsets.only(
                      left: 0, right: 8, bottom: 4, top: 4),
                  prefix: const Icon(Icons.scoreboard, size: 16),
                  text: matchData.score,
                  textStyle: primaryTextStyle(size: 20),
                ),
              ],
            ),
          ).expand(),
          Container(
            width: 60,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   topRight: Radius.circular(16),
              //   bottomRight: Radius.circular(16),
              // ),
              color: Colors.blueAccent,
            ),
            child: Column(
              children: [
                IconButton(
                  onPressed: widget.onEditPressed,
                  icon: const Icon(
                    Icons.edit,
                    size: 30,
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                ),
                const Divider(
                  height: 60,
                ),
                IconButton(
                    onPressed: widget.onDeletePressed,
                    icon: const Icon(
                      Icons.delete_forever,
                      size: 30,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
