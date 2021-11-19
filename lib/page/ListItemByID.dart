import 'package:consumer_delivery/model/Item.dart';
import 'package:consumer_delivery/page/Detail.dart';
import 'package:flutter/material.dart';
import 'package:consumer_delivery/apiCall/api.dart';

class ListItemByID extends StatefulWidget {
  final int itemTypes;

  const ListItemByID({Key key, this.itemTypes}) : super(key: key);

  @override
  _ListItemByIDState createState() => _ListItemByIDState();
}

class _ListItemByIDState extends State<ListItemByID> {
  int itemType;

  Item item;
  List<Data> _listitem = [];

  getItemByID(var idType) async {
    item = await apiCall.getItemByType(idType);
    setState(() {
      _listitem = item.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.itemTypes);
    getItemByID(widget.itemTypes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'ລາຍການສິນຄ້າ',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: _listItemWegit(),
    );
  }

  Widget _listItemWegit() {
    return _listitem.isEmpty
        ? Container()
        : Container(
            child: ListView.builder(
                itemCount: _listitem.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(
                                    id: _listitem[index].iD,
                                  )),
                        );
                      },
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
                                padding:
                                    const EdgeInsets.only(left: 40, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Text(
                                          _listitem[index].iTEMNAME,
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
                                          child: Text(_listitem[index].iTEMDESC,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
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
                                                  left: 5,
                                                  right: 5,
                                                  top: 2,
                                                  bottom: 2),
                                              child: Text(
                                                'discount 10 %',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                }),
          );
  }
}
