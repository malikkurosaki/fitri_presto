import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/company_controller.dart';
import 'package:presto_qr/controller/login_controller.dart';
import 'package:presto_qr/controller/lognya_controller.dart';
import 'package:presto_qr/controller/myhome_controller.dart';
import 'package:presto_qr/controller/natya_controller.dart';
import 'package:presto_qr/controller/socket_controller.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/controller/user_controller.dart';
import 'package:presto_qr/views/change_log.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/lognya.dart';
import 'package:presto_qr/views/my_home.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/views/setting.dart';
import 'package:presto_qr/views/splash.dart';
import 'controller/list_menu_controller.dart';


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
            initialBinding: BindingPertama(),
            title: 'presto qr',
            enableLog: true,
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            unknownRoute: GetPage(name: '/404', page: () => Scaffold(body: Center(child: Text('404'),),)),
            getPages: [
              GetPage(name: '/', page: (){
                LognyaController.to.catat("instance home ");
                return MyHome();
              },),
              GetPage(name: '/login', page: () {
                  GetStorage().erase();
                  LognyaController.to.catat("instance login");
                  final at = GetStorage();
                  if(Get.parameters['meja'] != null && Get.parameters['host'] != null){
                    ListMenuNya.to.meja.value = Get.parameters['meja'].toString();
                    ListMenuNya.to.host.value = Get.parameters['host'].toString();
                    
                    at.write('meja', Get.parameters['meja'].toString());
                    at.write('host', Uri.decodeFull(Get.parameters['host'].toString()));
                    at.write('token', Get.parameters['token']??"");

                    LognyaController.to.log.add(Get.parameters['token']);
                    return RootView();
                  }else{
                    return at.hasData('user')?OpenTable():MyHome();
                  }
                },
              ),
              GetPage(name: '/masuk', page: () => Login()),
              GetPage(name: '/open-table', page: ()=> OpenTable(),
                binding: BindingsBuilder(
                  ()async{
                    Get.put<ListMenuNya>(ListMenuNya());
                  }
                )
              ),
              GetPage(name: '/setting', page: ()=>MySetting()),
              GetPage(name: '/log', page: () => LogNya()),
              GetPage(name: '/changelog', page: () => ChangeLog())
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
      Get.put<SplashController>(SplashController());
      Get.put<CompanyProfileController>(CompanyProfileController());
      Get.put<ListMenuNya>(ListMenuNya());
      Get.put<LoginController>(LoginController());
      Get.put<UserController>(UserController());
      Get.put<LognyaController>(LognyaController());
      Get.put<MyHomeController>(MyHomeController());
      Get.put<NatyaController>(NatyaController());
      Get.put<SocketController>(SocketController());
  }
  
}






