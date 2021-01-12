import 'package:consumer_delivery/apiCall/api.dart';
import 'package:consumer_delivery/model/ItemBrand.dart';
import 'package:flutter/material.dart';
class ListITemByID extends StatefulWidget {

  final int idTypes;
  ListITemByID({Key key, this.idTypes}) : super(key: key);

  @override
  _ListITemByIDState createState() => _ListITemByIDState();

}

class _ListITemByIDState extends State<ListITemByID> {

  int idType;

  ITemBrand _iTemBrand;
  List<Data> _listItemBrand;

  getItemByID(var idType) async {
    _iTemBrand = await apiCall.getItemBrandByID(idType);
    setState(() {
      _listItemBrand = _iTemBrand.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.idTypes);
    getItemByID(widget.idTypes);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ລາຍການສິນຄ້າ',style: TextStyle(color: Colors.white),)),
      ),
      body: Container(
        child: _listItemWegit(),
      ),
    );
  }


  Widget _listItemWegit(){
    return Container(
      child: ListView.builder(itemCount:_listItemBrand.length,itemBuilder: (context,index){
        return Card(
          child: GestureDetector(
            onTap: (){

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
                      padding: const EdgeInsets.only(left: 40, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(
                                _listItemBrand[index].bRANDNAME,
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
                                child: Text( _listItemBrand[index].bRANDDESC,
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
      }),
    );
  }
}
