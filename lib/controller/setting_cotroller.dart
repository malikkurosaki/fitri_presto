import 'package:dio/dio.dart';
import 'package:presto_qr/controller/kunci.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController {
  Future<Map<String,dynamic>> getSetting()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    
    Map<String,dynamic> st = {};

    /* setting tanpa harus koneksi */
    st[Setting.DEVELOP.toString()] = true;
    st[Setting.ADAHOST.toString()] = false;
    /* setting membutuhkan koneksi */
    if(prf.getString('host') != null){
      st[Setting.ADAHOST.toString()] = true;
      st[Setting.HOST.toString()] = prf.getString('host');
      final meja = await new Dio().get('https://${st["host"]}/api/getCustomerTable');
      st[Setting.LS_MEJA.toString()] = meja.data['data'];
    }

    return st;
  }
}