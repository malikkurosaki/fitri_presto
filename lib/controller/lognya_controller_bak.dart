
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:presto_qr/controller/api_controller.dart';
// class LognyaController extends GetxController{
//   static LognyaController get to => Get.find();
//   final log = List().obs;
  
//   init(){
//     this.log.value = GetStorage().read('log');
//     GetStorage().listenKey('log', (val) => this.log.value = val);
//   }

//   catat(String note) async {
//     final tanggal = DateFormat.jm().format(DateTime.now());
//     if(GetStorage().hasData('log')){
//       List isi = GetStorage().read('log') as List;
//       isi.add("$tanggal : $note");
//       await GetStorage().write('log', isi);
//     }else{
//       await GetStorage().write('log', ["$tanggal : $note"]);
//     }
//     //print("catat log");
//   }

//   online(String text){
//     ApiController.tambahLog(text);
//   }

// }