class Paketan {
  String customerId;
  String name;
  String phone;
  String email;
  List<BillDetail> billDetail;

  Paketan(
      {this.customerId, this.name, this.phone, this.email, this.billDetail});

  Paketan.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    if (json['billDetail'] != null) {
      billDetail = new List<BillDetail>();
      json['billDetail'].forEach((v) {
        billDetail.add(new BillDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    if (this.billDetail != null) {
      data['billDetail'] = this.billDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillDetail {
  String productId;
  String productPrice;
  int qty;
  String note;

  BillDetail({this.productId, this.productPrice, this.qty, this.note});

  BillDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productPrice = json['product_price'];
    qty = json['qty'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_price'] = this.productPrice;
    data['qty'] = this.qty;
    data['note'] = this.note;
    return data;
  }
}