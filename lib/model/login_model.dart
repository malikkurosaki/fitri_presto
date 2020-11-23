class LoginModel {
  String name;
  String phone;
  String email;
  String token;

  LoginModel({this.name, this.phone, this.email, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
