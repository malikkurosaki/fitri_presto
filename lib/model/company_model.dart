class CompanyModel {
  bool status;
  Data data;

  CompanyModel({this.status, this.data});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String office;
  String name;
  String address;
  String address1;
  String phone;
  String email;
  String urlBackend;
  String urlFrontend;
  String logo;
  String image;

  Data(
      {this.office,
      this.name,
      this.address,
      this.address1,
      this.phone,
      this.email,
      this.urlBackend,
      this.urlFrontend,
      this.logo,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    office = json['office'];
    name = json['name'];
    address = json['address'];
    address1 = json['address1'];
    phone = json['phone'];
    email = json['email'];
    urlBackend = json['urlBackend'];
    urlFrontend = json['urlFrontend'];
    logo = json['logo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['office'] = this.office;
    data['name'] = this.name;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['urlBackend'] = this.urlBackend;
    data['urlFrontend'] = this.urlFrontend;
    data['logo'] = this.logo;
    data['image'] = this.image;
    return data;
  }
}
