import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/components/listMember.dart';

class SessionMemberPage extends StatefulWidget {
  List members;
  SessionMemberPage({required this.members});
  @override
  State<StatefulWidget> createState() => _SessionMemberPage();
}

class _SessionMemberPage extends State<SessionMemberPage> {
  @override
  Widget build(BuildContext context) {
    return ListMember(
      members: widget.members,
    );
  }
}
