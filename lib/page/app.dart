import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:mentor_coclen/page/acount_page.dart';
import 'package:mentor_coclen/page/meetup_accept.dart';
import 'package:mentor_coclen/page/menuFooter.dart';
import 'package:mentor_coclen/page/profile_page.dart';
import 'package:mentor_coclen/page/request_meetup.dart';

import 'home_page.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.home;

  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.assignment_rounded: GlobalKey<NavigatorState>(),
    TabItem.assignment_turned_in_outlined: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      MEETUP_ACCEPT(),
      RequestMeetup(),
      AccountPage()
    ];

    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            // if not on the 'main' tab
            if (_currentTab != TabItem.home) {
              // select 'main' tab
              _selectTab(TabItem.home);
              // back button handled by app
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: _widgetOptions.elementAt(_currentTab.index),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.red,
              ),
              child: MenuFooter(
                currentTab: _currentTab,
                onSelectTab: _selectTab,
              ),
            )));
  }
}

enum TabItem {
  home,
  assignment_rounded,
  assignment_turned_in_outlined,
  account
}

const Map<TabItem, String> tabName = {
  TabItem.home: 'Trang chủ',
  TabItem.assignment_rounded: 'Mentup',
  TabItem.assignment_turned_in_outlined: 'Yêu Cầu',
  TabItem.account: 'Cài đặt',
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.home: Icons.home,
  TabItem.assignment_rounded: Icons.assignment_rounded,
  TabItem.assignment_turned_in_outlined: Icons.assignment_turned_in_outlined,
  TabItem.account: Icons.settings,
};
