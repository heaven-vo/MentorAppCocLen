import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mentor_coclen/model/meetup.dart';

class ApiServices {
  static const baseURL = 'https://theweekendexpertise.azurewebsites.net/api/v1';

  static Future<dynamic> getMeetingDetailByMeetingId(
      String userId, String meetingId) async {
    var meetingModel = Completer<MeetupModel>();
    var body;
    try {
      var response = await http.get(Uri.parse(
          '${baseURL}/sessions/detail?memberId=${userId}&sessionId=${meetingId}'));
      body = convert.jsonDecode(response.body);
      meetingModel.complete(MeetupModel.fromJson(body['data']));
    } catch (_) {
      meetingModel.complete(MeetupModel.fromJson(body));
    } on SocketException {
      print("Fail to connect API!");
    }
    return meetingModel.future;
  }
}
