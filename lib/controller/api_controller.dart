
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/lognya_controller.dart';
import 'package:presto_qr/controller/user_controller.dart';
import 'package:presto_qr/model/log_model.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/model/paket_orderan_model.dart';

class ApiController {
  
  static Future<Response> kirimPaket(Map paketOrderan)async{
    try {
      final meja = GetStorage().read('meja');
      final host = GetStorage().read('host');
      print("$host/api/saveOrder/$meja".kuning());
      final res = await new Dio().post("$host/api/saveOrder/"+meja,data: paketOrderan);
      return res;
    } catch (e) {
      LognyaController.to.online(e.toString());
    }
    return null;
  }

  static hapusMeja()async{
    try {
      print("${GetStorage().read('host')}/api/clearTable/${GetStorage().read('meja')}".kuning());
      final res = await new Dio().post("${GetStorage().read('host')}/api/clearTable/${GetStorage().read('meja')}");
      return res.data['status'];
      
    } catch (e) {
      LognyaController.to.online(e.toString());
    }

    return null;
  }

  static hapusMeja2(String host, String meja)async{
    try {
      print("$host/api/clearTable/$meja".kuning());
      final res = await new Dio().post("$host/api/clearTable/$meja");
      print(res.data['status']);
      return res.data['status'];
      
    } catch (e) {
      LognyaController.to.online(e.toString());
    }
    return null;
  }

  static getListMenu()async{
    try {
      final Response res = await Dio().get("${GetStorage().read('host')}/api/getMenu?product=&group=&subgroup=");
      //print(res.data);
      return (res.data as List).map((e) => MenuModel.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static developer()async{
    try {
      Response res = await new Dio().get("https://malikkurosaki.github.io/cdnjs/setting/developer_prestoqr.json");
      return res.data['edit'];
      
    } catch (e) {
      LognyaController.to.online(e.toString());
    }

    return null;
  }

  static tambahLog(String text) async {
    Response res;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      WebBrowserInfo info = await deviceInfo.webBrowserInfo;
      LogModel log = LogModel(
        user: UserController.to.user.value.name??info.product,
        log: text,
        device_id: info.vendor
      );
      
      print("coba kirim ${log.toJson()}");
      res = await new Dio().post('http://188.166.218.138:8080/simpan-log',data: log.toJson());
    } catch (e) {
      print(e.toString());
      res.data = "note log error";
    }
    return res.data;
  }

  
}



