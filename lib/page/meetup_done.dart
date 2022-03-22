import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/components/meetupItem.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:skeletons/skeletons.dart';

class MyMeetupDonePage extends StatefulWidget {
  const MyMeetupDonePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyMeetupDonePage();
  }
}

class _MyMeetupDonePage extends State<MyMeetupDonePage>
    with AutomaticKeepAliveClientMixin<MyMeetupDonePage> {
  @override
  bool get wantKeepAlive => true;
  bool isLoadingCircle = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<MeetupModel> listMeetup = [];
  @override
  void initState() {
    super.initState();
    ApiServices.getListMeetingRecommendByStatus(auth.currentUser!.uid, 2, 1, 10)
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
    return Container(
      child: Skeleton(
        isLoading: isLoadingCircle,
        skeleton: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: [1, 2, 3]
                    .map(
                      (e) => Container(
                          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
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
                .map((item) => MeetupItem(meetup: item, isCancelBtn: false, function: (v){},))
                .toList()
          else ...[
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height - 185,
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
    );
  }
}
