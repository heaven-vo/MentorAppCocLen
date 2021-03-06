import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/components/meetupItem.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:skeletons/skeletons.dart';

class MyMeetupPage extends StatefulWidget {
  const MyMeetupPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyMeetupPage();
  }
}

class _MyMeetupPage extends State<MyMeetupPage>
    with AutomaticKeepAliveClientMixin<MyMeetupPage> {
  @override
  bool get wantKeepAlive => true;
  bool isLoadingCircle = true;
  FirebaseAuth auth = FirebaseAuth.instance;
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
    ApiServices.getListMeetingRecommendByStatus(auth.currentUser!.uid, 1, 1, 10)
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
                .map((item) => MeetupItem(
                      function: (v) {getListmeetup();},
                      meetup: item,
                      isCancelBtn: false,
                    ))
                .toList()
          else ...[
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height - 185,
              child: Container(
                  margin: EdgeInsets.only(top: 100),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Ba??n ch??a co?? meetup na??o!",
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
