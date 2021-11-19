import 'package:consumer_delivery/model/getOrder.dart';
import 'package:consumer_delivery/page/Setp.dart';
import 'package:consumer_delivery/share/saveUser.dart';
import 'package:consumer_delivery/apiCall/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ListOrder extends StatefulWidget {
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  var format_currency = NumberFormat("#,##0.00","en_USD");
  Order _order;
  List<Data> _listOrder = [];
  int _shopID;

  _getSharUsr() async {
    String shopID = "shopID";
    getShopID(shareName: shopID).then((result) {
      setState(() {
        _shopID = result;
        print('usrname');
        print(_shopID);
      });
    });
  }

  Future _getOrder() async {
    await _getSharUsr();
    apiCall.getOrderByShopID(_shopID).then((value) {
      setState(() {
        _order = value;
        _listOrder = _order.data;
      });
    });
  }

  @override
  void initState() {
    _getOrder();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ລາຍການທີ່ໄດ້ສັ່ງ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: _listOrderWidget(),
      ),
    );
  }

  Widget _listOrderWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
          itemCount: _listOrder.length,
          itemBuilder: (context, index) {
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Setp(orderID: _listOrder[index].oRDERNO)),
                  );
                },
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, bottom: 10),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'ລະຫັດສັ່ງ :' + _listOrder[index].oRDERNO,
                                    style: TextStyle(
                                        color: Color(0xff09b83e),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'ສະຖານະ : ' + _listOrder[index].sTATUS,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'ລວມທັງໝົດ : ' +
                                        format_currency.format(_listOrder[index].tOTALAMOUNT).toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            'ວັນທີ' + _listOrder[index].oRDERDATE,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
