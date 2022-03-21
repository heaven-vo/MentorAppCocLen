import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/meetupItem.dart';
import '../constants.dart';

class RequestMeetup extends StatefulWidget {
  const RequestMeetup({Key? key}) : super(key: key);

  @override
  State<RequestMeetup> createState() => _RequestMeetup();
}

class _RequestMeetup extends State<RequestMeetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.8,
          brightness: Brightness.light,
          backgroundColor: MaterialColors.primary,
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          primary: false,
          excludeHeaderSemantics: true,
          flexibleSpace: SafeArea(
              child: Container(
            padding: EdgeInsets.only(left: 0, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 165),
                          child: Row(children: [
                            Text(
                              "Lời mời",
                              style: TextStyle(
                                  //fontFamily: "Roboto",
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ]),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/notification");
                          },
                          child: Container(
                              // margin: EdgeInsets.only(left: 0),
                              margin: EdgeInsets.only(top: 0),
                              width: 28,
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 28,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ))),
      body: ListView(
        children: [
          MeetupItem(),
        ],
      ),
    );
  }
}
