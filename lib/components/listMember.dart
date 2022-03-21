import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/components/memberItem.dart';

class ListMember extends StatefulWidget {
  List members;
  ListMember({required this.members});
  @override
  State<StatefulWidget> createState() => _ListMember();
}

class _ListMember extends State<ListMember> {
  // List<MentorModel> list = [MENTOR_DATA[0], MENTOR_DATA[1], MENTOR_DATA[2]];

  @override
  Widget build(BuildContext context) {
    List listMentorInvite = widget.members.map((dynamic item) {
      return item;
    }).toList();

    return Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Title(
                color: Colors.black,
                child: Text(
                  "Thành viên (1/5)",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
                children: widget.members.map((dynamic item) {
              var index = widget.members.indexOf(item);
              return MemberItem(
                  id: item["id"],
                  majorName: item["majorName"],
                  memberName: item["name"],
                  image: item["image"],
                  isBorderBottom:
                      index == widget.members.length - 1 ? false : true);
            }).toList()),
          )
        ]));
  }
}
