import 'package:consumer_delivery/page/Login.dart';
import 'package:consumer_delivery/provider/ItemProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingAndroid = AndroidInitializationSettings('teapot');
  var initializationSettingIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, body, payload) async {});

  var initializationSetting = InitializationSettings(
      android: initializationSettingAndroid, iOS: initializationSettingIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSetting,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload' + payload);
    }
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AddItemProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer app',
      theme: ThemeData(primaryColor: Color(0xff09b83e)),
      home: Login(),
    );
  }
}
