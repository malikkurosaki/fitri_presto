import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orderan with ChangeNotifier{
  List<dynamic> _lsData = [];
  List get lsData => _lsData;
  set lsData(List value) => _lsData = value;

  getListOrder()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    return jsonDecode(prf.getString('orderan'));
  }

  setListOrderan(List value)async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    prf.setString('orderan', jsonEncode(value).toString());
    _lsData = jsonDecode(prf.getString('orderan'));
    notifyListeners();
  }

  tambahOrderan(Map<String,dynamic> value) async{
    if(_lsData == null) _lsData = [];
    SharedPreferences prf = await SharedPreferences.getInstance();
    if(_lsData.map((e) => e['nama_pro']).contains(value['nama_pro'])){
      print('udah ada');
      return;
    }
    _lsData.add(value);
    prf.setString('orderan', jsonEncode(_lsData).toString());
    _lsData = jsonDecode(prf.getString('orderan'));
    notifyListeners();
  }

  bersihkanOrderan()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    prf.remove('orderan');
    _lsData = null;
    notifyListeners();
  }

  update()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    _lsData = jsonDecode(prf.getString('orderan'));
    notifyListeners();
  }

  lihat(){
    notifyListeners();
  }

}