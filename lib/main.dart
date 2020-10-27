
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/my_home.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/views/setting.dart';
import 'package:presto_qr/views/splash.dart';

import 'controller/list_menu_controller.dart';
main() async{
  await GetStorage.init();
  Get.put<SplashController>(SplashController());
  Get.put<CompanyProfileController>(CompanyProfileController());
  Get.put<ListMenuNya>(ListMenuNya());

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
            title: 'presto qr',
            enableLog: true,
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            unknownRoute: GetPage(name: '/404', page: () => Scaffold(body: Center(child: Text('404'),),)),
            getPages: [
              GetPage(name: '/', page: ()=>MyHome()),
              GetPage(name: '/login', page: (){
                  final at = GetStorage();
                  if(Get.parameters['meja'] != null && Get.parameters['host'] != null){
                    at.write('meja', Get.parameters['meja'].toString());
                    at.write('host', Get.parameters['host'].toString());
                    return RootView();
                  }else{
                    return at.hasData('user')?OpenTable():MyHome();
                  }
                },
                binding: BindingsBuilder(
                  ()async{
                    Get.put(() => CompanyProfileController());
                    
                    // final str = GetStorage();
                    // if(Get.parameters['meja'] != null && Get.parameters['host'] != null){
                    //   await str.write('meja', Get.parameters['meja'].toString());
                    //   await str.write('host', Get.parameters['host'].toString());
                      
                    //   if(!str.hasData('company')){
                    //     final res = await new Dio().get("${str.read('host')}/api/getCompanyProfile");
                    //     print(res.data);
                    //   }
                    // }
                    
                  }
                )
              ),
              GetPage(name: '/masuk', page: () => Login()),
              GetPage(name: '/open-table', page: ()=> OpenTable(),
                binding: BindingsBuilder(
                  ()async{
                    Get.put<ListMenuNya>(ListMenuNya());
                  }
                )
              ),
              GetPage(name: '/setting', page: ()=>MySetting())
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
      Get.put(SplashController());
      Get.put(CompanyProfileController());
  }
  
}


// class Halaman1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         body: Center(
//           child: Text(Get.parameters['nama']??"nama"),
//         ),
//       ),
//     );
//   }
// }

// class Coba extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         body: Text(Get.parameters['nama']?.toString()??"kosong")
//       ),
//     );
//   }
// }





