import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:consumer_delivery/model/Item.dart';
import 'package:consumer_delivery/model/OrderTemp.dart' as Order;
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Item item;
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

  _orderTemp(var id, name, barCode, ccy, user_name, unit, price, prices) async {
    var orderNo;
    if (orderTemp.data.isEmpty) {
      await formatdate().then((value) {
        orderNo = value;
      });
    } else {
      orderNo = orderTemp.data[0].oRDERNO;
    }
    var res = apiCall.orderTemp(
        item_id: id,
        item_name: name,
        item_barcode: barCode,
        order_no: orderNo,
        ccy: ccy,
        user_name: user_name,
        unit: unit,
        price: price,
        prices: prices);
  }

  getToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String token = await firebaseMessaging.getToken();

    print("my token is " + token);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getAllItem();
    _getOrderTemp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('home')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 9,
                    left: 14,
                    child: totalAmount == 0
                        ? Container(
                            child: Text(''),
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: Text(
                                NumberFormat().format(totalAmount),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: _listItemWidget(),
    );
  }

  _showPopup(Data item) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.INFO,
      body: Center(
        child: Text(
          'ທ່ານໄດ້ສັ່ງ : ' + item.iTEMNAME,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      title: 'ສັ່ງສິນຄ້າ',
      desc: 'This is also Ignored',
      btnCancelOnPress: () {
        print('cancle click');
      },
      btnOkOnPress: () {
        _orderTemp(item.iD, item.iTEMNAME, item.iTEMBARCODE, item.iTEMCCY, user,
            1, item.iTEMPRICE, item.iTEMPRICE);
      },
      btnOkIcon: Icons.check_circle,
      btnCancelIcon: Icons.close,
      btnCancelText: 'ຍົກເລີກ',
      btnOkText: 'ສັ່ງ',
    )..show();
  }

  Widget _listItemWidget() {
    return _listItem == null
        ? Center(
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _listItem.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        _showPopup(_listItem[index]);
                      },
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                                //child: Image.asset('assests/imgs/beer.png'),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                            "ສິນຄ້າ :  " +
                                                _listItem[index].iTEMNAME,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                      Container(
                                        child: Text(
                                          "ລາຄາ :  " +
                                              NumberFormat().format(
                                                  _listItem[index].iTEMPRICE) +
                                              "  " +
                                              _listItem[index]
                                                  .iTEMCCY
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )),
                    ),
                  );
                }));
  }
}
