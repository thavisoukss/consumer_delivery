import 'dart:io';
import 'package:consumer_delivery/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TestNoti extends StatefulWidget {
  @override
  _TestNotiState createState() => _TestNotiState();
}

class _TestNotiState extends State<TestNoti> {
  @override
  void initState() {
    aboutNotification();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test notification'),
      ),
      body: GestureDetector(
        onTap: () {
          showNoti();
        },
        child: Container(
          width: 100,
          height: 30,
          child: Text('click test Notification'),
        ),
      ),
    );
  }

  void showNoti() async {
    var notificationDateTime = DateTime.now().add(Duration(seconds: 10));

    var androidPlatform = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        sound: RawResourceAndroidNotificationSound('sound2'),
        importance: Importance.max,
        priority: Priority.high);

    var IOSPltatform = IOSNotificationDetails(
        sound: 'sound2.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChanel =
        NotificationDetails(android: androidPlatform, iOS: IOSPltatform);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'test', 'hello', notificationDateTime, platformChanel);

    print('done send notification sms');
  }

  void aboutNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    if (Platform.isAndroid) {
      await firebaseMessaging.configure(onBackgroundMessage: (message) {
        print('hello onLunch');
        showNoti();
      }, onMessage: (message) {
        print('hello onMessage');
        showNoti();
      }, onResume: (message) {
        print('hello OnResume');
        showNoti();
      });
    } else if (Platform.isIOS) {
      await firebaseMessaging.configure(onLaunch: (message) {
        print('hello onLunch');
      }, onMessage: (message) {
        print('hello onMessage');
      }, onResume: (message) {
        print('hello OnResume');
      });
    }
  }
}
