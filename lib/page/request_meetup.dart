import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:skeletons/skeletons.dart';

import '../components/meetupItem.dart';
import '../constants.dart';

class RequestMeetup extends StatefulWidget {
  const RequestMeetup({Key? key}) : super(key: key);

  @override
  State<RequestMeetup> createState() => _RequestMeetup();
}

class _RequestMeetup extends State<RequestMeetup> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoadingCircle = true;
  List<MeetupModel> listMeetup = [];
  @override
  void initState() {
    super.initState();
    getListmeetup();
  }

  getListmeetup() {
    setState(() {
      isLoadingCircle = true;
    });
    ApiServices.getListMeetingRecommendByMentorId(auth.currentUser!.uid, 1, 10)
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    listMeetup = value;
                    isLoadingCircle = false;
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Lời mời"),
          backgroundColor: MaterialColors.primary,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Skeleton(
            isLoading: isLoadingCircle,
            skeleton: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: [1, 2, 3]
                        .map(
                          (e) => Container(
                              margin:
                                  EdgeInsets.only(top: 15, right: 15, left: 15),
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: SkeletonItem(
                                child: SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                    borderRadius: BorderRadius.circular(10),
                                    width: double.infinity,
                                    minHeight:
                                        MediaQuery.of(context).size.height / 8,
                                    maxHeight:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                                ),
                              )),
                        )
                        .toList())),
            child: ListView(children: [
              if (listMeetup.isNotEmpty)
                ...listMeetup
                    .map((item) => MeetupItem(
                          function: (v) {
                            print("object");
                            getListmeetup();
                          },
                          meetup: item,
                          isCancelBtn: true,
                        ))
                    .toList()
              else ...[
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height - 137,
                  child: Container(
                      margin: EdgeInsets.only(top: 100),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Bạn chưa có meetup nào!",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      )),
                )
              ]
            ]),
          ),
        ));
  }
}
