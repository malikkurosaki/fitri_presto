import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/open_table.dart';


class RootView extends StatelessWidget {
  final spl = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      spl.pindah.value = true;
      print("pindah lah");
    });
    return Obx(()=>spl.pindah.value?GetStorage().hasData('auth')?OpenTable():Login():Splash());
  }
}


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Image.asset('assets/images/logo_qr_presto.png',
              width: 100,
              height: 100,
            )
          ),
        ),
      ),      
    );
  }
}
