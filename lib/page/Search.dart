import 'package:consumer_delivery/model/Item.dart';
import 'package:consumer_delivery/page/Detail.dart';
import 'package:flutter/material.dart';
import 'package:consumer_delivery/apiCall/api.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Item _item;
  List<Data> _listItem = [];
  List<Data> _filtter = [];

  getAllItem() async {
    _item = await apiCall.getAllItem();
    setState(() {
      _listItem = _item.data;
      _filtter = _listItem;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'ຄົ້ນຫາສີນຄ້າ',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff09b83e)),
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: 'ຄົ້ນຫາສິນຄ້າ'),
                  onChanged: (string) {
                    setState(() {
                      _filtter = _listItem
                          .where((u) => (u.iTEMNAME
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                          .toList();
                    });
                  },
                ),
              ),
              Container(
                height: 700,
                child: _type(),
              )
            ],
          ),
        ));
  }

  Widget _type() {
    return Container(
      child: ListView.builder(
        itemCount: _filtter.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(
                          id: _listItem[index].iD,
                        )),
              );
            },
            child: Card(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://images.deliveryhero.io/image/fd-la/LH/z1pf-listing.jpg',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  _filtter[index].iTEMNAME,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_filtter[index].iTEMDESC,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 2, bottom: 2),
                                      child: Text(
                                        'discount 10 %',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xff09b83e),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.navigate_next,
                            color: Color(0xff09b83e),
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
