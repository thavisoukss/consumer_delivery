import 'package:consumer_delivery/model/Item.dart';
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:consumer_delivery/model/OrderTemp.dart' as Order;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final int id;

  const Detail({Key key, this.id}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var count = 0;
  bool count_staus = true;
  var user;
  var totalAmount = 0;

  Item item;
  List<Data> _listitem = [];
  Order.OrderTemp orderTemp;

  getItemByID(var id) async {
    item = await apiCall.getItemByID(id);
    setState(() {
      _listitem = item.data;
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

  Future _minus() {
    setState(() {
      count = count - 1;
    });
    if (count == 0) {
      count_staus = false;
      count = 0;
    }
  }

  Future _plus() {
    setState(() {
      count = count + 1;
    });
    if (count > 0) {
      setState(() {
        count_staus = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    count_staus = true;
    getItemByID(widget.id);
    _getOrderTemp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: _listitem.isEmpty
                        ? Text('')
                        : Text(_listitem[0].iTEMNAME,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                    background: Image.network(
                      "https://images.deliveryhero.io/image/fd-la/LH/z1pf-listing.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Container(
            child: Stack(
              children: [
                _group(),
                Align(alignment: Alignment.bottomCenter, child: _add())
              ],
            ),
          )),
    );
  }

  Widget _group() {
    return Column(
      children: [_detail(), _controll()],
    );
  }

  Widget _detail() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              height: 50,
              child: Text(
                'ລາຍລະອຽດ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Text(
                        'ສິນຄ້າ : ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      width: 300,
                      child: _listitem.isEmpty
                          ? Text('')
                          : Text(_listitem[0].iTEMNAME,
                              style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Text('ລາຍລະອຽດສິນຄ້າ : ',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Container(
                      width: 200,
                      child: _listitem.isEmpty
                          ? Text('')
                          : Text(_listitem[0].iTEMDESC,
                              style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Text(
                        'ລາຄາສິນຄ້າ :',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: _listitem.isEmpty
                          ? Text('')
                          : Text(_listitem[0].iTEMPRICE.toString()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Divider(
              height: 10,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  Widget _controll() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: totalAmount < 1
          ? Container()
          : Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(9, 184, 62, 50),
                  borderRadius: BorderRadius.circular(50)),
              width: 200,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: count_staus
                          ? GestureDetector(
                              onTap: () {
                                _minus();
                              },
                              child: Container(
                                  child: Icon(
                                Icons.remove_circle,
                                color: Colors.white,
                                size: 40,
                              )),
                            )
                          : Container(
                              child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 40,
                            ))),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        child: Text(
                          '' + count.toString(),
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _plus();
                      },
                      child: Container(
                          child: Icon(
                        Icons.add_circle,
                        color: Colors.white,
                        size: 40,
                      )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _add() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: totalAmount < 1
          ? Container()
          : Container(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Color.fromRGBO(9, 184, 62, 50),
                textColor: Colors.white,
                child: Text(
                  'ເພີ່ມລາຍການ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _orderTemp(
                      _listitem[0].iD,
                      _listitem[0].iTEMNAME,
                      _listitem[0].iTEMBARCODE,
                      _listitem[0].iTEMCCY,
                      user,
                      count,
                      _listitem[0].iTEMPRICE,
                      count * _listitem[0].iTEMPRICE);
                },
              )),
    );
  }
}
