class ResponseListBill {
  bool status;
  Listbill listbill;
  String note;

  ResponseListBill({this.status, this.listbill, this.note});

  ResponseListBill.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    listbill = json['listbill'] != null
        ? new Listbill.fromJson(json['listbill'])
        : null;
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.listbill != null) {
      data['listbill'] = this.listbill.toJson();
    }
    data['note'] = this.note;
    return data;
  }
}

class Listbill {
  int id;
  String date;
  int pax;
  String createdAt;
  String updatedAt;
  String name;
  String tableId;
  String customerId;
  String phone;
  String email;
  String total;
  String timeOrder;
  String kodeOut;
  int approvedStatus;
  String approvedTime;
  String approvedBy;
  String shift;
  List<DetailBills> detailBills;

  Listbill(
      {this.id,
      this.date,
      this.pax,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.tableId,
      this.customerId,
      this.phone,
      this.email,
      this.total,
      this.timeOrder,
      this.kodeOut,
      this.approvedStatus,
      this.approvedTime,
      this.approvedBy,
      this.shift,
      this.detailBills});

  Listbill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    pax = json['pax'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    tableId = json['table_id'];
    customerId = json['customer_id'];
    phone = json['phone'];
    email = json['email'];
    total = json['total'];
    timeOrder = json['time_order'];
    kodeOut = json['kode_out'];
    approvedStatus = json['approved_status'];
    approvedTime = json['approved_time'];
    approvedBy = json['approved_by'];
    shift = json['shift'];
    if (json['detail_bills'] != null) {
      detailBills = new List<DetailBills>();
      json['detail_bills'].forEach((v) {
        detailBills.add(new DetailBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['pax'] = this.pax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['table_id'] = this.tableId;
    data['customer_id'] = this.customerId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['total'] = this.total;
    data['time_order'] = this.timeOrder;
    data['kode_out'] = this.kodeOut;
    data['approved_status'] = this.approvedStatus;
    data['approved_time'] = this.approvedTime;
    data['approved_by'] = this.approvedBy;
    data['shift'] = this.shift;
    if (this.detailBills != null) {
      data['detail_bills'] = this.detailBills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailBills {
  int id;
  String listbillTemporaryId;
  int urut;
  String kodePro;
  String hargaPro;
  int qty;
  String note;
  String createdAt;
  String updatedAt;
  String namaPro;
  String foto;

  DetailBills(
      {this.id,
      this.listbillTemporaryId,
      this.urut,
      this.kodePro,
      this.hargaPro,
      this.qty,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.namaPro,
      this.foto});

  DetailBills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listbillTemporaryId = json['listbill_temporary_id'];
    urut = json['urut'];
    kodePro = json['kode_pro'];
    hargaPro = json['harga_pro'];
    qty = json['qty'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaPro = json['nama_pro'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['listbill_temporary_id'] = this.listbillTemporaryId;
    data['urut'] = this.urut;
    data['kode_pro'] = this.kodePro;
    data['harga_pro'] = this.hargaPro;
    data['qty'] = this.qty;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_pro'] = this.namaPro;
    data['foto'] = this.foto;
    return data;
  }
}


/* class ResponseListBill {
  int id;
  String date;
  int pax;
  String createdAt;
  String updatedAt;
  String name;
  String tableId;
  String customerId;
  String phone;
  String email;
  String total;
  String timeOrder;
  String kodeOut;
  int approvedStatus;
  String approvedTime;
  String approvedBy;
  String shift;
  List<DetailBills> detailBills;

  ResponseListBill(
      {this.id,
      this.date,
      this.pax,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.tableId,
      this.customerId,
      this.phone,
      this.email,
      this.total,
      this.timeOrder,
      this.kodeOut,
      this.approvedStatus,
      this.approvedTime,
      this.approvedBy,
      this.shift,
      this.detailBills});

  ResponseListBill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    pax = json['pax'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    tableId = json['table_id'];
    customerId = json['customer_id'];
    phone = json['phone'];
    email = json['email'];
    total = json['total'];
    timeOrder = json['time_order'];
    kodeOut = json['kode_out'];
    approvedStatus = json['approved_status'];
    approvedTime = json['approved_time'];
    approvedBy = json['approved_by'];
    shift = json['shift'];
    if (json['detail_bills'] != null) {
      detailBills = new List<DetailBills>();
      json['detail_bills'].forEach((v) {
        detailBills.add(new DetailBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['pax'] = this.pax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['table_id'] = this.tableId;
    data['customer_id'] = this.customerId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['total'] = this.total;
    data['time_order'] = this.timeOrder;
    data['kode_out'] = this.kodeOut;
    data['approved_status'] = this.approvedStatus;
    data['approved_time'] = this.approvedTime;
    data['approved_by'] = this.approvedBy;
    data['shift'] = this.shift;
    if (this.detailBills != null) {
      data['detail_bills'] = this.detailBills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailBills {
  int id;
  String listbillTemporaryId;
  int urut;
  String kodePro;
  String hargaPro;
  String namaPro;
  int qty;
  String note;
  String createdAt;
  String updatedAt;
  String foto;

  DetailBills(
      {this.id,
      this.listbillTemporaryId,
      this.urut,
      this.kodePro,
      this.hargaPro,
      this.qty,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.foto,
      this.namaPro});

  DetailBills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listbillTemporaryId = json['listbill_temporary_id'];
    urut = json['urut'];
    kodePro = json['kode_pro'];
    hargaPro = json['harga_pro'];
    qty = json['qty'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    foto = json['foto'];
    namaPro = json['nama_pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['listbill_temporary_id'] = this.listbillTemporaryId;
    data['urut'] = this.urut;
    data['kode_pro'] = this.kodePro;
    data['harga_pro'] = this.hargaPro;
    data['qty'] = this.qty;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['foto'] = this.foto;
    data['nama_pro'] = this.namaPro;
    return data;
  }
}
 */