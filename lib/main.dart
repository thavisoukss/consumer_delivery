import 'package:consumer_delivery/page/Login.dart';
import 'package:consumer_delivery/provider/ItemProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
