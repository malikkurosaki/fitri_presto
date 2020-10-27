import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/model/menu_model.dart';

class SplashController extends GetxController {
  final pindah = false.obs;
}

class CompanyProfileController extends GetxController {
  final cp = {}.obs;
  getCompanyProfile()async{
    final str = GetStorage();
    final res = await new Dio().get("${str.read('host')}/api/getCompanyProfile");
    await GetStorage().write('company', res.data['data']);
    cp.value = res.data['data'];
  }
}
