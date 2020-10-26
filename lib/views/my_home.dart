import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/model/model_response_listbill.dart';
import 'package:presto_qr/views/book_menu.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';

class MyHome extends StatelessWidget {
  final box = GetStorage();

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body:
        box.hasData('auth')?OpenTable(): 
        box.hasData('pesanan')?MyHomeAdaPesanan():MyHomeGakAdaPesanan(),
      ),
    );
  }
}

class MyHomeAdaPesanan extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    print("iam in home");
    Future.microtask((){
      _theMenu.lihatPesanan();
    });

    return Container(
      child: Column(
        children: [
          Obx(()=>
          _theMenu.pesananNya.value.phone.isNull?Text("loading"):
            Flexible(
              child: ListView(
                children: [
                  for(var i = 0; i < _theMenu.pesananNya.value.detailBills.length ;i++)
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5,
                            child: CachedNetworkImage(
                              imageUrl: _theMenu.pesananNya.value.detailBills[i].foto??"",
                              placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                              errorWidget: (context, url, error) => Image.asset('assets/images/bahan.jpg',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(_theMenu.pesananNya.value.detailBills[i].qty.toString()+" X ",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0.enam()),
                                  shadows: [
                                    Shadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                      offset: Offset(0,5)
                                    )
                                  ]
                                ),
                              ),
                              Text(_theMenu.pesananNya.value.detailBills[i].namaPro,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(_theMenu.pesananNya.value.detailBills[i].hargaPro.toString().rupiah(),
                                style: TextStyle(
                                  color: Color(0.empat()),
                                  fontWeight: FontWeight.w900
                                ),
                              ),
                              Text(_theMenu.pesananNya.value.detailBills[i].note??"",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  backgroundColor: Colors.green,
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            )
          ),
          Card(
            color: Color(0.duaa()),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Please feel free to wait, dont worry we are working on a magic for your order, something special for a memorable time',
                      style: TextStyle(
                        color: Color(0.lima())
                      ),
                    )
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("I have received my order  "),
                            FlatButton(
                              textColor: Colors.white,
                              color: Color(0.enam()),
                              minWidth: double.infinity,
                              child: Text("YES"),
                              onPressed: (){
                                ListMenuNya.to.keluar();
                              },
                            ).marginAll(4)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("who knows if you want to order again",
                              overflow: TextOverflow.ellipsis,
                            ),
                            FlatButton(
                              textColor: Colors.white,
                              color: Color(0.enam()),
                              minWidth: double.infinity,
                              child: Text("SHOW ME"),
                              onPressed: (){
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context, 
                                  builder: (context) => BookMenu(),
                                );
                              },
                            ).marginAll(4)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyHomeGakAdaPesanan extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0.enam()),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "PrestQR Features, Support Social Distancing",
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white
                    ),
                  ),
                ),
                AspectRatio(aspectRatio: 12/1),
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    """ 
                      The PrestoQR feature strongly supports the current social distancing policies to reduce the spread of Covid-19. Passive experiences for isolated communities will change to become more active and social.  can use PrestoQr to do contactless. This latest feature will meet the needs of customers to be able to order menus without having to contact directly.
                    """,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0.lima())
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/images/qr_scanner1.png',
                      width: 400,
                    ),
                  ),
                ),
                GestureDetector(
                  onLongPress: ()async{
                    await _theMenu.kosongkanMeja(
                      "3",
                      "https://prestoqr.probussystem.com"
                    );
                    Get.offAllNamed('/login?meja=3&host=https://prestoqr.probussystem.com');
                  },
                  child: Text('powered by PROBUSSYSTEM',
                    style: TextStyle(
                      color: Color(0.satu())
                    ),
                    textAlign: TextAlign.center,
                  )
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MyHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         body: Center(
//           child: Text('ini myhome'),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:validators/validators.dart';
// import 'book_menu.dart';


// class MyHome extends StatefulWidget {
//   final meja,host;
//   const MyHome({Key key, this.meja, this.host}) : super(key: key);

//   @override
//   _MyHomeState createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   List _menu;
//   List _lsMenu;

//   @override
//   void initState() {
//     Future.microtask(()async{
//       final _prf = await SharedPreferences.getInstance();
//       if(_prf.getString('pesanan') != null ){
//         setState(() {
//           _menu = jsonDecode(_prf.getString('pesanan')).where((e)=>e['qty'] != 0).toList();
//           _lsMenu = jsonDecode(_prf.getString('pesanan'));
//         });
       
//       }else{
//         print('menu kosong');
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     print("iam in myhome");
    
//     return _menu != null ? LihatPesaanan(menu: _menu,lsMenu: _lsMenu,):
//     Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: ListView(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text(
//                       "PrestQR Features, Support Social Distancing",
//                       style: TextStyle(
//                         fontSize: 24
//                       ),
//                     ),
//                   ),
//                   AspectRatio(aspectRatio: 12/1),
//                   Container(
//                     padding: EdgeInsets.only(bottom: 16),
//                     child: Text(
//                       """ 
//                         The PrestoQR feature strongly supports the current social distancing policies to reduce the spread of Covid-19. Passive experiences for isolated communities will change to become more active and social.  can use PrestoQr to do contactless. This latest feature will meet the needs of customers to be able to order menus without having to contact directly.
//                       """,
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Image.asset('assets/images/qr_scanner1.png'),
//                     ),
//                   ),
//                   Text('powered by PROBUSSYSTEM')
//                 ],
//               ),
//             ],
//           ),
//         )
        
//       ),
//     );
//   }
// }
 


// class LihatPesaanan extends StatelessWidget {
//   final List menu;
//   final List lsMenu;

//   LihatPesaanan({Key key, this.menu, this.lsMenu}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Flexible(
//               child: ListView(
//                 children: [
//                   Text('List Of Your Order',
//                     style: TextStyle(
//                       fontSize: 42,
//                       color: Colors.grey
//                     ),
//                   ),
//                   for(var i = 0; i < menu.length;i++)
//                   Container(
//                     padding: EdgeInsets.all(8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Card(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                           elevation: 10,
//                           child: Container(
//                             width: 100,
//                             height: 100,
//                             child: CachedNetworkImage(
//                               imageUrl: menu[i]['foto'],
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child:  Container(
//                             padding: EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(menu[i]['nama_pro'],
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     color: Colors.grey
//                                   ),
//                                 ),
//                                 Chip(
//                                   label : Text(menu[i]['qty'].toString() + " x",
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                 ),
//                                 Text(menu[i]['note'].toString(),
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.grey
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               alignment: Alignment.center,
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 color: Colors.orange,
//                 textColor: Colors.white,
//                 onPressed: ()async{
//                   showDialog(context: context,
//                     child: AlertDialog(
//                       contentPadding: EdgeInsets.all(8),
//                       scrollable: true,
//                       content: Center(child: CircularProgressIndicator(),),
//                     )
//                   );
                  
//                   await Future.delayed(Duration(seconds: 1));
//                   Navigator.of(context,rootNavigator: true).pop();

//                   showModalBottomSheet(
//                     context: context, 
//                     isScrollControlled: true,
//                     isDismissible: true,
//                     builder: (context) => BookMenu(menu: lsMenu,),
//                   );
//                 }, 
//                 child: Text('LIST MENU')
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  

// }
