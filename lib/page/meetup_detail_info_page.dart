import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/widget_span.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/components/locationItem.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/model/location.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:mentor_coclen/model/mentor.dart';
import 'package:mentor_coclen/utils.dart';

class MeetupDetailPage extends StatelessWidget {
  late MeetupModel meetingInfo;
  ValueChanged<void> function;
  MeetupDetailPage({required this.meetingInfo, required this.function});
  bool status = true;

  @override
  Widget build(BuildContext context) {
    LocationModel coffee = LocationModel.fromJson(meetingInfo.cafe!);
    FirebaseAuth auth = FirebaseAuth.instance;

    acceptRequest() {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.clear,
      );
      ApiServices.putAcceptMeetupRequest(
              meetingInfo.sessionId!, auth.currentUser!.uid)
          .then((value) => {
                if (value != null) {EasyLoading.dismiss(), function("")}
              });
    }

    cancelMeetup() {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.clear,
      );
      ApiServices.putCancelMeetup(meetingInfo.sessionId!, auth.currentUser!.uid)
          .then((value) => {
                if (value != null)
                  {
                    print(value),
                    EasyLoading.dismiss(),
                    function(""),
                    Navigator.pop(context),
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hủy meetup thành công!')),
                    ),
                  }
                else
                  {EasyLoading.dismiss(), function("")}
              });

      // EasyLoading.dismiss();
    }

    cancelRequest() {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.clear,
      );
      ApiServices.putCancelMeetupRequest(
              meetingInfo.sessionId!, auth.currentUser!.uid)
          .then((value) => {
                if (value != null)
                  {
                    print(value),
                    EasyLoading.dismiss(),
                    function(""),
                    Navigator.pop(context),
                  }
                else
                  {EasyLoading.dismiss(), function("")}
              });

      // EasyLoading.dismiss();
    }

    int val = -1;
    dialogCancel(context, bool isCancel) {
      return showDialog(
          context: context,
          builder: (build) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text("Hủy Meetup", textAlign: TextAlign.center),
                content: SingleChildScrollView(
                  child: Column(children: [
                    ListTile(
                      title: Text("Có việc bận đột xuất!"),
                      leading: Radio(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = int.parse(value.toString());
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("Thành viên trong nhóm quá ít!"),
                      leading: Radio(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = int.parse(value.toString());
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("Lý do khác:"),
                      leading: Radio(
                        value: 3,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = int.parse(value.toString());
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    if (val == 3) ...[
                      Container(
                          height: 100,
                          child: Card(
                              color: Colors.white60,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  maxLines: 8,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration.collapsed(
                                      hintStyle: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.4)),
                                      hintText: "Nhập lý do của bạn."),
                                ),
                              )))
                    ]
                  ]),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          height: 40,
                          color: MaterialColors.primary,
                          onPressed: () {
                            if (isCancel) {
                              cancelMeetup();
                            } else {
                              cancelRequest();
                            }
                            Navigator.pop(build);
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: MaterialColors.primary, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "   Xác nhận  ",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Roboto",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      FlatButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: MaterialColors.primary, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(build);
                          },
                          child: Text(
                            "    Hủy bỏ     ",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Roboto",
                                color: MaterialColors.primary,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  )
                ],
              );
            });
          });
    }

    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Stack(
              children: [
                ListView(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Chuyên ngành',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.school,
                                      size: 22,
                                      color: MaterialColors.primary,
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 5,
                                    ),
                                  ),
                                  Title(
                                      color: Colors.black,
                                      child: Text(
                                        meetingInfo.majorName!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Chủ đề',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.subject,
                                      size: 22,
                                      color: MaterialColors.primary,
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 5,
                                    ),
                                  ),
                                  Title(
                                      color: Colors.black,
                                      child: Text(
                                        meetingInfo.subject!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Giá tiền',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.attach_money_outlined,
                                      size: 22,
                                      color: MaterialColors.primary,
                                    ),
                                  ),
                                  Title(
                                      color: Colors.black,
                                      child: Text(
                                        '${meetingInfo.price}00 VND / buổi',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Thời gian',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 5, bottom: 2),
                                        child: Icon(
                                          Icons.calendar_month,
                                          size: 22,
                                          color: MaterialColors.primary,
                                        ),
                                      ),
                                      Title(
                                          color: Colors.black,
                                          child: Text(
                                            meetingInfo.date!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 5, bottom: 2),
                                        child: Icon(
                                          Icons.schedule,
                                          size: 22,
                                          color: MaterialColors.primary,
                                        ),
                                      ),
                                      Title(
                                          color: Colors.black,
                                          child: Text(
                                            getSlot(meetingInfo.slot!) ?? "",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))),
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black12, width: 1.0)),
                    ),
                  ),
                  CoffeeItem(
                      coffee: coffee,
                      onPush: (e) {},
                      isTabPage: false,
                      onSubmit: (e) {},
                      isStar: true,
                      heightImg: 130,
                      widthImg: 120,
                      isButton: false),
                ]),
                Positioned(
                    bottom: 0,
                    child: Row(
                      children: [
                        if (meetingInfo.status == 0) ...[
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            padding:
                                EdgeInsets.only(bottom: 10, right: 5, left: 10),
                            child: FlatButton(
                              height: 40,
                              child: Text(
                                'Hủy bỏ',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500),
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: MaterialColors.primary, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.white,
                              textColor: MaterialColors.primary,
                              onPressed: () {
                                dialogCancel(context, false);
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            padding:
                                EdgeInsets.only(bottom: 10, right: 10, left: 5),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              child: Text(
                                "Chấp nhận",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: MaterialColors.primary,
                                textStyle: TextStyle(color: Colors.white),
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => {},
                            ),
                          )
                        ] else ...[
                          Container(
                            height: 50,
                            color: Colors.white,
                            padding:
                                EdgeInsets.only(bottom: 10, right: 10, left: 5),
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              child: Text(
                                "Hủy meetup",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: MaterialColors.primary,
                                textStyle: TextStyle(color: Colors.white),
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => {dialogCancel(context, true)},
                            ),
                          )
                        ]
                      ],
                    ))
              ],
            )));
  }
}
