import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static  LoginController get to => Get.find();
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
}