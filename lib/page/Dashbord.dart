
import 'package:consumer_delivery/model/ItemType.dart' as ItemType;
import 'package:consumer_delivery/page/Detail.dart';
import 'package:consumer_delivery/page/listITemByID.dart';
import 'package:flutter/material.dart';
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:consumer_delivery/model/Item.dart';
import 'package:consumer_delivery/model/OrderTemp.dart' as Order;
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/intl.dart';

class DashBord extends StatefulWidget {
  @override
  _DashBordState createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {

  Item item;
  ItemType.ITemType itemType;
  List<ItemType.Data> _listItemType;
  List<Data> _listItem;
  Data Objitem;
  Order.OrderTemp orderTemp;
  var user;
  var totalAmount = 0;


  getAllItem() async {
    item = await apiCall.getAllItem();
    setState(() {
      _listItem = item.data;
    });
  }

  getAllItemType() async {
    itemType = await apiCall.getAllItemType();
    print(itemType.toJson());
    setState(() {
      _listItemType = itemType.data;
    });
  }

  _getUSer() async {
    String us = "username";
    getUser(shareName: us).then((result) {
      user = result;
    });
  }

  _getOrderTemp() async {
    await _getUSer();
    apiCall.getOrderTemp(username: user).then((value) {
      setState(() {
        orderTemp = value;
        totalAmount = orderTemp.data.length;
      });
    });
  }

  Future<String> formatdate() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmm');
    String formatted = formatter.format(now);
    String order_ID = "WT" + formatted;
    return order_ID;
  }


  @override
  void initState() {
    _getOrderTemp();
    getAllItem();
    getAllItemType();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Text(
                      'ຄົ້ນຫາສິນຄ້າ.....',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 250,
              child: Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 17, right: 10),
            child: Container(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  Container(
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 15,
                    child: Container(
                      child: Center(
                          child: Text(
                        totalAmount.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'ກຸ່ມສິນຄ້າ',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              color: Colors.white,
              child: _group(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                child: Text(
                  'ປະເພດສິນຄ້າ',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 700,
              child: _type(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _group() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        child: ListView.builder(
            itemCount: _listItemType.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListITemByID(idTypes:_listItemType[index].iD)),
                    );
                  },
                  child: Card(
                    child: Container(
                      height: 120,
                      width: 120,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            child: Image.network(
                              'https://images.deliveryhero.io/image/fd-la/LH/z1pf-listing.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  _listItemType[index].iTEMTYPENAME,
                                  style: TextStyle(
                                      color: Colors.grey,fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _type(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail()),
        );
      },
      child: Container(
        child: ListView.builder(
          itemCount: _listItem.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://images.deliveryhero.io/image/fd-la/LH/z1pf-listing.jpg',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  _listItem[index].iTEMNAME,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text( _listItem[index].iTEMDESC,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 2, bottom: 2),
                                      child: Text(
                                        'discount 10 %',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xff09b83e),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.navigate_next,
                            color: Color(0xff09b83e),
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
