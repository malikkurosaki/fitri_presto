// import 'package:bali/bali.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:presto_qr/component/garis_putus.dart';
// import 'package:presto_qr/controller/list_menu_controller.dart';
// import 'package:presto_qr/controller/natya_controller.dart';

// class Natya extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {

//     Widget listOutlet(){
//       return AlertDialog(
//         scrollable: true,
//         content: Container(
//           child: Column(
//             children: [
//               for(var i = 0; i< 8; i++)
//               ListTile(
//                 leading: Text("Outlet ${i+1}"),
//                 onTap: () => NatyaController.to.pilihOutlet("Outlet ${i+1}"),
//               )
//             ],
//           ),
//         ),
//       );
//     }


//     return DraggableScrollableSheet(
//       initialChildSize: 0.9,
//       maxChildSize: 1,
//       minChildSize: 0.7,
//       builder: (_,__) => 
//         Card(
//         child: Obx(()=>
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("NATYA",
//                 style: TextStyle(
//                   fontSize: 24
//                 ),
//               ),
              
//               Flexible(
//                 child: ListView(
//                   controller: __,
//                   children: [
//                     Obx(() => 
//                       Container(
//                         padding: EdgeInsets.all(16),
//                         child: InkWell(
//                           child: Card(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Text(NatyaController.to.outlet.value.isEmpty?"SELECT OUTLET":NatyaController.to.outlet.value),
//                                   Icon(Icons.arrow_drop_down)
//                                 ],
//                               ),
//                             ),
//                           ),
//                           onTap: () => Get.dialog(listOutlet(),),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("to",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold
//                             ),
//                           ),
//                           for(var i = 0; i < NatyaController.lsData.length; i++)
//                           Card(
//                             color: Colors.blueGrey[100],
//                             child: TextField(
//                               controller: NatyaController.lsCon[i],
//                               decoration: InputDecoration(
//                                 isDense: true,
//                                 prefixIcon: Icon(NatyaController.lsData[i]['icon']),
//                                 contentPadding: EdgeInsets.all(4),
//                                 labelText: NatyaController.lsData[i]['name']
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     GarisPutus(),
//                     for(var i = 0; i < ListMenuNya.to.listMenu.length; i++)
//                     Visibility(
//                       visible: ListMenuNya.to.listMenu[i].qty != 0?true:false,
//                       child: Container(
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(8),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Card(
//                                     child: CachedNetworkImage(
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                       imageUrl: ListMenuNya.to.listMenu[i].foto??"",
//                                       placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
//                                       errorWidget: (context, url, error) => Image.asset('assets/images/logo_qr_presto.png'),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(left: 16),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(ListMenuNya.to.listMenu[i].namaPro),
//                                         Text(ListMenuNya.to.listMenu[i].hargaPro.rupiah(),
//                                           style: TextStyle(
//                                             color: Colors.orange
//                                           ),
//                                         ),
//                                         Text(ListMenuNya.to.listMenu[i].note??"",
//                                           style: TextStyle(
//                                             color: Colors.green,
//                                             backgroundColor: Colors.green[100]
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Card(
//                                               child: InkWell(
//                                                 child: Icon(
//                                                   Icons.remove_circle,
//                                                   color: Color(0.empat()),
//                                                 ),
//                                                 onTap: (){
//                                                   Get.bottomSheet(
//                                                     Card(
//                                                       child: Container(
//                                                         padding: EdgeInsets.all(16),
//                                                         child: Row(
//                                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                             children: [
//                                                               Text("Delete This Item ? "),
//                                                               FlatButton(
//                                                                 child: Text("OK",
//                                                                   style: TextStyle(
//                                                                     color: Color(0.enam())
//                                                                   ),
//                                                                 ),
//                                                                 onPressed: (){
//                                                                   ListMenuNya.to.hapusOrderan(i);
//                                                                   ListMenuNya.to.listMenu[i].lihatEditTambah = false;
//                                                                   Get.back();
//                                                                 },
//                                                               )
//                                                             ],
//                                                           ),
//                                                       ),
//                                                     ),
//                                                   );
                                                
//                                                 },
//                                               ),
//                                             ),
//                                             Card(
//                                               child: Row(
//                                                 children: [
//                                                   InkWell(
//                                                     child: Container(
//                                                       padding: EdgeInsets.all(8),
//                                                       child: Text("-"),
//                                                     ),
//                                                     onTap: (){
//                                                       if(ListMenuNya.to.listMenu.where((e) => e.qty != 0).map((e) => e.qty).reduce((a, b) => a+b) > 1){
//                                                         ListMenuNya.to.kurangiQty(i);
//                                                       }else{
//                                                         ListMenuNya.to.hapusOrderan(i);
//                                                       }
                                                      
//                                                     },
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.all(8),
//                                                     child: Text(ListMenuNya.to.listMenu[i].qty.toString())
//                                                   ),
//                                                   InkWell(
//                                                     child: Container(
//                                                       padding: EdgeInsets.all(8),
//                                                       child: Text("+"),
//                                                     ),
//                                                     onTap: (){
//                                                       ListMenuNya.to.tambahQty(i);
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             // titik titik dibawah
//                             GarisPutus()
//                           ],
//                         ),
//                       ),
//                     ),
//                     // disini : bagian prosses
                    
//                   ],
//                 ),
//               ),
//               Card(
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(8),
//                         color: Color(0.duaa()),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Estimation",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18
//                               ),
//                             ),
//                             Text("total qty : "+ ListMenuNya.to.totalQty.toString()),
//                             Text("total order : "+ ListMenuNya.to.totalOrder.toString()),
//                             Text("estimated pay : "+ ListMenuNya.to.totalValue.toString().rupiah())
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         child: FlatButton(
//                           textColor: Colors.white,
//                           color: Color(0.enam()),
//                           onPressed: (){
//                             ListMenuNya.to.prossesOrderan(context);
//                           }, 
//                           child: Text('PROCCESS')
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }