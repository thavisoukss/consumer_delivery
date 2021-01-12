import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  var count = 0;
  bool count_staus = true;

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
                    title: Text("ນາໍ້ປັ່ນ",
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
                      child: Text('ອາຫານປາ', style: TextStyle(fontSize: 16)),
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
                      child: Text('ອາຫານປາ ', style: TextStyle(fontSize: 16)),
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
                      child: Text('150,000 USD'),
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
      child: Container(
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
      child: Container(
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
            onPressed: () {},
          )),
    );
  }
}
