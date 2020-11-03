
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/model/user_model.dart';
import 'package:presto_qr/component/garis_putus.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final user = UserModel().obs;

  init()async{
    await getUserNya();
  }

  getUserNya()async{
    final data = GetStorage().read('auth');
    user.value = UserModel.fromJson(jsonDecode(data));
    //print(data.hijau());
    print(data);
  }
}