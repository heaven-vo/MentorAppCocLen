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

  
  static Future<dynamic> postLoginToInsertFCM(
      String userId, String fcnToken) async {
    //12c9cd48-8cb7-4145-8fd9-323e20b329dd
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
        Uri.parse(
          '${baseURL}/login?userId=${userId}&token=${fcnToken}',
        ),
        headers: headers,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        String body = response.body;

        return body;
      } else if (response.statusCode == 404 || response.statusCode == 409) {
        return null;
      }
    } catch (e) {
      print('Error with status code: ${e}');
    }
  }

  static Future<dynamic> postLogoutToInsertFCM(
      String userId, String fcnToken) async {
    //12c9cd48-8cb7-4145-8fd9-323e20b329dd
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
        Uri.parse(
          '${baseURL}/logout?userId=${userId}&token=${fcnToken}',
        ),
        headers: headers,
      );
      print(response.statusCode);
      if (response.statusCode == 204) {
        String body = response.body;

        return body;
      } else if (response.statusCode == 404 || response.statusCode == 409) {
        return null;
      }
    } catch (e) {
      print('Error with status code: ${e}');
    }
  }
}
