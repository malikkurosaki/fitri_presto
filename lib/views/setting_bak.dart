// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:presto_qr/controller/list_menu_controller.dart';
// import 'package:presto_qr/views/lognya.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';

// class MySetting extends StatelessWidget {
//   final _box = GetStorage();
//   final _theMenu = Get.find<ListMenuNya>();
//   @override
//   Widget build(BuildContext context) {
//     final _berubah = Berubah(context);
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Text('SETTING',
//               style: TextStyle(
//                 fontSize: 42,
//                 color: Colors.grey
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FlatButton(
//                   onPressed: ()async{
//                    ListMenuNya.to.keluar();
//                   }, 
//                   child: Text('keluar')
//                 ),
//                 FlatButton(
//                   onPressed: ()async{
//                     print(_box.read('host')+'/api/clearTable/'+_box.read('meja'));
//                     final hps = await new Dio().post(_box.read('host')+'/api/clearTable/'+_box.read('meja'));
//                     Get.showSnackbar(
//                       GetBar(
//                         title: 'info',
//                         message: hps.data.toString(),
//                         isDismissible: true,
//                       ),
//                     );
//                   }, 
//                   child: Text('hapus meja ')
//                 ),
//                 FlatButton(
//                   onPressed: () => Get.to(LogNya()), 
//                   child: Text("ke lognya")
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

// }

// class Berubah extends ValueNotifier{
//   Berubah(value) : super(value);
//   update(){
//     notifyListeners();
//   }
// }

// // class MySetting extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {

// //     // final _setting = Provider.of<Map<String,dynamic>>(context);
// //     // if(_setting == null) return Center(child: CircularProgressIndicator(),);
// //     final _menu = Provider.of<Map>(context);
// //     final _malik = Provider.of<MalikDynamic>(context);
// //     if(_menu == null) return Center(child: CircularProgressIndicator(),);

// //     return Scaffold(
// //       body: SafeArea(
// //         child: Pagination(
// //           pageBuilder: (currentListSize) => lsNya(_malik,_menu[Malik.MENU.toString()],currentListSize),
// //           itemBuilder: (index, item) => 
// //           Visibility(
// //             visible: item[Malik.TERLIHAT.toString()],
// //             child: ListTile(
// //               title: Text(item['nama_pro']),
              
// //             )
// //           )
// //         ),
// //         // child: ListView(
// //         //   children: [
// //         //     Text('setting'),
// //         //     Column(
// //         //       crossAxisAlignment: CrossAxisAlignment.start,
// //         //       children: [
                
// //         //         // FlatButton(
// //         //         //   onPressed: ()async{
// //         //         //     SharedPreferences prf = await SharedPreferences.getInstance();
// //         //         //     prf.remove('menu');
// //         //         //     Phoenix.rebirth(context);
// //         //         //   }, 
// //         //         //   child: Text('bersihkan cache')
// //         //         // ),

// //         //         // if(!_setting[Setting.ADAHOST.toString()] && _setting[Setting.DEVELOP.toString()])
// //         //         // Text('apa kabar')
// //         //       ],
// //         //     )
// //         //   ],
// //         // ),
// //       ),
// //     );
// //   }

// //   Future<List> lsNya(MalikDynamic _malik,ls,int ini)async{
// //     await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
// //     if(ini < ls.length){
// //       print('tambah');
// //       for(var i = ini ; i < ini + 10; i++){
// //         ls[i][Malik.TERLIHAT.toString()] = true;
// //       }
// //       //_malik.update();
// //     }
// //     return ls;
// //   }
  
// // }