import 'package:consumer_delivery/page/Dashbord.dart';
import 'package:consumer_delivery/page/ListOrder.dart';
import 'package:consumer_delivery/page/Search.dart';
import 'package:consumer_delivery/page/Setp.dart';
import 'package:consumer_delivery/page/TestNoti.dart';
import 'package:consumer_delivery/page/order1.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatefulWidget {
  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _currentIndex = 0;
  List<Widget> _child = [DashBord(), Order1(), ListOrder(), Setp()];

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
              title: Text('ກຳລັງສັ່ງສິນຄ້າ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              title: Text('ສັ່ງສິນຄ້າເເລ້ວ'),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications_active),
            //   title: Text('ລາຍງານ'),
            // ),
          ]),
    );
  }
}
