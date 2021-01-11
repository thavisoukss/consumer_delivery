import 'package:flutter/material.dart';

class Order1 extends StatefulWidget {
  @override
  _Order1State createState() => _Order1State();
}

class _Order1State extends State<Order1> {
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
            _divider(),
            _detail(),
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
                      child: Text(
                        '36,350.00',
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
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _left()),
          Expanded(flex: 6, child: _center()),
          Expanded(flex: 1, child: _right())
        ],
      ),
    );
  }

  Widget _left() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'ໄມ້ຖູເຮືອນ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            child: Text(
              '12.500.00',
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget _center() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              '180,309.00',
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
              Container(
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
              Container(
                height: 30,
                width: 70,
                color: Colors.grey[200],
                child: Center(child: Text('20')),
              ),
              Container(
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
                    padding: const EdgeInsets.only(right: 10, top: 15),
                    child: Container(
                      child: Text(
                        '22,350.00',
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
                  padding: const EdgeInsets.only(right: 10, top: 15),
                  child: Container(
                    child: Text('22,350.00',
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
