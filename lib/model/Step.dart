class Step {
  String status;
  String message;
  List<Data> data;

  Step({this.status, this.message, this.data});

  Step.fromJson(Map<String, dynamic> json) {
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
  String rEFNAME;
  String rEFNO;
  String rEFDATE;
  String oRDERNO;

  Data({this.rEFNAME, this.rEFNO, this.rEFDATE, this.oRDERNO});

  Data.fromJson(Map<String, dynamic> json) {
    rEFNAME = json['REF_NAME'];
    rEFNO = json['REF_NO'];
    rEFDATE = json['REF_DATE'];
    oRDERNO = json['ORDER_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REF_NAME'] = this.rEFNAME;
    data['REF_NO'] = this.rEFNO;
    data['REF_DATE'] = this.rEFDATE;
    data['ORDER_NO'] = this.oRDERNO;
    return data;
  }
}
