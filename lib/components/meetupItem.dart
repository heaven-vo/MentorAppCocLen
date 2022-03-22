import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/model/meetup.dart';
import 'package:mentor_coclen/utils.dart';

class MeetupItem extends StatefulWidget {
  MeetupModel meetup;
  bool isCancelBtn;
  ValueChanged<void> function;
  MeetupItem(
      {Key? key,
      required this.meetup,
      required this.function,
      required this.isCancelBtn})
      : super(key: key);

  @override
  State<MeetupItem> createState() => _MeetupItem();
}

class _MeetupItem extends State<MeetupItem> {
  FirebaseAuth auth = FirebaseAuth.instance;

  cancelRequest() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.clear,
    );
    ApiServices.putCancelMeetupRequest(
            widget.meetup.sessionId!, auth.currentUser!.uid)
        .then((value) => {
              if (value != null)
                {
                  print(value),
                  EasyLoading.dismiss(),
                  widget.function(""),
                }
              else
                {EasyLoading.dismiss(), widget.function("")}
            });

    // EasyLoading.dismiss();
  }

  int val = -1;

  dialogCancel() {
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
                          Navigator.pop(build);
                          EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.clear,
                          );

                          cancelRequest();
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

  acceptRequest() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.clear,
    );
    ApiServices.putAcceptMeetupRequest(
            widget.meetup.sessionId!, auth.currentUser!.uid)
        .then((value) => {
              if (value != null) {EasyLoading.dismiss(), widget.function("")}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      // padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () => {
          Navigator.of(context)
              .pushNamed('/meetup-detail', arguments: widget.meetup.sessionId)
        },
        child: Stack(
          children: [
            /* Positioned(
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    color: MaterialColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 17, left: 17),
                  child: Text(
                    "Góp mặt",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  )),
            ), */
            Container(
                height: 210,
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
                                padding:
                                    const EdgeInsets.only(top: 20, right: 15),
                                child: CircleAvatar(
                                  radius: 45, // Image radius
                                  backgroundImage:
                                      NetworkImage(widget.meetup.image!),
                                ))),
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    widget.meetup.subject!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  /* Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Lúc: 07:00 - 09:00 | 17/03/2022",
                                      maxLines: 2,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ), */
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_alarms_sharp,
                                                      color: Color.fromARGB(
                                                          255, 7, 23, 172),
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      " ${getSlot(widget.meetup.slot!)}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 7, 23, 172),
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Color.fromARGB(
                                                          255, 7, 23, 172),
                                                      size: 25,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "${widget.meetup.date!}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 7, 23, 172),
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      color: Color.fromARGB(
                                                          255, 7, 7, 7),
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      " Lâm Hữu Khánh Phương",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 1, 7),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
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
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.coffee,
                                                      color: Color.fromARGB(
                                                          255, 0, 1, 7),
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      " ${widget.meetup.cafeName}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 1, 7),
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
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
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.isCancelBtn) ...[
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              padding: EdgeInsets.only(top: 20, left: 0),
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
                                  dialogCancel();
                                },
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              padding: EdgeInsets.only(top: 20, left: 0),
                              child: FlatButton(
                                height: 40,
                                child: Text(
                                  'Chấp nhận',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: MaterialColors.primary,
                                textColor: Colors.white,
                                onPressed: () {
                                  acceptRequest();
                                },
                              ),
                            ),
                          ] else ...[
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              padding: EdgeInsets.only(top: 20, left: 0),
                              child: FlatButton(
                                height: 40,
                                child: Text(
                                  'Xem chi tiết',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: MaterialColors.primary,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/meetup-detail",
                                      arguments: widget.meetup.sessionId);
                                },
                              ),
                            ),
                          ]
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
