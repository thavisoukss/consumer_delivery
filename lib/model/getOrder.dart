class Order {
  String status;
  String message;
  List<Data> data;

  Order({this.status, this.message, this.data});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int iD;
  String oRDERNO;
  int sHOPID;
  String sHOPNAME;
  String tELNO;
  String oRDERDATE;
  String oRDERUSER;
  String dELIVERYDATE;
  int tOTALAMOUNT;
  String cCY;
  int iNVOIDNO;
  String sTATUS;
  int dISTRIBUTORID;
  String dISTRIBUTORNAME;
  int dELIVERYNO;

  Data(
      {this.iD,
      this.oRDERNO,
      this.sHOPID,
      this.sHOPNAME,
      this.tELNO,
      this.oRDERDATE,
      this.oRDERUSER,
      this.dELIVERYDATE,
      this.tOTALAMOUNT,
      this.cCY,
      this.iNVOIDNO,
      this.sTATUS,
      this.dISTRIBUTORID,
      this.dISTRIBUTORNAME,
      this.dELIVERYNO});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    oRDERNO = json['ORDER_NO'];
    sHOPID = json['SHOP_ID'];
    sHOPNAME = json['SHOP_NAME'];
    tELNO = json['TEL_NO'];
    oRDERDATE = json['ORDER_DATE'];
    oRDERUSER = json['ORDER_USER'];
    dELIVERYDATE = json['DELIVERY_DATE'];
    tOTALAMOUNT = json['TOTAL_AMOUNT'];
    cCY = json['CCY'];
    iNVOIDNO = json['INVOID_NO'];
    sTATUS = json['STATUS'];
    dISTRIBUTORID = json['DISTRIBUTOR_ID'];
    dISTRIBUTORNAME = json['DISTRIBUTOR_NAME'];
    dELIVERYNO = json['DELIVERY_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ORDER_NO'] = this.oRDERNO;
    data['SHOP_ID'] = this.sHOPID;
    data['SHOP_NAME'] = this.sHOPNAME;
    data['TEL_NO'] = this.tELNO;
    data['ORDER_DATE'] = this.oRDERDATE;
    data['ORDER_USER'] = this.oRDERUSER;
    data['DELIVERY_DATE'] = this.dELIVERYDATE;
    data['TOTAL_AMOUNT'] = this.tOTALAMOUNT;
    data['CCY'] = this.cCY;
    data['INVOID_NO'] = this.iNVOIDNO;
    data['STATUS'] = this.sTATUS;
    data['DISTRIBUTOR_ID'] = this.dISTRIBUTORID;
    data['DISTRIBUTOR_NAME'] = this.dISTRIBUTORNAME;
    data['DELIVERY_NO'] = this.dELIVERYNO;
    return data;
  }
}
