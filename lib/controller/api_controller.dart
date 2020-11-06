
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/model/paket_orderan_model.dart';

class ApiController {
  
  static Future<Response> kirimPaket(PaketOrderan paketOrderan)async{
    final meja = GetStorage().read('meja');
    final host = GetStorage().read('host');
    print("$host/api/saveOrder/$meja".kuning());
    final res = await new Dio().post("$host/api/saveOrder/"+meja,data: paketOrderan);
    return res;
  }

  static hapusMeja()async{
    print("${GetStorage().read('host')}/api/clearTable/${GetStorage().read('meja')}".kuning());
    final res = await new Dio().post("${GetStorage().read('host')}/api/clearTable/${GetStorage().read('meja')}");
    return res.data['status'];
  }

  static hapusMeja2(String host, String meja)async{
    print("$host/api/clearTable/$meja".kuning());
    final res = await new Dio().post("$host/api/clearTable/$meja");
    print(res.data['status']);
    return res.data['status'];
  }

  static getListMenu()async{
    final Response res = await Dio().get("${GetStorage().read('host')}/api/getMenu?product=&group=&subgroup=");
    return (res.data as List).map((e) => MenuModel.fromJson(e)).toList();
  }

  static developer()async{
    Response res = await new Dio().get("https://malikkurosaki.github.io/cdnjs/setting/developer_prestoqr.json");
    return res.data['edit'];
  }

  
}



