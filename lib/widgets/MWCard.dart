import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/main/utils/Lipsum.dart' as lipsum;

import '../utils/AppWidget.dart';

class MWCard extends StatefulWidget {
  static String tag = '/MWCardScreen';

  const MWCard({Key? key}) : super(key: key);

  @override
  MWCardState createState() => MWCardState();
}

class MWCardState extends State<MWCard> {
  @override
  void initState() {
    super.initState();
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
      height: 210,
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
                const Icon(Icons.sports_tennis, color: Colors.amber, size: 40),
                8.height,
                Text('Padawan Collector', style: boldTextStyle(size: 20)),
                8.height,
                Text('Collect 10 Zambezi Cards', style: secondaryTextStyle()),
                8.height,
                TextIcon(
                  edgeInsets: const EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                  prefix: const Icon(Icons.call, size: 14),
                  text: "+91 8657458214",
                  textStyle: primaryTextStyle(size: 14),
                ),
                TextIcon(
                  edgeInsets: const EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                  prefix: const Icon(Icons.web, size: 14),
                  text: "WWW.COMPANY.COM",
                  textStyle: primaryTextStyle(size: 14),
                ),
              ],
            ),
          ).expand(),
          Container(
            width: 90,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }

}
