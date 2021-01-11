import 'package:flutter/material.dart';

class Setp extends StatefulWidget {
  @override
  _SetpState createState() => _SetpState();
}

class _SetpState extends State<Setp> {
  Color _colorActive = Color(0xff09b83e);
  Color _colorInActive = Colors.grey;
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
                color: _colorActive,
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                color: _colorInActive,
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                color: _colorInActive,
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _stepSuccess() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: _colorInActive,
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
                'ສຳເລັດ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
          _stepSending(),
          _divider(),
          _stepSuccess()
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
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _detail(),
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

  Widget _detail() {
    return Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Text('1'),
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
                          'ໄມ້ຖູເຮືອນ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '13,000.00',
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
                          '10',
                          style: TextStyle(
                              color: Color(0xff09b83e),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '1,300,000.00',
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
                      child: Text('1,800,000.00',
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
                    child: Text(
                      '1,800,000.00',
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
