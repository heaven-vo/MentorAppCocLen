import 'package:flutter/material.dart';
import 'package:mentor_coclen/constants.dart';

class RequestMeetupItem extends StatefulWidget {
  const RequestMeetupItem({Key? key}) : super(key: key);

  @override
  State<RequestMeetupItem> createState() => _RequestMeetup();
}

class _RequestMeetup extends State<RequestMeetupItem> {
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
          Navigator.of(context).pushNamed('/meetup-detail',
              arguments: "23144f6a-75dd-4c46-92b1-b37ca7f21465")
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
                                padding:
                                    const EdgeInsets.only(top: 20, right: 15),
                                child: CircleAvatar(
                                  radius: 45, // Image radius
                                  backgroundImage: NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/twe-mobile.appspot.com/o/subject%2Flambanner-ky-thuat-thiet-ke-banner-1024x527.png?alt=media&token=35f11e4c-c1cd-49d8-9067-b1a712bc520f"),
                                ))),
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 30, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Clean Code",
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
                                        //padding: EdgeInsets.all(5),
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
                                                      " 07:00 - 09:00 | 17/03/2022",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 7, 23, 172),
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
                                                      Icons.group_rounded,
                                                      color: Color.fromARGB(
                                                          255, 7, 7, 7),
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      " Võ Chí Công",
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
                                                          255, 7, 7, 7),
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      " Moda Coffee",
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
                                ],
                              ),
                            )),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                )),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .5 - 20,
                    padding: EdgeInsets.only(top: 160, left: 10),
                    child: FlatButton(
                      height: 40,
                      child: Text(
                        'Hủy',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500),
                      ),
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: MaterialColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      textColor: MaterialColors.primary,
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5 - 20,
                    padding: EdgeInsets.only(top: 160, left: 10),
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
