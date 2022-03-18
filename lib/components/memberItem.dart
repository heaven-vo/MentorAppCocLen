import 'package:flutter/material.dart';
import 'package:mentor_coclen/constants.dart';

class MemberItem extends StatelessWidget {
  late String memberName;
  late String majorName;
  late String id;
  late String image;
  late bool isBorderBottom;

  MemberItem(
      {required this.memberName,
      required this.majorName,
      required this.image,
      required this.id,
      required this.isBorderBottom});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/member-detail');
          },
          child: Container(
            decoration: isBorderBottom
                ? const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black12, width: 1.0)),
                  )
                : null,
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  radius: 30, // Image radius
                  backgroundImage: NetworkImage(image),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title(
                      color: Colors.black,
                      child: Text(
                        memberName,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.school,
                              color: MaterialColors.primary,
                              size: 18,
                            ),
                          ),
                          Text(
                            majorName,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ))
                ],
              ),
            ]),
          ),
        ),
        Positioned(
          child: InkWell(
            child: Text(
              "...",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
          ),
          right: 15,
          top: 10,
        )
      ],
    );
  }
}
