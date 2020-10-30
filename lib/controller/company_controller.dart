import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/model/company_model.dart';
class CompanyProfileController extends GetxController {
  static CompanyProfileController get to => Get.find();
  final cp = CompanyModel().obs;

  void init()async{
    await getCompanyProfile();
  }

  getCompanyProfile()async{
    final str = GetStorage();
    final res = await new Dio().get("${str.read('host')}/api/getCompanyProfile");
    await GetStorage().write('company', res.data['data']);
    cp.value = CompanyModel.fromJson(res.data);
    print(jsonEncode(res.data).toString());
    update();
  }
}