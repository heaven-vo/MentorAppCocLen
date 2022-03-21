import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/main.dart';
import 'package:mentor_coclen/page/app.dart';
import 'package:mentor_coclen/page/meetup_accept.dart';
import 'package:mentor_coclen/page/login_page.dart';
import 'package:mentor_coclen/page/meetup_detail_info_page.dart';
import 'package:mentor_coclen/page/meetup_detail_main_page.dart';
import 'package:mentor_coclen/page/notification_page.dart';
import 'package:mentor_coclen/page/profile_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LandingPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => App());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/notification':
        return MaterialPageRoute(builder: (_) => NoficationPage());
      case '/meetup-detail':
        return MaterialPageRoute(
            builder: (_) => MeetupDetailMainPage(
                  sessionId: (args.toString()),
                ));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

// class ScreenArguments {
//   final bool isTab;

//   ScreenArguments(
//     this.isTab,
//   );
// }

// class ScreenArgumentsIsTab {
//   final String? id;
//   final bool? isTab;

//   ScreenArgumentsIsTab(this.isTab, this.id);
// }

// class ScreenArgumentsSearchReuslt {
//   final String? keySearch;
//   final String? type;

//   ScreenArgumentsSearchReuslt({this.keySearch, this.type});
// }
