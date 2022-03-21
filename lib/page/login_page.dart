import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mentor_coclen/apis/apiService.dart';
import 'package:mentor_coclen/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // checkUserAuth();
    super.initState();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  signIn() {
    String email = _email.text;
    String pass = _pass.text;
    if (email.isEmpty || pass.isEmpty) {
      showDialog(
          context: context,
          builder: (build) {
            return AlertDialog(
              title: Text("Thông báo"),
              content:
                  Text("Email hoặc mật khẩu của bạn không chính xác"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(build);
                    },
                    child: Text("OK"))
              ],
            );
          });
    } else {
      try {
        EasyLoading.show(
          status: 'loading...',
          maskType: EasyLoadingMaskType.clear,
        );
        auth
            .signInWithEmailAndPassword(email: email, password: pass)
            .then((value) async {
          if (value.user != null) {
            String? fcmToken = await messaging.getToken();
            print("fcmToken: ${fcmToken}");
            User user = value.user!;

            ApiServices.postLoginToInsertFCM(user.uid, fcmToken!)
                .then((role) => {
                      print("value: $role"),
                      if (role != null)
                        {
                          if (role == "3")
                            {
                              db.collection("users").doc(user.uid).set({
                                'email': user.email,
                                'fcmToken': fcmToken,
                              }),

                              // Navigator.pop(context);
                              EasyLoading.dismiss(),
                              Navigator.pushReplacementNamed(context, '/home')
                            }
                        }
                    });
          }
        }).catchError((onError) {
          EasyLoading.dismiss();
          showDialog(
              context: context,
              builder: (build) {
                return AlertDialog(
                  title: Text("Thông báo"),
                  content: Text(
                      "Email hoặc mật khẩu của bạn không chính xác"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(build);
                        },
                        child: Text("OK"))
                  ],
                );
              });
        });
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        EasyLoading.dismiss();
      } catch (e) {
        print(e);
        EasyLoading.dismiss();
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 65,
                child: Image.asset(
                  'assets/coctrensach5.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "For Mentor !",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Image.asset(
              'assets/welcome.PNG',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 50,
            ),
            padding: EdgeInsets.only(left: 20, bottom: 5, top: 5),
            decoration: BoxDecoration(
                color: MaterialColors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12)),
            child: TextFormField(
              cursorColor: MaterialColors.primary,
              controller: _email,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.account_circle,
                    size: 28,
                    color: MaterialColors.primary,
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: MaterialColors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _pass,
              decoration: InputDecoration(
                  hintText: "Mật khẩu",
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.lock_open_outlined,
                    size: 28,
                    color: MaterialColors.primary,
                  )),
              obscureText: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // context.read<AppProvider>().setUserLogin("hoangthai123");
                // context.read<AppProvider>().setIsLogin();
                // Navigator.pop(context);
                // Navigator.pushNamed(context, '/home');
                signIn();
              },
              style: ElevatedButton.styleFrom(
                primary: MaterialColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(width: 1, color: MaterialColors.primary)),
              ),
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
