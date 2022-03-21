import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ButtonSetting {
  account,
  nofi,
  history,
  logout
}
const Map<ButtonSetting, String> btnSetting = {
  ButtonSetting.account: 'Tài khoản',
  ButtonSetting.nofi: 'Thông báo',
  ButtonSetting.history: 'Lịch sử',
  ButtonSetting.logout: 'Đăng xuất',
};

class _AccountPage extends State<AccountPage> {
  final List<AccountModel> account = <AccountModel>[
    AccountModel(
        title: btnSetting[ButtonSetting.account].toString(),
        icon: Icons.account_circle),
    AccountModel(
        title: btnSetting[ButtonSetting.history].toString(),
        icon: Icons.history),
    AccountModel(
        title: btnSetting[ButtonSetting.nofi].toString(),
        icon: Icons.notifications),
    AccountModel(
        title: btnSetting[ButtonSetting.logout].toString(), icon: Icons.logout)
  ];

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onClick(item) async {
    if (item == btnSetting[ButtonSetting.logout].toString()) {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.clear,
      );
      FirebaseAuth auth = FirebaseAuth.instance;

      var docSnapshot =
          await db.collection("users").doc(auth.currentUser!.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var fcmToken = data?['fcmToken'];
        var userId = auth.currentUser!.uid;
        await db
            .collection("users")
            .doc(auth.currentUser!.uid)
            .delete()
            .then((value) => {
                  auth.signOut().then((value) => {
                        ApiServices.postLogoutToInsertFCM(userId, fcmToken)
                            .then((value) => {
                                  EasyLoading.dismiss(),
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/login', (Route<dynamic> route) => false)
                                })
                      })
                });
      }
    } else if (item == btnSetting[ButtonSetting.nofi].toString()) {
      Navigator.pushNamed(context, '/notification');
    } else if (item == btnSetting[ButtonSetting.account].toString()) {
      Navigator.pushNamed(context, '/profile');
    } else if (item == btnSetting[ButtonSetting.history].toString()) {
      Navigator.pushNamed(context, '/history',
          arguments: auth.currentUser!.uid);
    }
    // } else if (index == btnSetting[ButtonSetting.history]) {
    //   Navigator.pushNamed(context, '/history');
    // } else if (index == btnSetting[ButtonSetting.sessions]) {
    //   Navigator.pushNamed(context, '/my-session');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MaterialColors.primary,
            automaticallyImplyLeading: false,
            title: const Center(
              child: Text(
                "Thiết lập",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                ),
              ),
            )),
        body: Column(children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: CircleAvatar(
                          radius: 45, // Image radius
                          backgroundImage: NetworkImage(
                              "https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg"),
                        ),
                      )),
                  Expanded(
                      flex: 7,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                auth.currentUser!.email.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20, bottom: 8),
                            ),
                            Container(
                              child: Text(
                                "ID: ${auth.currentUser!.uid}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black45,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 10,
              child: ListView.builder(
                  itemCount: account.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () => {
                              onClick(account[index].title),
                            },
                        child: Container(
                          padding: const EdgeInsets.only(left: 25, right: 15),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black12, width: 1.0))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        account[index].title,
                                        style: const TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  Expanded(
                                    child: Icon(account[index].icon,
                                        color: MaterialColors.primary),
                                    flex: 2,
                                  )
                                ],
                              )),
                        ));
                  }))
        ]));
  }
}

class AccountPage extends StatefulWidget {
  @override
  _AccountPage createState() => _AccountPage();
}
