import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/component/garis_putus.dart';
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
            child: Image.asset('assets/images/logo_qr_presto.png')
          ),
        )
/*         Container(
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('presto',
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0.satu()),
                        fontStyle: FontStyle.normal
                      ),
                    ),
                    Text('QR',
                      style: TextStyle(
                        fontSize: 42,
                        color: Color(0.empat()),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.all(8),
                  child: Text('powered by Probus System',
                    style: TextStyle(
                      color: Color(0.enam())
                    ),
                  )
                ),
              )
            ],
          ),
        ) */,
      ),      
    );
  }
}
