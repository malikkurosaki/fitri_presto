import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/views/detail_menu.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';

class BookMenu  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Future.microtask((){
      if(ListMenuNya.to.listMenu.isEmpty){
        ListMenuNya.to.getListMenu();
      }
    }); */
    return Container(
      height: MediaQuery.of(context).size.height/1.1,
      child: Scaffold(
        body: GetBuilder<ListMenuNya>(
          initState: (state) => ListMenuNya.to.getListMenu(),
          builder: (val) => 
          val.listMenu.isEmpty?Center(child: CircularProgressIndicator(),):
          Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Icon(Icons.arrow_drop_down),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      for(var i = 0; i< val.listMenu.length;i++)
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            InkWell(
                              child: Card(
                                child: CachedNetworkImage(
                                  imageUrl: val.listMenu[i].foto,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                  errorWidget: (context, url, error) => Center(child: Text("error"),),
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: (){
                                Get.bottomSheet(DetailMenu(listMenu: val.listMenu[i],i: i,tambah: false,));
                              },
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsetsDirectional.only(start: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(val.listMenu[i].namaPro).paddingOnly(bottom: 8),
                                    Text(val.listMenu[i].hargaPro).paddingOnly(bottom: 8),
                                    Text(val.listMenu[i].ket,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ).paddingOnly(bottom: 8),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          )
        ),
      ),
    );
  }
}

// class BookMenu extends StatelessWidget{
//   final List menu;

//   const BookMenu({Key key, this.menu}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
    
//     return Container(
//       height: MediaQuery.of(context).size.height/1.1,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             color: Colors.grey,
//             width: double.infinity,
//             child: Text("==="),
//           ),
//           Flexible(
//             child: ListView(
//               children: [
//                 Wrap(
//                   alignment: WrapAlignment.center,
//                   children: [
//                     Card(
//                       child: Container(
//                         alignment: Alignment.topLeft,
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('List Of Menu'),
//                             Container(
//                               padding: EdgeInsets.symmetric(vertical: 8),
//                               child: Text('this is only light list of menu , You can re-login or re-scan, to start a new order',
//                                 style: TextStyle(
//                                   color: Colors.grey
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     for(var a = 0; a < menu.length; a++)
//                     InkWell(
//                       onTap: (){
//                         showDialog(
//                           context: context,
//                           child: AlertDialog(
//                             content: DetailMenu(listMenu: menu[a],)
//                           )
//                         );
//                       },
//                       child: Card(
//                         child: Container(
//                           width: 150,
//                           height: 200,
//                           child: Stack(
//                             children: [
//                               CachedNetworkImage(
//                                 imageUrl: menu[a]['foto']??"",
//                                 width: 150,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
//                                 errorWidget: (context, url, error) => Center(child: Text('error'),),
//                               ),
//                               Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Container(
//                                   color: Colors.white,
//                                   width: double.infinity,
//                                   padding: EdgeInsets.all(8),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(menu[a]['nama_pro'],
//                                       overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Colors.cyan
//                                         ),
//                                       ),
//                                       Text(menu[a]['ket'],
//                                         overflow: TextOverflow.ellipsis,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.topRight,
//                                 child: Card(
//                                   color: Colors.deepOrange,
//                                   child: Container(
//                                     padding: EdgeInsets.all(4),
//                                     child: Text("Rp "+NumberFormat("#,###","IDR").format(int.parse(menu[a]['harga_pro'].toString())),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )
//                         )
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             )
//           )
//         ],
//       ),
//     );
//   }
  
// }