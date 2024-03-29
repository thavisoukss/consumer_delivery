import 'dart:convert';
import 'dart:io';
import 'package:consumer_delivery/model/Distributor.dart';
import 'package:consumer_delivery/model/Item.dart';
import 'package:consumer_delivery/model/ItemBrand.dart';
import 'package:consumer_delivery/model/ItemType.dart';
import 'package:consumer_delivery/model/Login.dart';
import 'package:consumer_delivery/model/OrderDetail.dart';
import 'package:consumer_delivery/model/OrderTemp.dart';
import 'package:consumer_delivery/model/Shop.dart';
import 'package:consumer_delivery/model/getOrder.dart';
import 'package:consumer_delivery/model/step.dart' as step;
import 'package:consumer_delivery/share/shareConstant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class apiCall {
  static UserLogin _userlogin = new UserLogin();
  static Item _item;
  static ITemBrand _iTemBrand;
  static OrderTemp _orderTemp;
  static Shop _shop;
  static Distributor _distributor = new Distributor();
  static ITemType _iTemType;
  static Order _order;
  static step.Step _step;
  static OrderDetail _orderDetail;

  static Future<UserLogin> login(var user, var password) async {
    var dio = new Dio();
    print('call api');
    var data = {"username": user, "password": password, "usertype": "ORDER"};
    print(data);

    try {
      Response response = await dio.post(
        ShareUrl.login,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      _userlogin = UserLogin.fromJson(response.data);
      print(_userlogin.toJson());

      return _userlogin;
    } on DioError catch (e) {
      print(e);
      return _userlogin;
    }
  }

  static Future<Item> getAllItem() async {
    var dio = new Dio();
    print('call api');

    try {
      Response response = await dio.post(
        ShareUrl.getItem,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(data),
      );
      _item = Item.fromJson(response.data);

      return _item;
    } on DioError catch (e) {
      print(e);
      return _item;
    }
  }

  static Future<Item> getItemByType(var id) async {
    var dio = new Dio();
    print('=== call api get Item by ItemTypeID ');
    var data = {"ITEM_TYPE_ID": id};
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.getItem,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _item = Item.fromJson(response.data);

      return _item;
    } on DioError catch (e) {
      print(e);
      return _item;
    }
  }

  static Future<Item> getItemByID(var id) async {
    var dio = new Dio();
    print('=== call api get Item by ID ');
    var data = {"ID": id};
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.getItem,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _item = Item.fromJson(response.data);

      return _item;
    } on DioError catch (e) {
      print(e);
      return _item;
    }
  }

  static Future<Item> getItemByItemCode(var id) async {
    var dio = new Dio();
    print('=== call api get Item by ID ');
    var data = {"ID": id};
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.getItem,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _item = Item.fromJson(response.data);

      return _item;
    } on DioError catch (e) {
      print(e);
      return _item;
    }
  }

  static Future<ITemBrand> getItemBrandByID(var itemID) async {
    var dio = new Dio();
    print('call api get item BrandByID');

    var data = {"ITEM_TYPE_ID": itemID};

    try {
      Response response = await dio.post(
        ShareUrl.getItemBrand,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      _iTemBrand = ITemBrand.fromJson(response.data);

      return _iTemBrand;
    } on DioError catch (e) {
      print(e);
      return _iTemBrand;
    }
  }

  static Future<ITemType> getAllItemType() async {
    var dio = new Dio();
    print('call api');

    try {
      Response response = await dio.post(
        ShareUrl.getItemType,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(data),
      );
      _iTemType = ITemType.fromJson(response.data);

      return _iTemType;
    } on DioError catch (e) {
      print(e);
      return _iTemType;
    }
  }

  static Future<Distributor> getAllDistributor() async {
    var dio = new Dio();
    print('call api');

    try {
      Response response = await dio.post(
        ShareUrl.getDistributor,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(data),
      );
      _distributor = Distributor.fromJson(response.data);

      return _distributor;
    } on DioError catch (e) {
      print(e);
      return _distributor;
    }
  }

  static Future<OrderTemp> getOrderTemp({String username}) async {
    var dio = new Dio();
    print('call api==== order item');

    var postData = {"USER_ID": username};

    try {
      Response response = await dio.post(
        ShareUrl.getOrderTemp,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      print(response.data.toString());
      _orderTemp = OrderTemp.fromJson(response.data);

      return _orderTemp;
    } on DioError catch (e) {
      print(e);
      return _orderTemp;
    }
  }

  static Future<String> DeleteOrderTemp({var order_no, item}) async {
    var dio = new Dio();
    print('call api==== order item');

    var postData = {"ORDER_NO": order_no, "ITEM_ID": item};

    var success = "success";
    var fail = "fail";

    print("post data");

    print(postData.toString());

    try {
      Response response = await dio.post(
        ShareUrl.deleteOrderTemp,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      var res = response.data;
      print(res);
      return success;
    } on DioError catch (e) {
      print(e);
      return fail;
    }
  }

  static Future<String> orderTemp({
    int item_id,
    String item_barcode,
    item_name,
    order_no,
    ccy,
    user_name,
    int unit,
    int price,
    int prices,
  }) async {
    var dio = new Dio();
    var resut;
    var res;
    var error = 'unsuccess';
    print('call api');

    var postData = {
      "DETAILS": [
        [
          item_id,
          item_barcode,
          item_name,
          unit,
          price,
          ccy,
          prices,
          item_name,
          order_no,
          user_name,
          "NEW"
        ]
      ]
    };

    print(postData.toString());
    try {
      Response response = await dio.post(
        ShareUrl.orderTemp,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      resut = response.data;
      res = resut['status'];
      print("=====");
      print(res);
      return res;
    } on DioError catch (e) {
      print(e);
      return error;
    }
  }

  static Future<Shop> getAllShop() async {
    var dio = new Dio();
    print('call api==== get AllShop');

    try {
      Response response = await dio.post(
        ShareUrl.getAllShop,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(postData),
      );

      print(response.data.toString());
      _shop = Shop.fromJson(response.data);

      return _shop;
    } on DioError catch (e) {
      print(e);
      return _shop;
    }
  }

  static Future<Shop> getShopByID({var shopID}) async {
    var dio = new Dio();
    print('call api==== get AllShop');

    var postData = {"ID": shopID};

    try {
      Response response = await dio.post(
        ShareUrl.getAllShop,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      _shop = Shop.fromJson(response.data);

      return _shop;
    } on DioError catch (e) {
      print(e);
      return _shop;
    }
  }

  static Future<Null> sendNoti({var token, body, title}) async {
    var dio = new Dio();
    var resut;
    var res;
    var error = 'unsuccess';
    print('call api');

    var postData = {"to": token, "bodys": body, "title": title};

    print(postData.toString());
    try {
      Response response = await dio.post(
        ShareUrl.noti,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      resut = response.data;
      print(resut);
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<Order> getOrderByShopID(var shopID) async {
    var dio = new Dio();
    print('=== call api getOrderByShopID');
    var data = {"SHOP_ID": shopID};
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.getOrder,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _order = Order.fromJson(response.data);
      print(_order.toJson());

      return _order;
    } on DioError catch (e) {
      print(e);
      return _order;
    }
  }

  static Future<step.Step> getStep(var orderNo) async {
    var dio = new Dio();
    print('=== call api getStep');
    var data = {"ORDER_NO": orderNo};
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.step,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _step = step.Step.fromJson(response.data);

      return _step;
    } on DioError catch (e) {
      print(e);
      return _step;
    }
  }

  static Future<OrderDetail> getOrderDetail(var orderNo) async {
    var dio = new Dio();
    print('=== call api getOrderDetail');
    var data = {"ORDER_NO": orderNo};
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.getOrderDetail,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _orderDetail = OrderDetail.fromJson(response.data);

      return _orderDetail;
    } on DioError catch (e) {
      print(e);
      return _orderDetail;
    }
  }
}
