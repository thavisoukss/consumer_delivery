import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:consumer_delivery/model/OrderTemp.dart';
import 'package:consumer_delivery/page/ButtomNavigator.dart';
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:consumer_delivery/model/Shop.dart' as shop;
import 'package:consumer_delivery/model/MapCal.dart' as map;
import 'package:consumer_delivery/share/shareConstant.dart';
import 'package:consumer_delivery/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:consumer_delivery/model/Distributor.dart' as dis;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart'; //for date format

class Order1 extends StatefulWidget {
  @override
  _Order1State createState() => _Order1State();
}

class _Order1State extends State<Order1> {
  shop.Shop _shopByID = new shop.Shop();
  List<shop.Data> _listShopByID = new List<shop.Data>();

  dis.Distributor _distributor = new dis.Distributor();
  List<dis.Data> _listDistributor = new List<dis.Data>();

  OrderTemp orderTemp;
  List<Data> _listorderTempData = [];
  Data orderTempData = new Data();
  String user;

  GoogleMapController mapController;
  LatLng _initialPosition = LatLng(0.0, 0.0);

  LocationData currentLocation;
  LocationData currentLocation1;
  final Set<Marker> _markers = {};
  Location _location = Location();

  List<map.Data> _listCal = List<map.Data>();
  List<double> shopID;

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

  Future _getOrderTemp() async {
    await _getSharUsr();
    apiCall.getOrderTemp(username: user).then((value) {
      setState(() {
        orderTemp = value;
        _listorderTempData = orderTemp.data;
      });
    });
  }

  Future _orderTemp(
      var id, name, barCode, ccy, user_name, unit, price, prices) async {
    var orderNo;
    orderNo = orderTemp.data[0].oRDERNO;
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
    // get order temp
    setState(() {
      _getOrderTemp();
    });
  }

  Future _minus(var amount, itemCode, index) async {
    if (amount == 1) {
      // not do anything
    } else {
      // minus order
      await _orderTemp(
          itemCode,
          _listorderTempData[index].iTEMNAME,
          _listorderTempData[index].iTEMCODE,
          _listorderTempData[index].cCY,
          user,
          -1,
          _listorderTempData[index].pRICE,
          _listorderTempData[index].pRICE * -1);
    }
  }

  Future _plus(var itemCode, index) async {
    // minus order
    await _orderTemp(
        itemCode,
        _listorderTempData[index].iTEMNAME,
        _listorderTempData[index].iTEMCODE,
        _listorderTempData[index].cCY,
        user,
        1,
        _listorderTempData[index].pRICE,
        _listorderTempData[index].pRICE);
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

  Future<String> formatdateTime() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MMM-yyyy hh:mm');
    String formatted = formatter.format(now);

    return formatted;
  }

  Future<String> gennerate_orderID() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmm');
    String formatted = formatter.format(now);
    String order_ID = "WT" + formatted;
    return order_ID;
  }

  // get all shop
  _getShopID() async {
    String us = "shopID";
    getShopID(shareName: us).then((result) {
      _getShopByID(result);
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

// get current location
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

    print("end check list");
    print("start call noti");

    for (int n = 0; n < 3; n++) {
      print(_listCal[n].toJson());
    }
  }

  // short 3 shop
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

  Future _getDistributor() async {
    apiCall.getAllDistributor().then((value) {
      _distributor = value;
      setState(() {
        _listDistributor = _distributor.data;
      });
      getCurrentLocation();
    });
  }

// submit order
  check() async {
    List<Data> _listOrderTemp = new List<Data>();
    //
    // String datetime;
    // await formatdate().then((value) {
    //   datetime = value;
    // });
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
        sub_dis.add(_listCal[y].disID);
        sub_dis.add(_listCal[y].disName);
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

  // call api postOrder

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

  @override
  void initState() {
    _getOrderTemp();
    _getShopID();
    _getDistributor();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ລາຍການສິນຄ້າທີ່ສັ່ງ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [_groupOrder(), _groupBill()],
          ),
        ),
      ),
    );
  }

  Widget _groupOrder() {
    return Container(
      child: Card(
        child: Column(
          children: [
            _header(),
            _divider(),
            _detail(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Divider(
        color: Colors.green,
        thickness: 1,
      ),
    );
  }

  Widget _divider1() {
    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: Divider(
        color: Colors.green,
        thickness: 0.5,
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xff09b83e),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  'ກະຕ່າສິນຄ້າ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff09b83e),
                  ),
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: orderTemp == null
                          ? Text('')
                          : Text(
                              orderTemp.total.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffff3300),
                              ),
                            ),
                    )),
              ))
        ],
      ),
    );
  }

  Widget _detail() {
    return _listorderTempData.isEmpty
        ? Container()
        : Container(
            height: 350,
            child: Column(
              children: [
                Container(
                    height: 340,
                    child: ListView.builder(
                        itemCount: _listorderTempData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: _left(
                                            _listorderTempData[index].iTEMNAME,
                                            _listorderTempData[index].pRICE)),
                                    Expanded(
                                      flex: 5,
                                      child: _center(
                                          _listorderTempData[index].sUBTOTAL,
                                          _listorderTempData[index].aMOUNT,
                                          _listorderTempData[index].iTEMID,
                                          index),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: _right(
                                            _listorderTempData[index].oRDERNO,
                                            _listorderTempData[index].iTEMID))
                                  ],
                                ),
                                _divider1(),
                              ],
                            ),
                          );
                        })),
              ],
            ),
          );
  }

  Widget _left(var itemName, var price) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              itemName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Container(
            child: Text(
              price.toString(),
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget _center(var subtotal, amount, itemCode, index) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              subtotal.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xff09b83e)),
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _minus(amount, itemCode, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff09b83e),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                      )),
                  height: 30,
                  width: 30,
                  //color: Color(0xff09b83e),
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 70,
                color: Colors.grey[200],
                child: Center(child: Text(amount.toString())),
              ),
              GestureDetector(
                onTap: () {
                  _plus(itemCode, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff09b83e),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      )),
                  height: 30,
                  width: 30,
                  //color: Color(0xff09b83e),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _right(var orderNo, itemID) {
    return GestureDetector(
      onTap: () {
        _deleteItemTemp(orderNo, itemID);
      },
      child: Container(
        child: Icon(
          Icons.delete_outlined,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _groupBill() {
    return Container(
      child: Card(
        child: Column(
          children: [
            _bill_header(),
            _divider(),
            _billDetail(),
            _divider(),
            _submit()
          ],
        ),
      ),
    );
  }

  Widget _bill_header() {
    return Container(
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.monetization_on,
                color: Color(0xff09b83e),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                child: Text(
                  'ລາຄາທັງໝົດ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff09b83e),
                  ),
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffff3300),
                        ),
                      ),
                    )),
              ))
        ],
      ),
    );
  }

  Widget _billDetail() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: Container(
                      child: Text(
                        'ລາຄາສັ່ງທັງໝົດ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 15),
                    child: Container(
                      child: orderTemp == null
                          ? Text('')
                          : Text(
                              orderTemp.total.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                    ),
                  )
                ]),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Container(
                    child: Text(
                      'ລາຄາໃຊ້ຈ່າຍທັງໝົດ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 15),
                  child: Container(
                    child: orderTemp == null
                        ? Text('')
                        : Text(orderTemp.total.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _submit() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            check();
          },
          color: Color(0xff09b83e),
          child: Text(
            'ຢືນຢັນການສັ່ງ !',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
