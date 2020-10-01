import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListMenu with ChangeNotifier{

  List<dynamic> _lsData = [];
  List get lsData => _lsData;
  set lsData(List value) => _lsData = value;

  bool _lihatRincian = false;
  bool get lihatRincian => _lihatRincian;
  set lihatRincian(bool value) => _lihatRincian = value;

  List<dynamic> _lsGroup = [];
  List get lsGroup => _lsGroup;
  set lsGroup(List value) => _lsGroup = value;

  String _noteNya;
  String get noteNya => _noteNya;
  set noteNya(String value) => _noteNya = value;

  List<dynamic> _lsOderan;
  List get lsOderan => _lsOderan;
  set lsOderan(List value) => _lsOderan = value;

  update(){
    notifyListeners();
  }

  Future<List<dynamic>> getProduct()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    /* SharedPreferences prf = await SharedPreferences.getInstance();
    if(prf.getString('listMenu') == null){
      final res = await new Dio().get("https://prestoqr.barongpos.com/api/getMenu?product=&group=&subgroup=");
      prf.setString('listMenu', jsonEncode(res.data).toString());
    } */
    final res = await new Dio().get("https://"+prf.getString('host')+"/api/getMenu?product=&group=&subgroup=");
    return res.data;
  }

  Future<List<dynamic>> getGroupMenu()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    /* SharedPreferences prf = await SharedPreferences.getInstance();
    if(prf.getString('listGroup') == null){
      final res = await new Dio().get("https://prestoqr.barongpos.com/api/getGroup?group=&subgroup=");
      prf.setString('listGroup', jsonEncode(res.data).toString());
    } */
     final res = await new Dio().get("https://"+prf.getString('host')+"/api/getGroup?group=&subgroup=");
    return res.data;
  }

  Future<String> getMeja()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    return prf.getString('meja');
  }

}