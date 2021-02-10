// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:presto_qr/controller/lognya_controller.dart';

// class LogNya extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     LognyaController.to.catat("instance log view");
    
//     return Container(
//       child: SafeArea(
//         child: Scaffold(
//           body: GetStorage().hasData('log')?Container(
//             padding: EdgeInsets.all(8),
//             child: ListView(
//               children: [
//                 Text("lihat log",
//                   style: TextStyle(
//                     fontSize: 24
//                   ),
//                 ),
//                 for(var i = 0; i < (GetStorage().read('log') as List).length;i++)
//                 Text((GetStorage().read('log') as List)[i].toString())
//               ],
//             ),
//           ):Text("kosong log"),
//         ),
//       ),
//     );
//   }
// }