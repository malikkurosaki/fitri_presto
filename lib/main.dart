import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/company_controller_bak.dart';
import 'package:presto_qr/controller/login_controller_bak.dart';
import 'package:presto_qr/controller/lognya_controller_bak.dart';
import 'package:presto_qr/controller/myhome_controller_bak.dart';
import 'package:presto_qr/controller/natya_controller_bak.dart';
import 'package:presto_qr/controller/socket_controller_bak.dart';
import 'package:presto_qr/controller/splash_controller_bak.dart';
import 'package:presto_qr/controller/user_controller_bak.dart';
import 'package:presto_qr/views/change_log_bak.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/lognya_bak.dart';
import 'package:presto_qr/views/my_home_bak.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/views/setting_bak.dart';
import 'package:presto_qr/views/splash_bak.dart';
import 'package:presto_qr/views/tunggu_pesanan.dart';
import 'controller/list_menu_controller_bak.dart';

main() async{
  await GetStorage.init();
  runApp(
    Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: Card(
          margin: EdgeInsets.all(0),
          shadowColor: Colors.grey,
          child: GetMaterialApp(
            key: UniqueKey(),
            initialBinding: BindingPertama(),
            title: 'presto qr',
            enableLog: true,
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            unknownRoute: GetPage(name: '/404', page: () => Scaffold(body: Center(child: Text('404'),),)),
            getPages: [
              GetPage(name: '/', page: () => MyHome()),
              // GetStorage().hasData("auth")?OpenTable():Login()
              GetPage(name: '/login', page: (){
                //Get.reset(clearRouteBindings: true);
                return GetStorage().hasData("auth")?OpenTable(): Login();
              }), 
              GetPage(name: '/masuk', page: () => Login()),
              GetPage(name: '/open-table', page: ()=> OpenTable()),
              // GetPage(name: '/setting', page: ()=>MySetting()),
              // GetPage(name: '/log', page: () => LogNya()),
              // GetPage(name: '/changelog', page: () => ChangeLog()),
              GetPage(name: "/tunggu-pesanan", page: () => TungguPesanan())
            ],
          ),
        ),
      ),
    )
  );
}

class BindingPertama implements Bindings {
  @override
  void dependencies()async{
  
    Get.put(MyCtrl());
  }
  
}

class MyCtrl extends GetxController{}