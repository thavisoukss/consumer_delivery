class CalculateKm {
  List<Data> data;

  CalculateKm({this.data});

  CalculateKm.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int index;
  int disID;
  String disName;
  double km;
  String token;

  Data({this.index, this.disID, this.disName, this.km, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    disID = json['disID'];
    disName = json['dis_name'];
    km = json['km'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['disID'] = this.disID;
    data['dis_name'] = this.disName;
    data['km'] = this.km;
    data['token'] = this.token;
    return data;
  }
}
