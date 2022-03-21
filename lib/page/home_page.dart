import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                          margin: EdgeInsets.only(top: 0),
                          child: Row(children: [
                            Container(
                              width: 75,
                              height: 50,
                              child: Image.asset(
                                'assets/coctrensach5.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "Cóc ",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Lên",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 22,
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
                                size: 32,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ))),
    );
  }
}
