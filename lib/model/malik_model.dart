class MalikModel {
  String nama;

  MalikModel({this.nama});

  MalikModel.fromJson(Map json) {
    nama = json['nama'];
  }

  Map toJson() {
    final Map data = new Map();
    data['nama'] = this.nama;
    return data;
  }
}
