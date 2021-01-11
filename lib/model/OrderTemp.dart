class OrderTemp {
  String status;
  String message;
  List<Data> data;
  int total;

  OrderTemp({this.status, this.message, this.data, this.total});

  OrderTemp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int iTEMID;
  String iTEMCODE;
  String iTEMNAME;
  int aMOUNT;
  int pRICE;
  String cCY;
  int sUBTOTAL;
  String dESCRITION;
  String oRDERNO;
  String iNVOIDNO;
  String uSERID;
  String sTATUS;

  Data(
      {this.iTEMID,
      this.iTEMCODE,
      this.iTEMNAME,
      this.aMOUNT,
      this.pRICE,
      this.cCY,
      this.sUBTOTAL,
      this.dESCRITION,
      this.oRDERNO,
      this.iNVOIDNO,
      this.uSERID,
      this.sTATUS});

  Data.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEM_ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    aMOUNT = json['AMOUNT'];
    pRICE = json['PRICE'];
    cCY = json['CCY'];
    sUBTOTAL = json['SUB_TOTAL'];
    dESCRITION = json['DESCRITION'];
    oRDERNO = json['ORDER_NO'];
    iNVOIDNO = json['INVOID_NO'];
    uSERID = json['USER_ID'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEM_ID'] = this.iTEMID;
    data['ITEM_CODE'] = this.iTEMCODE;
    data['ITEM_NAME'] = this.iTEMNAME;
    data['AMOUNT'] = this.aMOUNT;
    data['PRICE'] = this.pRICE;
    data['CCY'] = this.cCY;
    data['SUB_TOTAL'] = this.sUBTOTAL;
    data['DESCRITION'] = this.dESCRITION;
    data['ORDER_NO'] = this.oRDERNO;
    data['INVOID_NO'] = this.iNVOIDNO;
    data['USER_ID'] = this.uSERID;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}
