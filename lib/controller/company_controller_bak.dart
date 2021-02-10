
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:presto_qr/model/company_model_bak.dart';

// import 'lognya_controller.dart';

// class CompanyProfileController extends GetxController {
//   static CompanyProfileController get to => Get.find();
//   final cp = CompanyModel().obs;

//   void init()async{
//     try {
//       if(!GetStorage().hasData('company')){
//         await getCompanyProfile();
//       }
      
//       GetStorage().listenKey('company', (e) => this.cp.value = e);
//       this.cp.value = CompanyModel.fromJson(jsonDecode(GetStorage().read('company')));
      
//     } catch (e) {
//       LognyaController.to.online(e.toString());
//     }
    
//   }

//   getCompanyProfile()async{
//     try {
//       final str = GetStorage();
//       final res = await new Dio().get("${str.read('host')}/api/getCompanyProfile");
//       await GetStorage().write('company', jsonEncode(res.data).toString());
//       // cp.value = CompanyModel.fromJson(res.data);
//       // print(jsonEncode(res.data).toString().hijau());
//       await GetStorage().write('gambar_terakhir', res.data['data']['image']);
//       //print("gambar terakhir ${this.cp.value.data.image}");
//       update();
      
//     } catch (e) {
//       LognyaController.to.online(e.toString());
//     }
//   }
// }