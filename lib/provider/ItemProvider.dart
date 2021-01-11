import 'package:consumer_delivery/model/Item.dart';
import 'package:flutter/cupertino.dart';

class AddItemProvider extends ChangeNotifier {
  List<Data> listItem = List<Data>();

  addItem(Data item) {
    Data items = item;
    this.listItem.add(items);
    notifyListeners();
  }
}
