import 'package:flutter/cupertino.dart';
import 'package:mentor_coclen/components/meetupItem.dart';

class MySessionPage extends StatelessWidget {
  const MySessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        //MySessionPage(),
        MeetupItem(),
        /* MeetupItem(),
        MeetupItem(),
        MeetupItem(), */
      ]),
    );
  }
}
