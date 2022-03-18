import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/model/pushNotification.dart';
import 'package:mentor_coclen/page/meetup_page.dart';

class HomePage extends StatefulWidget {
  TabBar get _tabBar => TabBar(
        labelColor: MaterialColors.primary,
        indicatorWeight: 2,
        labelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        indicatorColor: Color(0xff107162),
        unselectedLabelColor: Colors.black54,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        tabs: [
          Tab(
            text: ("Hiện có"),
          ),
          Tab(
            text: ("Yêu cầu"),
          ),
          Tab(
            text: ("Đã hoàn thành"),
          ),
        ],
      );
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final _controller = TextEditingController();
  String inputText = "";
  bool isSearch = false;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  PushNotificationModel? _notificationInfo;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "";

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

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'Tìm một Meetup...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      onSubmitted: (value) {
        // Navigator.pushNamed(context, "/search-result",
        //     arguments:
        //         ScreenArgumentsSearchReuslt(keySearch: value, type: "mentor"));
      },
      onChanged: (text) {
        setState(() {
          inputText = text;
        });
      },
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
    );
  }

  Widget _buildTitleAppbar() {
    return Text("Meetup của tôi");
  }

  @override
  void initState() {
    if (auth.currentUser != null) {
      var mail = auth.currentUser?.email;
      setState(() {
        email = mail!;
      });
    }
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

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 180,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: MaterialColors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                        radius: 40.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Tom Cruise',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                color: Colors.white,
                                fontSize: 25.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            email,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                color: Colors.white,
                                fontSize: 15.0),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Thông tin cá nhân',
                    style: TextStyle(fontSize: 18, fontFamily: "Roboto")),
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Thông báo',
                    style: TextStyle(fontSize: 18, fontFamily: "Roboto")),
                onTap: () {
                  Navigator.pushNamed(context, "/notification");
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Đăng xuất',
                    style: TextStyle(fontSize: 18, fontFamily: "Roboto")),
                onTap: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth
                      .signOut()
                      .then((value) => Navigator.pushNamed(context, '/'));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: isSearch ? _buildSearchField() : _buildTitleAppbar(),
          backgroundColor: MaterialColors.primary,
          bottom: PreferredSize(
            preferredSize: widget._tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.white,
              child: widget._tabBar,
            ),
          ),
          actions: <Widget>[
            if (isSearch) ...[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  // do something

                  setState(() {
                    isSearch = false;
                  });
                },
              ),
            ] else ...[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  // do something
                  setState(() {
                    isSearch = true;
                  });
                },
              ),
            ],
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                // do something
                // setState(() {
                //   isSearch = false;
                // });
              },
            ),
          ],
        ),
        body: TabBarView(children: [MySessionPage(), Container(), Container()]),
      ),
    );
  }
}
