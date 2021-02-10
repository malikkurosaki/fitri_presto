
// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:presto_qr/model/user_model_bak.dart';

// import 'lognya_controller.dart';

// class UserController extends GetxController {
//   static UserController get to => Get.find();

//   final userModel = Map().obs;
//   final user = User().obs;

//   init()async{
//     await getUserNya();
//   }

//   getUserNya()async{
//     try {
//       final auth = await GetStorage().read('auth');
//       final Map<dynamic, dynamic> apa = auth['user'];
//       user.value = User.fromJson(apa);
      
//     } catch (e) {
//       LognyaController.to.online(e.toString());
//     }
    
//   }
// }