import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/model/login_model.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:validators/validators.dart';
import 'package:presto_qr/component/garis_putus.dart';

class LoginController extends GetxController {
  static  LoginController get to => Get.find();
  final ditekan = false.obs;
  static final listProperty = [
    {
      "nama": "Nama User",
      "icon": Icons.person_outline_sharp
    },
    {
      "nama": "Email",
      "icon": Icons.email
    },
    {
      "nama": "Phone Number",
      "icon": Icons.phone_android
    }
  ];
  
  final kunciState = GlobalKey<FormState>();
  final List<TextEditingController> lsController = List.generate(listProperty.length, (index) => TextEditingController());

  init()async{

  }

  cobaLogin()async{
    this.ditekan.value = true;
    if(LoginController.to.kunciState.currentState.validate()){
      if(!isEmail(LoginController.to.lsController[1].text)){
        Get.dialog(Center(child: Card(child: Text("insert right email format")),));
        return;
      }

      if(LoginController.to.lsController[2].text.toString().length < 9 || !isNumeric(LoginController.to.lsController[2].text.replaceAll("0", "1"))){
        Get.dialog(Center(child: Card(child: Text("wrong phone number"),),));
        return;
      }

      final loginPaket = LoginModel(
        name: LoginController.to.lsController[0].text.toString(),
        email: LoginController.to.lsController[1].text.toString(),
        phone: LoginController.to.lsController[2].text.toString()
      );

      Get.dialog(Center(child: CircularProgressIndicator(),));
      
      try {
        print("coba login nih");
        print("host: ${GetStorage().read('host')}/api/setUserTable/${GetStorage().read('meja')}".kuning());
        final coba = await Dio().post("${GetStorage().read('host')}/api/setUserTable/${GetStorage().read('meja')}",data: loginPaket);
        print(coba.data['status'].toString().ungu());
        if(coba.data['status']){
          await GetStorage().write('auth', jsonEncode(coba.data));
          print("menuju ke meja order");
          Get.offAll(OpenTable());
          //Get.offNamed('/open-table');
        }else{
          Get.back();
          Get.snackbar('alert', 'table already in used');
        }
        
      } catch (e) {
        Get.back();
        Get.snackbar('alert', e.toString());
      }
    }
  }
}