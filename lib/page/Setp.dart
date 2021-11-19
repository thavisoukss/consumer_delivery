import 'package:consumer_delivery/model/OrderDetail.dart';
import 'package:flutter/material.dart';
import 'package:consumer_delivery/model/step.dart' as step;
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:intl/intl.dart';

class Setp extends StatefulWidget {
  final String orderID;

  const Setp({Key key, this.orderID}) : super(key: key);
  @override
  _SetpState createState() => _SetpState();
}

class _SetpState extends State<Setp> {
  var format_currency = NumberFormat("#,##0.00","en_USD");

  Color _colorActive = Color(0xff09b83e);
  Color _colorInActive = Colors.grey;

  Color _colorOrder;
  Color _colorAccept;
  Color _colorSending;
  Color _colorInvoice;

  step.Step _setp;
  List<step.Data> _liststep = [];

  String aa;

  OrderDetail _orderDetail;
  List<Data> _listOrderDetail = [];

  Future getStep(var orderNo) {
    apiCall.getStep(orderNo).then((value) {
      setState(() {
        _setp = value;
        _liststep = _setp.data;
        changeColor(_liststep.length);
      });
    });
  }

  Future getOrderDetail(var orderNo) {
    apiCall.getOrderDetail(orderNo).then((value) {
      setState(() {
        _orderDetail = value;
        _listOrderDetail = _orderDetail.data;
      });
    });
  }

  changeColor(var lenght) {
    if (lenght == 1) {
      setState(() {
        _colorOrder = _colorActive;
        _colorAccept = _colorInActive;
        _colorSending = _colorInActive;
        _colorInvoice = _colorInActive;
      });
    } else if (lenght == 2) {
      setState(() {
        _colorOrder = _colorActive;
        _colorAccept = _colorActive;
        _colorSending = _colorInActive;
        _colorInvoice = _colorInActive;
      });
    } else if (lenght == 3) {
      setState(() {
        _colorOrder = _colorActive;
        _colorAccept = _colorActive;
        _colorInvoice = _colorInActive;
        _colorSending = _colorInActive;
      });
    } else if (lenght == 4) {
      setState(() {
        _colorOrder = _colorActive;
        _colorAccept = _colorActive;
        _colorSending = _colorActive;
        _colorInvoice = _colorActive;
      });
    } else if (lenght > 4) {
      setState(() {
        _colorOrder = _colorActive;
        _colorAccept = _colorActive;
        _colorSending = _colorActive;
        _colorInvoice = _colorActive;
      });
    }
  }

  @override
  void initState() {
    getStep(widget.orderID);
    getOrderDetail(widget.orderID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'ກວດສະຖານະ',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [_allStep(), _allOrderDetail()],
            ),
          ),
        ));
  }

  Widget _divider() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: 40,
          child: Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _stepOrder() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: _colorOrder,
                border: Border.all(color: Colors.green)),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.note_add,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'ສັ່ງເຄື່ອງ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _colorOrder),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _stepAccept() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: _colorAccept,
                border: Border.all(color: Colors.green)),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.approval,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'ຮັບເຄື່ອງ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _colorAccept),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _stepSending() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: _colorSending,
                border: Border.all(color: Colors.green)),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.send_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'ກຳລັງສົ່ງ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _colorSending),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _invoid() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: _colorInvoice,
                border: Border.all(color: Colors.green)),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.weekend,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'ໃບບິນ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _colorSending),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _allStep() {
    return Container(
      height: 130,
      child: Row(
        children: [
          _stepOrder(),
          _divider(),
          _stepAccept(),
          _divider(),
          _invoid(),
          _divider(),
          _stepSending()
        ],
      ),
    );
  }

  Widget _heaerOrder() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Color(0xff09b83e),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    child: Text(
                      'ລາຍການສັ່ງທັງໝົດ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xff09b83e)),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  child: Divider(
                thickness: 1.0,
                color: Color(0xff09b83e),
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _listDetail() {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: _listOrderDetail.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _detail(_listOrderDetail[index], index + 1),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _detail(Data inData, var index) {
    return Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Text(index.toString()),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          inData.iTEMNAME,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        format_currency.format(inData.pRICE).toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          inData.aMOUNT.toString(),
                          style: TextStyle(
                              color: Color(0xff09b83e),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        format_currency.format(inData.sUBTOTAL).toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _total() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Divider(
                thickness: 1.0,
                color: Color(0xff09b83e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'ລວມທັງໝົດ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: _orderDetail == null
                          ? Container(
                              child: Text(''),
                            )
                          : Text(format_currency.format(_orderDetail.total).toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'ລວມທັງໝົດທີ່ຕ້ອງຈ່າຍ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: _orderDetail == null
                        ? Container(
                            child: Text(''),
                          )
                        : Text(
                      format_currency.format(_orderDetail.total).toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _allOrderDetail() {
    return Card(
      child: Container(
        width: double.infinity,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_heaerOrder(), _listDetail(), _total()],
        ),
      ),
    );
  }
}
