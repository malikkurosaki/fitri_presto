import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:presto_qr/model/malik_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kunci.dart';

class MalikDynamic extends MalikDynamicModel with ChangeNotifier {
  
  update(){notifyListeners();}

  Future<MalikDynamicModel> getMenu()async{
    final SharedPreferences prf = await SharedPreferences.getInstance();
    this.nama = "apa ";
    try {
      this.nama = await new Dio().get("https://prestoqr.probussystem.com/api/getMenu?product=&group=&subgroup=");
    } catch (e) {
      print(e.toString());
    }
    this.lihat = notifyListeners();
    return this;
  }

}

class MalikDynamicModel {
  var nama,
  group = "";
  void lihat;
}

// class MalikDynamic extends ChangeNotifier {
//   update(){notifyListeners();}
  
//   Future<Map> getMenu()async{
//     final data = {};
//     SharedPreferences prf = await SharedPreferences.getInstance();
    
//     List menu;
//     List group;
//     Map user = jsonDecode(prf.getString(Malik.AUTH.toString()).toString());
//     String host = prf.getString(Malik.HOST.toString()).toString();

//     /*
//      cek jika menu pada local storege  kosong atau tidak
//      jika kosong akan minata langsung ke server
//     */
//     if(prf.getString(Malik.MENU.toString()) == null){
//       try {
//         final mn  = await new Dio().get('https://${prf.getString(Malik.HOST.toString())}/api/getMenu?product=&group=&subgroup=');
//         prf.setString(Malik.MENU.toString(), jsonEncode(mn.data).toString());
//       } catch (e) {
//         print('dari malik_dynamic '+ e );
//       }
//     }

//     /* 
//       cek jika group ada diw local storage 
//       jika tidak ada maka akan menganbil ke server
//      */
//     if(prf.getString(Malik.GROUP.toString()) == null){
//       try {
//         final gr = await new Dio().get('https://${prf.getString(Malik.HOST.toString())}/api/getGroup?group=&subgroup=');
//         prf.setString(Malik.GROUP.toString(), jsonEncode(gr.data).toString());
//       } catch (e) {
//         print('dari malik dynamic group : '+e);
//       }
//     }

//     /* 
//       mengambil data dari local storage
//      */
//     menu = jsonDecode(prf.getString(Malik.MENU.toString()).toString());
//     group = jsonDecode(prf.getString(Malik.GROUP.toString()).toString());

//     /* 
//       pengaturan terlihat atau tidak , untuk membuat fitter group 
//       yang ditampilkan pertama adalah group food
//     */
//     menu.forEach((e){
//        e[Malik.NOTE.toString()] = "";
//        e[Malik.BTN_ADD.toString()] = true;
//        e[Malik.BTN_QTY.toString()] = false;
//        e[Malik.MUNCUL_TOTAL.toString()] = false;
//        e[Malik.TOTAL_QTY.toString()] = 0;
//        e[Malik.TOTAL_BAYAR.toString()] = 0;
//        //e[Malik.TERLIHAT.toString()] = false;
//       if(e['groupp'].toString().trim() == "FOOD"){
//         e[Malik.TERLIHAT.toString()] = true;
//       }else{
//         e[Malik.TERLIHAT.toString()] = false;
//       }
//     });

//     /* 
//       memasukkan semua parameter sebelum diberangkatkan
//      */
//     data[Malik.MEJA.toString()] = prf.getString(Malik.MEJA.toString()).toString();
//     data[Malik.DIORDER.toString()] = jsonDecode(prf.getString(Malik.DIORDER.toString()).toString()).toString();

//     data[Malik.MENU.toString()] = menu??"";
//     data[Malik.GROUP.toString()] = group??"";
//     data[Malik.PADDING.toString()] = 0;
//     data[Malik.USER.toString()] = user??"";
//     data[Malik.HOST.toString()] = host??"";
//     print(data);
    
//     return data;
//   }

// }