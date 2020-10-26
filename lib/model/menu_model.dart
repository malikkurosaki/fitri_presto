import 'package:get/get_state_manager/get_state_manager.dart';

class MenuModel{
  String kodePro;
  String namaPro;
  String hargaPro;
  String groupp;
  String subgroupp;
  String foto;
  String ket;
  String cetakKe;
  String booth;
  String note;
  bool lihatTambah;
  bool lihatEditTambah;
  int qty;
  bool terlihat;

  MenuModel(
      {this.kodePro,
      this.namaPro,
      this.hargaPro,
      this.groupp,
      this.subgroupp,
      this.foto,
      this.ket,
      this.cetakKe,
      this.booth,
      this.note,
      this.lihatTambah,
      this.lihatEditTambah,
      this.qty,
      this.terlihat});

  MenuModel.fromJson(Map<String, dynamic> json) {
    kodePro = json['kode_pro'];
    namaPro = json['nama_pro'];
    hargaPro = json['harga_pro'];
    groupp = json['groupp'];
    subgroupp = json['subgroupp'];
    foto = json['foto'];
    ket = json['ket'];
    cetakKe = json['cetak_ke'];
    booth = json['booth'];
    note = json['note'];
    lihatTambah = json['lihatTambah'];
    lihatEditTambah = json['lihatEditTambah'];
    qty = json['qty'];
    terlihat = json['terlihat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_pro'] = this.kodePro;
    data['nama_pro'] = this.namaPro;
    data['harga_pro'] = this.hargaPro;
    data['groupp'] = this.groupp;
    data['subgroupp'] = this.subgroupp;
    data['foto'] = this.foto;
    data['ket'] = this.ket;
    data['cetak_ke'] = this.cetakKe;
    data['booth'] = this.booth;
    data['note'] = this.note;
    data['lihatTambah'] = this.lihatTambah;
    data['lihatEditTambah'] = this.lihatEditTambah;
    data['qty'] = this.qty;
    data['terlihat'] = this.terlihat;
    return data;
  }
}
