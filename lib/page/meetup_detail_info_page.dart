import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/widget_span.dart';
import 'package:mentor_coclen/components/locationItem.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/model/location.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:mentor_coclen/model/mentor.dart';
import 'package:mentor_coclen/utils.dart';

class MeetupDetailPage extends StatelessWidget {
  late MeetupModel meetingInfo;
  MeetupDetailPage({required this.meetingInfo});
  bool status = true;
  @override
  Widget build(BuildContext context) {
    List<MentorModel> listMentorInvite =
        meetingInfo.listMentorInvite!.map((dynamic item) {
      print(item);
      return MentorModel.fromJson(item);
    }).toList();

    LocationModel coffee = LocationModel.fromJson(meetingInfo.cafe!);

    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView(children: <Widget>[
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5, bottom: 2),
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
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
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
        /* Container(
          height: 50,
          color: Colors.white,
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            child: Text(
              "Chấp nhận",
              style: TextStyle(fontFamily: "Roboto", fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              primary: MaterialColors.primary,
              textStyle: TextStyle(color: Colors.white),
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => {},
          ),
        ) */
      ]),
    ));
  }
}
