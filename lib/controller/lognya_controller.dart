import 'dart:html';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class LognyaController extends GetxController{
  static LognyaController get to => Get.find();
  final log = List().obs;
  
  init(){
    this.log.value = GetStorage().read('log');
    GetStorage().listenKey('log', (val) => this.log.value = val);
  }

}