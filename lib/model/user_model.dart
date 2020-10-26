class UserModel {
  String name;
  String email;
  String phone;
  String ipAddress;
  String deviceName;
  String updatedAt;
  String createdAt;
  int id;

  UserModel(
      {this.name,
      this.email,
      this.phone,
      this.ipAddress,
      this.deviceName,
      this.updatedAt,
      this.createdAt,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    ipAddress = json['ip_address'];
    deviceName = json['device_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['ip_address'] = this.ipAddress;
    data['device_name'] = this.deviceName;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
