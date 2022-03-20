import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mentor_coclen/page/acount_page.dart';
import 'package:mentor_coclen/page/home_page.dart';
import 'package:mentor_coclen/page/menuFooter.dart';
import 'package:mentor_coclen/page/profile_page.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.home;

  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.mentor: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
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
      HomePage(),
      HomePage(),
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

enum TabItem { home, mentor, search, account }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Trang chủ',
  TabItem.mentor: 'Mentor',
  TabItem.search: 'Tìm kiếm',
  TabItem.account: 'Cài đặt',
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.home: Icons.home,
  TabItem.mentor: Icons.account_circle,
  TabItem.search: Icons.search,
  TabItem.account: Icons.settings,
};
