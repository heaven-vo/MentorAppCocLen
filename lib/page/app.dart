import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:mentor_coclen/model/pushNotification.dart';
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
  PushNotificationModel? _notificationInfo;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseAuth auth = FirebaseAuth.instance;


  void registerNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("on app");
        PushNotificationModel notification = PushNotificationModel(
            title: message.notification!.title,
            body: message.notification!.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body']);

        setState(() {
          _notificationInfo = notification;
        });
        print("body: ${notification.body}");
        print("title: ${notification.title}");
        if (notification != null) {
          print("thanh cong");
          _showNotification(
              _notificationInfo!.title!, _notificationInfo!.body!);
        }
      });
    } else {
      print("not permission");
    }
  }

  Future<void> _showNotification(String title, String content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, content, platformChannelSpecifics, payload: 'item x');
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (value) {});
    registerNotification();
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
