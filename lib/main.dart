import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/my_home.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/views/tunggu_pesanan.dart';

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