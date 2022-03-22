import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/components/help.dart';

import '../components/categoryCart.dart';
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
      body: ListView(children: [
        Container(
            height: 220,
            decoration: const BoxDecoration(),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, right: 15, bottom: 15),
                            child: CircleAvatar(
                              radius: 45, // Image radius
                              backgroundImage: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/twe-mobile.appspot.com/o/mentor%2Fimage_2022-03-18_131220.png?alt=media&token=50709d02-8cdd-4353-a8cb-713d6ab0b5d4"),
                            ))),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.only(top: 30, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    //padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  " Xin chào,",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromARGB(
                                                          255, 52, 187, 108),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    //padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  " Lâm Hữu Khánh Phương",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 1, 7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Stack(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 218, 218),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons
                                                  .assignment_turned_in_rounded,
                                              color: Color.fromARGB(
                                                  255, 7, 23, 172),
                                              size: 25,
                                            ),
                                            Text(
                                              " Meetup của ngày hôm nay",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 23, 172),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              "          Nhóm Võ Chí Công",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    /* "          Lúc 10:00 - 11:30 am, tại Moda coffee, Nguyễn Oanh", */
                                    "          Lúc 13:00 - 15:30 am | Tại Moda Coffee",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Row(
                children: [
                  //Padding(padding: EdgeInsets.all(10)),

                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 5),
                    child: Icon(
                      Icons.assignment_turned_in_rounded,
                      color: Color.fromARGB(255, 52, 187, 108),
                      size: 90,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 70),
                    child: Text(
                      "3",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 207, 11, 11),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text("                     "),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Column(
                children: [
                  //Padding(padding: EdgeInsets.all(10)),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 5),
                        child: Icon(
                          Icons.assignment_rounded,
                          color: Color.fromARGB(255, 52, 187, 108),
                          size: 90,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 70),
                        child: Text(
                          "3",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 207, 11, 11),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  //Padding(padding: EdgeInsets.all(10)),

                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Yêu Cầu",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text("                                      "),
            ),
            Container(
              child: Column(
                children: [
                  //Padding(padding: EdgeInsets.all(10)),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Lịch hẹn",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Skill nổi bật",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                //color: Color.fromARGB(255, 71, 73, 72),
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          child: Column(
            children: [
              //Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: CircleAvatar(
                            radius: 65, // Image radius
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/twe-mobile.appspot.com/o/subject%2FCap1ture.PNG?alt=media&token=f4d66bd7-9fbf-4d0e-87cd-3af1faa4f7e2"),
                          ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: CircleAvatar(
                            radius: 65, // Image radius
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/twe-mobile.appspot.com/o/subject%2Fimages.png?alt=media&token=4f1be2cb-90d4-459b-831d-2233751a70cb"),
                          ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: CircleAvatar(
                            radius: 65, // Image radius
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/twe-mobile.appspot.com/o/subject%2Fimages.jpg?alt=media&token=3a69e80d-406e-46d3-95ce-a9f5aaafd409"),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
