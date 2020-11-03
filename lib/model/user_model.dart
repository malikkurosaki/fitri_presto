class UserModel {
  bool status;
  User user;
  String table;
  String note;
  String order;

  UserModel({this.status, this.user, this.table, this.note, this.order});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    table = json['table'];
    note = json['note'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['table'] = this.table;
    data['note'] = this.note;
    data['order'] = this.order;
    return data;
  }
}

class User {
  String name;
  String email;
  String phone;
  String createdAt;
  String updatedAt;
  String ipAddress;
  String deviceName;
  Map listbillTemporaryId;

  User(
      {this.name,
      this.email,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.ipAddress,
      this.deviceName,
      this.listbillTemporaryId});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ipAddress = json['ip_address'];
    deviceName = json['device_name'];
    listbillTemporaryId = json['listbill_temporary_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ip_address'] = this.ipAddress;
    data['device_name'] = this.deviceName;
    data['listbill_temporary_id'] = this.listbillTemporaryId;
    return data;
  }
}
