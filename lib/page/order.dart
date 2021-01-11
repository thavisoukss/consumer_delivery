//import 'package:consumer_delivery/model/Item.dart';
//import 'package:consumer_delivery/provider/ItemProvider.dart';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:consumer_delivery/model/Distributor.dart' as dis;
import 'package:consumer_delivery/model/MapCal.dart' as map;
import 'package:consumer_delivery/model/OrderTemp.dart';
import 'package:consumer_delivery/model/Shop.dart' as shop;
import 'package:consumer_delivery/page/ButtomNavigator.dart';
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:consumer_delivery/share/shareConstant.dart';
import 'package:consumer_delivery/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/intl.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  GoogleMapController mapController;
  LatLng _initialPosition = LatLng(0.0, 0.0);
  OrderTemp orderTemp;
  List<Data> orderTempData = [];

  String user;
  //var oldshopID;

  shop.Shop _shopByID = new shop.Shop();
  List<shop.Data> _listShopByID = new List<shop.Data>();

  dis.Distributor _distributor = new dis.Distributor();
  List<dis.Data> _listDistributor = new List<dis.Data>();

  LocationData currentLocation;
  LocationData currentLocation1;
  final Set<Marker> _markers = {};
  Location _location = Location();

  List<map.Data> _listCal = List<map.Data>();
  List<double> shopID;

  Future<String> formatdate() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmm');
    String formatted = formatter.format(now);
    String order_ID = "WT" + formatted;
    return order_ID;
  }

  Future<String> formatdateTime() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MMM-yyyy hh:mm');
    String formatted = formatter.format(now);

    return formatted;
  }

  Future _deleteItemTemp(var order_id, item) async {
    var result;
    await apiCall.DeleteOrderTemp(order_no: order_id, item: item).then((value) {
      setState(() {
        result = value;
      });
    });
    if (result == 'success') {
      await _Dialog('ລົບລາຍການສຳເລັດ');
      setState(() {
        _getOrderTemp();
      });
    } else {
      await _Dialog('ລົບລາຍການບໍ່ສຳເລັດ');
      setState(() {
        _getOrderTemp();
      });
    }
  }

  check() async {
    List<Data> _listOrderTemp = new List<Data>();

    String datetime;
    await formatdate().then((value) {
      datetime = value;
    });
    List detail = List();
    var sub_detail = [];
    List dis = List();
    var sub_dis = [];
    _listOrderTemp = orderTemp.data;

    if (_listOrderTemp.isEmpty) {
      print("no order");
    } else {
      for (int i = 0; i < _listOrderTemp.length; i++) {
        var item_id = _listOrderTemp[i].iTEMID;
        var barcode = _listOrderTemp[i].iTEMCODE;
        var item_name = _listOrderTemp[i].iTEMNAME;
        var unit = _listOrderTemp[i].aMOUNT;
        var price = _listOrderTemp[i].pRICE;
        var ccy = _listOrderTemp[i].cCY;
        var invoice = _listOrderTemp[0].oRDERNO;

        sub_detail.add(item_id);
        sub_detail.add(barcode);
        sub_detail.add(item_name);
        sub_detail.add(unit);
        sub_detail.add(price);
        sub_detail.add(ccy);
        sub_detail.add(price);
        sub_detail.add(item_name);
        sub_detail.add(invoice);

        detail.insert(i, sub_detail);
        sub_detail = [];
      }

      for (int y = 0; y < 3; y++) {
        sub_dis.add(_listOrderTemp[0].oRDERNO);
        sub_dis.add(_listShopByID[0].iD);
        sub_dis.add(_listShopByID[0].sHOPNAME);
        sub_dis.add(_listDistributor[y].iD);
        sub_dis.add(_listDistributor[y].dISTRIBUTORNAME);
        sub_dis.add("NEW");

        dis.insert(y, sub_dis);
        sub_dis = [];
      }

      print(detail);
      print("============");
      // print(dis.toString());
      var detail_obj = detail.toString();
      var dis_obj = dis.toString();
      _postOrder(detail, dis);
    }
  }

  show() {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.INFO,
      body: Center(
        child: Text(
          'ທ່ານໄດ້ສັ່ງ : ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      title: 'ສັ່ງສິນຄ້າ',
      desc: 'This is also Ignored',
      btnCancelOnPress: () {
        print('cancle click');
      },
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      btnCancelIcon: Icons.close,
      btnCancelText: 'ຍົກເລີກ',
      btnOkText: 'ສັ່ງ',
    )..show();
  }

  sendNoti() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String token = await firebaseMessaging.getToken();
    print("my token is " + token);

    await apiCall.sendNoti(
        token: token, body: "shop id is :", title: "test noti by bee");

    if (Platform.isAndroid) {
      print("aaaa");
      await firebaseMessaging.configure(onLaunch: (message) {
        print("on Launch");
      }, onMessage: (message) {
        show();
        print("on message");
      }, onResume: (message) {
        print("on resume");
      });
    }
  }

  getCurrentLocation() async {
    Location location = Location();
    LocationData _locationData;
    _locationData = await location.getLocation();
    print(_locationData);
    double lat;
    double lng;
    lat = _locationData.latitude;
    lng = _locationData.longitude;

    setState(() {
      _initialPosition = LatLng(lat, lng);
    });

    try {
      for (int i = 0; i < _listDistributor.length; i++) {
        var lat1;
        var lng1;
        var disName;
        var dis_ID;
        lat1 = double.parse(_listDistributor[i].lASTS);
        lng1 = double.parse(_listDistributor[i].lONGS);
        disName = _listDistributor[i].dISTRIBUTORNAME;
        dis_ID = _listDistributor[i].iD;

        print("calculate map");

        await _calulatorLocation(
            lat: lat,
            lng: lng,
            lat1: lat1,
            lng1: lng1,
            index: i,
            disName: disName,
            disID: dis_ID);
      }
    } catch (e) {
      print(e);
    }

    for (int i = 0; i < _listCal.length; i++) {
      print(_listCal[i].toJson());
    }
    setState(() {
      _listCal.sort((map.Data a, map.Data b) => a.km.compareTo(b.km));
    });

    for (int i = 0; i < _listCal.length; i++) {
      print(_listCal[i].toJson());
    }

    print("end check list");
    print("start call noti");

    for (int n = 0; n < 3; n++) {
      print(_listCal[n].toJson());
    }
  }

  _calulatorLocation({var lat, lng, lat1, lng1, index, disName, disID}) async {
    double distanceInMeters = await Geolocator().distanceBetween(
      lat,
      lng,
      lat1,
      lng1,
    );
    print("test calculate ");
    print(distanceInMeters);

    map.Data cal = new map.Data(
        index: index, km: distanceInMeters, disName: disName, disID: disID);
    setState(() {
      _listCal.add(cal);
    });
  }

  _passUnit(var id, name, barcode, ccy, user_name, unit, price, prices) async {
    var orderNo;
    if (orderTemp.data.isEmpty) {
      await formatdate().then((value) {
        orderNo = value;
      });
    } else {
      orderNo = orderTemp.data[0].oRDERNO;
    }
    var res = await apiCall.orderTemp(
        item_id: id,
        item_name: name,
        item_barcode: barcode,
        order_no: orderNo,
        ccy: ccy,
        user_name: user_name,
        unit: unit,
        price: price,
        prices: prices);
    setState(() {
      _getOrderTemp();
    });
  }

  _minusUnit(var id, name, barcode, ccy, user_name, unit, price, prices) async {
    var orderNo;
    if (orderTemp.data.isEmpty) {
      await formatdate().then((value) {
        orderNo = value;
      });
    } else {
      orderNo = orderTemp.data[0].oRDERNO;
    }

    var res = await apiCall.orderTemp(
        item_id: id,
        item_name: name,
        item_barcode: barcode,
        order_no: orderNo,
        ccy: ccy,
        user_name: user_name,
        unit: unit,
        price: price,
        prices: prices);
    setState(() {
      _getOrderTemp();
    });
  }

  _getSharUsr() async {
    String us = "username";
    getUser(shareName: us).then((result) {
      setState(() {
        user = result;
        print('usrname');
        print(user);
      });
    });
  }

  _getShopID() async {
    String us = "shopID";
    getShopID(shareName: us).then((result) {
      _getShopByID(result);
    });
  }

  Future _getOrderTemp() async {
    await _getSharUsr();
    apiCall.getOrderTemp(username: user).then((value) {
      setState(() {
        orderTemp = value;
        orderTempData = orderTemp.data;
      });
    });
  }

  Future _getShopByID(var shopID) async {
    apiCall.getShopByID(shopID: shopID).then((value) {
      _shopByID = value;

      setState(() {
        _listShopByID = _shopByID.data;
      });
    });
  }

  _postOrder(var detail, dis) async {
    Dio dio = new Dio();
    var result;

    String datetime;
    await formatdateTime().then((value) {
      datetime = value;
    });

    var postData = {
      "ORDER_NO": orderTemp.data[0].oRDERNO,
      "SHOP_ID": _listShopByID[0].iD,
      "SHOP_NAME": _listShopByID[0].sHOPNAME,
      "TEL_NO": _listShopByID[0].tELNO,
      "ORDER_USER": _listShopByID[0].sHOPTYPE,
      "DELIVERY_DATE": datetime,
      "TOTAL_AMOUNT": orderTemp.total,
      "CCY": "LAK",
      "DETAILS": detail,
      "DISTRIBUTOR": dis
    };
    print("Call api order ");
    print(postData.toString());
    try {
      Response response = await dio.post(
        ShareUrl.orders,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      result = response.data;

      if (response.statusCode != 200) {
        showErrorMessage(context, 'ສັ່ງສີນຄ້າບໍ່ສຳເລັດ');
      } else {
        if (result['status'] != 'success') {
          showErrorMessage(context, 'ສັ່ງສີນຄ້າບໍ່ສຳເລັດ');
        } else {
          await showSuccessMessage(context, 'ສັ່ງສີນຄ້າສຳເລັດ');

          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) => ButtomNavigation()),
            );
          });
        }
      }
    } on DioError catch (e) {
      print(e);
      showErrorMessage(context, 'ສັ່ງສີນຄ້າບໍ່ສຳເລັດ');
    }
  }

  Future _getDistributor() async {
    apiCall.getAllDistributor().then((value) {
      _distributor = value;
      setState(() {
        _listDistributor = _distributor.data;
      });
      getCurrentLocation();
    });
  }

  Future _Dialog(var title) async {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.INFO,
      body: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      autoHide: Duration(seconds: 1),
    )..show();
    //Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    //getListItem();

    _getOrderTemp();
    //getCurrentLocation();
    // _getAllShop();
    _getDistributor();
    _getShopID();
    formatdate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການສິນຄ້າທີ່ສັ່ງ'),
      ),
      body: orderTempData.isEmpty
          ? Center(
              child: Container(
                child: Text('ບໍ່ມີລາຍການສັ່ງເຄື່ອງ'),
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: _header(),
                ),
                Expanded(
                  flex: 6,
                  child: _allOrder(),
                ),
                Expanded(
                  flex: 1,
                  child: _total(),
                )
              ],
            ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Text(
        'ລາຍການທັງຫມົດທີ່ສັ່ງ',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _allOrder() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: orderTemp == null
          ? Container(
              child: Text(''),
            )
          : ListView.builder(
              itemCount: orderTemp.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  child: Container(
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: _image(),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: _deatil(orderTemp.data[index]),
                            ),
                          ),
                          Expanded(
                              flex: 1, child: _unit(orderTemp.data[index])),
                          Expanded(
                            flex: 2,
                            child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: _contorll(orderTemp.data[index])),
                          )
                        ],
                      ),
                    ),
                  ),
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    Card(
                      child: IconSlideAction(
                        caption: 'delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        closeOnTap: false,
                        onTap: () {
                          //print(orderTemp.data[index].toJson());
                          _deleteItemTemp(orderTemp.data[index].oRDERNO,
                              orderTemp.data[index].iTEMID);
                        },
                      ),
                    )
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                  ),
                );
              }),
    );
  }

  Widget _image() {
    return Container(
        height: 83,
        child: Text(''),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(50)));
  }

  Widget _deatil(Data item) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                item.iTEMNAME,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              child: Text(
                NumberFormat().format(item.pRICE) + " " + item.cCY,
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _contorll(Data item) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _passUnit(item.iTEMID, item.iTEMNAME, item.iTEMCODE,
                            item.cCY, user, 1, item.pRICE, item.pRICE);
                      },
                      child: Container(
                        child: Icon(Icons.add, color: Colors.white),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        int price = item.pRICE - (item.pRICE * 2);
                        _minusUnit(item.iTEMID, item.iTEMNAME, item.iTEMCODE,
                            item.cCY, user, -1, item.pRICE, price);
                      },
                      child: Container(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _total() {
    return orderTemp == null
        ? Container(
            child: Text(''),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: GestureDetector(
              onTap: () {
                check();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'ຍອດລວມ ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        NumberFormat().format(orderTemp.total),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          );
  }

  _showPopup(Data res) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.INFO,
      body: Column(
        children: [
          Container(
            child: Text('ທ່ານຕ້ອງການສັ່ງສີນຄ້າເເທ້ບໍ່'),
          ),
          Container(
            child: Text(''),
          ),
        ],
      ),
      title: 'ສັ່ງສິນຄ້າ',
      desc: 'This is also Ignored',
      btnCancelOnPress: () {
        print('cancle click');
      },
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      btnCancelIcon: Icons.close,
      btnCancelText: 'ຍົກເລີກ',
      btnOkText: 'ຢືນຍັນ',
    )..show();
  }

  Widget _unit(Data item) {
    return Container(
      child: Center(
          child: Text(
        item.aMOUNT.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
      )),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    );
  }
}
