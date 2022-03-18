import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentor_coclen/components/noficationItem.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/data_mock.dart';
import 'package:mentor_coclen/model/nofication.dart';

class NoficationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoficationPage();
}

class _NoficationPage extends State<NoficationPage> {
  List<NoficationModel> nofiList = [];
  bool loading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    nofiList = NOFI_DATA;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading) {
        mockData();
      }
    });
  }

  void mockData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 3000));
    List<NoficationModel> newList = [...nofiList, ...NOFI_DATA];
    setState(() {
      print("load xong");
      loading = false;
      nofiList = newList;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Notifi");
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: MaterialColors.primary,
            automaticallyImplyLeading: false,
            leading: BackButton(
              color: Colors.white,
            ),
            title: Text(
              "Thông báo",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
              ),
            )),
        body: ListView(
          controller: scrollController,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.white,
                margin: EdgeInsets.only(top: 25),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      child: Text(
                        "Hôm nay",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                      margin: EdgeInsets.all(15),
                    ),
                    NoficationItem(
                      title: "Meetup đã được xác nhận",
                      content: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                          ),
                          text: "Meetup của bạn đã được giảng viên ",
                          children: [
                            TextSpan(
                                text: "Lâm Hữu Khánh Phương",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: MaterialColors.primary)),
                            TextSpan(text: " xác nhận"),
                          ]),
                      time: "19:03 PM",
                      image: MENTOR_DATA[0].image!,
                    ),
                  ],
                )),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                top: 25,
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 1,
              child: Text(
                "Cũ hơn",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              color: Colors.white,
              child: ListView.separated(
                  // controller: scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return NoficationItem(
                      content: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                          ),
                          text: nofiList[index].content,
                          children: [
                            TextSpan(
                                text: nofiList[index].person,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: MaterialColors.primary)),
                            TextSpan(text: " xác nhận"),
                          ]),
                      time: nofiList[index].time,
                      title: nofiList[index].title,
                      image: nofiList[index].image,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 1);
                  },
                  itemCount: nofiList.length),
            ),
            if (loading) ...[
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                height: 80,
              )
            ]
          ],
        ));
  }
}
