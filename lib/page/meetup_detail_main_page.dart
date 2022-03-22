import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:mentor_coclen/page/meetup_detail_info_page.dart';
import 'package:mentor_coclen/page/meetup_detail_member_page.dart';

class MeetupDetailMainPage extends StatefulWidget {
  late String sessionId;

  MeetupDetailMainPage({
    required this.sessionId,
  });

  @override
  _MeetupDetailMainPageState createState() => _MeetupDetailMainPageState();
}

class _MeetupDetailMainPageState extends State<MeetupDetailMainPage> {
  late MeetupModel meeting;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text("Chi tiết Meetup"),
              backgroundColor: MaterialColors.primary,
            ),
            body: Center(
                child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      color: MaterialColors.primary,
                    ))))
        : DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Chi tiết Meetup"),
                  backgroundColor: MaterialColors.primary,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: ColoredBox(
                      color: Colors.white,
                      child: TabBar(
                        labelColor: MaterialColors.primary,
                        indicatorWeight: 2,
                        labelStyle: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        indicatorColor: Color(0xff107162),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: ("Thông tin"),
                          ),
                          Tab(
                            text: ("Thành viên"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    MeetupDetailPage(meetingInfo: meeting),
                    SessionMemberPage(
                      members: meeting.listMember!,
                    ),
                  ],
                )),
          );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    ApiServices.getMeetingDetailByMeetingId(
            auth.currentUser!.uid, widget.sessionId)
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    meeting = value;
                    isLoading = false;
                    print(meeting.isLead);
                  })
                }
            });
  }
}
