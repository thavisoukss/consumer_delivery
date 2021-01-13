import 'package:consumer_delivery/model/Item.dart' as item;
import 'package:consumer_delivery/model/OrderTemp.dart';
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:flutter/material.dart';
import 'package:consumer_delivery/apiCall/api.dart';

class Order1 extends StatefulWidget {
  @override
  _Order1State createState() => _Order1State();
}

class _Order1State extends State<Order1> {
  item.Item items;
  List<item.Data> _listitem = [];

  OrderTemp orderTemp;
  List<Data> _listorderTempData = [];
  Data orderTempData = new Data();
  String user;

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
    _getOrderTemp();
  }

  Future _getITemByID(var id) async {
    items = await apiCall.getItemByID(id);
    setState(() {
      _listitem = items.data;
    });
  }

  Future _minus(var amount, itemCode) async {
    if (amount == 1) {
      // not do anything
    } else {
      // minus order
      await _orderTemp(
          itemCode,
          _listorderTempData[0].iTEMNAME,
          _listorderTempData[0].iTEMCODE,
          _listorderTempData[0].cCY,
          user,
          -1,
          _listorderTempData[0].pRICE,
          _listorderTempData[0].pRICE * -1);
    }
  }

  Future _plus(var itemCode) async {
    // minus order
    await _orderTemp(
        itemCode,
        _listorderTempData[0].iTEMNAME,
        _listorderTempData[0].iTEMCODE,
        _listorderTempData[0].cCY,
        user,
        1,
        _listorderTempData[0].pRICE,
        _listorderTempData[0].pRICE);
  }

  @override
  void initState() {
    _getOrderTemp();
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
                                            _listorderTempData[index].iTEMID)),
                                    Expanded(flex: 1, child: _right())
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

  Widget _center(var subtotal, amount, itemCode) {
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
                  _minus(amount, itemCode);
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
                  _plus(itemCode);
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

  Widget _right() {
    return Container(
      child: Icon(
        Icons.delete_outlined,
        color: Colors.red,
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
          onPressed: () {},
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
