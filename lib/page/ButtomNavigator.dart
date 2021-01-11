import 'package:consumer_delivery/page/Dashbord.dart';
import 'package:consumer_delivery/page/History.dart';
import 'package:consumer_delivery/page/Home.dart';
import 'package:consumer_delivery/page/order.dart';
import 'package:consumer_delivery/page/Setp.dart';
import 'package:consumer_delivery/page/order1.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatefulWidget {
  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _currentIndex = 0;
  List<Widget> _child = [DashBord(), Order1(), History(), Setp()];

  void _onTapBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _child[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onTapBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('ໜ້າຫຼັກ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('ລາຍການສັ່ງສິນຄ້າ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              title: Text('ລາຍການສັ່ງຍ້ອນຫລັງ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text('ລາຍງານ'),
            ),
          ]),
    );
  }
}
