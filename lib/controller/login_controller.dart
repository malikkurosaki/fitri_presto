import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/controller/lognya_controller.dart';
import 'package:presto_qr/model/login_model.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:validators/validators.dart';

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
    LognyaController.to.online("coba untuk login");
    this.ditekan.value = true;
    if(LoginController.to.kunciState.currentState.validate()){
      if(!isEmail(LoginController.to.lsController[1].text)){
        this.ditekan.value = false;
        Get.snackbar('info', "insert right email format");
        LognyaController.to.online("insert right email format");
        return;
      }

      if(LoginController.to.lsController[2].text.toString().length < 9 || !isNumeric(LoginController.to.lsController[2].text.replaceAll("0", "1"))){
        this.ditekan.value = false;
        Get.snackbar('info', "wrong phone number");
        LognyaController.to.online("wrong phone number");
        return;
      }

      final loginPaket = LoginModel(
        name: LoginController.to.lsController[0].text.toString(),
        email: LoginController.to.lsController[1].text.toString(),
        phone: LoginController.to.lsController[2].text.toString(),
        token: GetStorage().read('token')??""
      );
      
      try {
        print("coba login nih");
        LognyaController.to.online("coba kirim data login");
        print("host: ${ListMenuNya.to.host}/api/setUserTable/${ListMenuNya.to.meja}".kuning());
       
        final coba = await Dio().post("${ListMenuNya.to.host}/api/setUserTable/${ListMenuNya.to.meja}",data: loginPaket);
        
        print(coba.data['status'].toString().ungu());
        this.ditekan.value = false;
        print(jsonEncode(coba.data).toString());
        
        if(coba.data['status']){
          await GetStorage().write('auth', coba.data);
          print("menuju ke meja order");
          Get.off(OpenTable());
          LognyaController.to.online("login berhasil");
        }else{
          LognyaController.to.online(coba.data['note']);
          Get.snackbar('alert', coba.data['note'],
            backgroundColor: Colors.white
          );
        }
        
      } catch (e) {
        this.ditekan.value = false;
        //Get.back();
        print(e);
        LognyaController.to.online(e);
        Get.snackbar('alert', e.toString());
      }
    }
    this.ditekan.value = false;
  }
}