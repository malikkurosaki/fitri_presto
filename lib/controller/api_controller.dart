import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/model/paket_orderan_model.dart';

class ApiController {
  
  static kirimPaket(PaketOrderan paketOrderan)async{
    final box = GetStorage();
    final meja = box.read('meja');
    final host = box.read('host');
    final res = await new Dio().post("$host/api/saveOrder/"+meja,data: paketOrderan);
    hapusMeja(meja);
    box.erase();
    await box.write('host', host);
    print(host);
    await box.write('pesanan', res.data['listbill']);
    return res.data['status'];
  }

  static hapusMeja(String meja)async{
    final box = GetStorage();
    final res = await new Dio().post("${box.read('host')}/api/clearTable/"+meja);
    return res.data['status'];
  }

  
}



