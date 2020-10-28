import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/controller/open_order_controller.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/views/detail_menu.dart';
import 'package:presto_qr/views/detail_orderan.dart';
import 'package:presto_qr/views/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';

// extension on Text{
//   besar(){
//     return Text(this.data,
//       style: TextStyle(
//         color: Colors.red
//       )
//     );
//   }
// }


// extension on Text{
//   rupiah(){
//     return Text("Rp "+NumberFormat("#,###","IDR").format(this.data));
//   }
// }

class OpenTable extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {

    if(_theMenu.listMenu.isEmpty){
      _theMenu.getListMenu();
    }

    return Container(
      child: Scaffold(
        // disini : bottom sheet
        drawer: Drawer(),
        bottomSheet: DetailBawah(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // disini : appbar
              Obx(()=>
                /* Container(
                  color: Color(0.enam()),
                  child: AnimatedCrossFade(
                    firstChild: Column(
                      children: [
                        AppBarAtas(),
                        PanelBar()
                      ],
                    ), 
                    secondChild: PanelBar(), 
                    crossFadeState: _theMenu.totalanBawah.value?CrossFadeState.showSecond:CrossFadeState.showFirst, 
                    duration: Duration(milliseconds: 500),
                    alignment: Alignment.centerLeft,
                  ),
                ) */
                Container(
                  color: Color(0.enam()),
                  child: Visibility(
                    visible: !_theMenu.totalanBawah.value,
                    child: Column(
                      children: [
                        AppBarAtas(),
                        
                      ],
                    ),
                  ),
                )
              ),
              PanelBar(),
              Flexible(
                child: ListMenuView()
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailBawah extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(()=> 
        !_theMenu.totalanBawah.value & _theMenu.adaOrderan.value?
        Card(
          color: Color(0.enam()),
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Estimation Order",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          GarisPutus(warna: Colors.white,),
                          Text("total order : "+ _theMenu.totalValue.value.toString().rupiah()).putih(),
                          Text("total qty : "+ _theMenu.totalQty.value.toString()).putih()
                        ],
                      )
                    ),
                  ),
                  Container(
                    // disini : lihat totalan
                    // disini : icon keranjang
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart,
                        color: Colors.white,
                      ), 
                      onPressed: (){
                        _theMenu.lihatListOrderannya();
                        
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context, 
                          builder: (context) => 
                          DetailOrderan()
                        );
                      }
                    ),
                  )
                ],
              )
          ),
        ):SizedBox.shrink()
      ),
    );
  }
}


//  cari list
class CariListMenu extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (val){
                _theMenu.cariListMenu();
              },
              controller: _theMenu.cariController.value,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                filled: true,
                fillColor: Colors.white
              ),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.search,size: 24,
              color: Colors.white
            ).paddingSymmetric(horizontal: 8),
            onTap: () => _theMenu.cariListMenu(),
          )
        ],
      )
    ).marginAll(8);
  }
}

// appa bar atas
class AppBarAtas extends StatelessWidget {
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    
    return 
   !GetStorage().hasData('company')?Text("loading ..."):
    Stack(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(GetStorage().read('company')['name']??"load ...",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                  GestureDetector(
                    child: Text("table "+ _box.read('meja'),
                      style: TextStyle(
                        color: Color(0.empat()),
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onLongPress: (){
                      Get.toNamed('/setting');
                    },
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 25,
                      child: Icon(Icons.account_circle,
                        size: 50,
                        color: Color(0.enam()),
                      ),
                    ),
                    onTap: (){
                      showModalBottomSheet(
                        context: context, 
                        isScrollControlled: true,
                        builder: (context) => UserProfile(),
                      );
                    },
                  ),
                  Text(_box.read('auth')['name'],
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// panek bar
class PanelBar extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      Container(
        color: Color(0.enam()),
        child: Column(
          children: [
            CariListMenu(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i = 0; i < _theMenu.subMenu.length;i++)
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        for(var a = 0; a < _theMenu.subMenu.length; a++){
                          if(_theMenu.subMenu[a]['nama'] == _theMenu.subMenu[i]['nama']){
                            _theMenu.subMenu[a]['dipilih'] = true;
                          }else{
                            _theMenu.subMenu[a]['dipilih'] = false;
                          }
                        }

                        for(var y = 0; y < _theMenu.listMenu.length;y++){
                          if(_theMenu.listMenu[y].groupp == _theMenu.subMenu[i]['nama']){
                            _theMenu.listMenu[y].terlihat = true;
                          }else{
                            _theMenu.listMenu[y].terlihat = false;
                          }
                        }
                        _theMenu.listMenu.update((value) { });
                        _theMenu.subMenu.update((value) {print('pilih sub menu');});
                      }, 
                      child: Container(
                        color: _theMenu.subMenu[i]['dipilih']?Colors.orange:Colors.green[200],
                        width: 100,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 3),
                          padding: EdgeInsets.all(8),
                          color: Color(0.enam()),
                          child: Text(_theMenu.subMenu[i]['nama'],
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      )
    );
  }
}


class ListMenuView extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  @override
  Widget build(BuildContext context) {
    _theMenu.scrollListener();

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: Obx(
          (){
            return _theMenu.listMenu.isEmpty?Center(child: CircularProgressIndicator(),):
            ListView.builder(
              addAutomaticKeepAlives: true,
              controller: _theMenu.scrollController.value,
              itemCount: _theMenu.listMenu.length,
              itemBuilder: (context, i) => 
              Visibility(
                visible: _theMenu.listMenu[i].terlihat??false,
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Card(
                              child: CachedNetworkImage(
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                imageUrl: _theMenu.listMenu[i].foto??"",
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => 
                                Center(
                                  child: Image.asset('assets/images/noimage.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              showModalBottomSheet(
                                context: context, 
                                isScrollControlled: true,
                                builder: (context) => 
                                DetailMenu(listMenu: _theMenu.listMenu[i],i: i,tambah: true,),
                              );
                            }
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_theMenu.listMenu[i].namaPro,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0.lima())
                                    ),
                                  ).paddingOnly(bottom: 8),
                                  Text(_theMenu.listMenu[i].hargaPro.toString().rupiah(),
                                    style: TextStyle(
                                      color: Color(0.empat()),
                                      fontSize: 18,
                                    ),
                                  ).paddingOnly(bottom: 8),
                                  Text(_theMenu.listMenu[i].ket,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  Container(
                                    child: !_theMenu.listMenu[i].lihatEditTambah?
                                    Container(
                                      child: Text(_theMenu.listMenu[i].note??"",
                                        style: TextStyle(
                                          backgroundColor: Colors.green[50],
                                          color: Colors.green
                                        ),
                                      )
                                    ):
                                    // disini : input note
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Card(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[100],
                                            isDense: true,
                                            filled: true,
                                            hintText: "eg : more salt",
                                            contentPadding: EdgeInsets.all(8),
                                            border: InputBorder.none
                                          ),
                                          maxLength: 100,
                                          controller: _theMenu.noteController[i]
                                        ),
                                      ),
                                    )
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _theMenu.listMenu[i].qty == 0?
                                      Card(
                                        color: Color(0.enam()),
                                        child: InkWell(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text("add +",
                                              style: TextStyle(
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                          onTap: (){
                                            _theMenu.listMenu[i].qty = 1;
                                            _theMenu.adaOrderan.value = true;
                                            _theMenu.hitungTotal();
                                            _theMenu.listMenu.update((value) { print('tamabah item');});
                                          },
                                        ),
                                      ):
                                      Container(
                                        child: Row(
                                          children: [
                                            // tambah note
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: InkWell(
                                                // disini : tombol note
                                                child: Card(
                                                  child:Icon(_theMenu.listMenu[i].lihatEditTambah?Icons.done:Icons.edit,
                                                    color: _theMenu.listMenu[i].lihatEditTambah?Colors.green:Colors.orange,
                                                  ),
                                                ),
                                                onTap: (){
                                                  print("note");
                                                  if(_theMenu.noteController[i].text != "") _theMenu.listMenu[i].note = _theMenu.noteController[i].text;
                                                  _theMenu.listMenu[i].lihatEditTambah = !_theMenu.listMenu[i].lihatEditTambah;
                                                  _theMenu.listMenu.update((value) { 
                                                    print('act : tombol edit note');
                                                  });
                                                },
                                              ),
                                            ),
                                            Card(
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text("-")
                                                    ),
                                                    onTap: (){
                                                      _theMenu.kurangiQty(i);
                                                      //_theMenu.listMenu.update((value) { print("kurangi orderan");});

                                                    },
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    child: Text(
                                                      _theMenu.listMenu[i].qty.toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color(0.enam()),
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text("+")
                                                    ),
                                                    onTap: (){
                                                      _theMenu.tambahQty(i);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ),
            );
          }
        ),
      ),
    );
  }
}



/* ================== */

// class OpenTable extends StatefulWidget{
//   @override
//   _OpenTableState createState() => _OpenTableState();
// }

// class _OpenTableState extends State<OpenTable> {
//   final str = GetStorage();
//   List _menu;
//   bool totalan = false;
//   int totalQty = 0;
//   int totalValue = 0;
//   String meja;
//   Map user;
//   String host;
//   final _kunciState = GlobalKey<ScaffoldState>();
//   final _theMenu = Get.find<ListMenuNya>();
  

//   @override
//   void initState() {
//     _theMenu.getListMenu();
//     super.initState();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   if(_menu == null){
//   //     Future.microtask(()async{
//   //       _theMenu.getListMenu();
//   //       //final mn = await new Dio().get(str.read('host')+"/api/getMenu?product=&group=&subgroup=");
//   //       // setState(() {
//   //       //   meja = str.read('meja');
//   //       //   host = str.read('host');
//   //       //   user = str.read('auth');

//   //       //   _menu = str.read('lsmenu');
//   //       //   List coba = _menu;

//   //       //   // coba = coba.map((e) => e['subgroupp']).toList().toSet().toList();

//   //       //   // print(coba);

//   //       //   _menu.forEach((e){
//   //       //     e['note'] = "";
//   //       //     e['lihatTambah'] = true;
//   //       //     e['lihatEditTambah'] = false;
//   //       //     e['qty'] = 0;
//   //       //     if(e['groupp'].toString().trim() == "FOOD"){
//   //       //       e['terlihat'] = true;
//   //       //     }else{
//   //       //       e['terlihat'] = false;
//   //       //     }
//   //       //   });
//   //       // });
//   //     });
//   //   }
//   // }
//   // final _listSub = ['FOOD','BEVERAGE','OTHERS'];
//   final _listSub = [
//     {
//       "judul": "FOOD",
//       "ditekan": true
//     },
//     {
//       "judul": "BEVERAGE",
//       "ditekan": false
//     },
//     {
//       "judul": "OTHERS",
//       "ditekan": false
//     }
//   ];
//   final _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     print('open table');
    
//     return 
//     Obx(
//       (){
//         _menu = _theMenu.listMenu;

//         return 
//         _menu == null ? Center(child: CircularProgressIndicator(),):
//         GestureDetector(
//           onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
//           child: WillPopScope(
//             onWillPop: ()async => false,
//             child: Scaffold(
//               extendBodyBehindAppBar: true,
//               key: _kunciState,
//               appBar: AppBar(
//                 backgroundColor: Colors.white,
//                 automaticallyImplyLeading: false,
//                 toolbarHeight: 100,
//                 elevation: 0,
//                 title: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Wrap(
//                         alignment: WrapAlignment.spaceBetween,
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               InkWell(
//                                 child: CircleAvatar(
//                                   backgroundColor: Color(0.enam()),
//                                   child: Icon(Icons.account_circle,
//                                     size: 40,
//                                   ),
//                                 ),
//                                 onTap: (){
//                                   showModalBottomSheet(
//                                     isDismissible: true,
//                                     isScrollControlled: true,
//                                     context: context, 
//                                     builder: (context) => UserProfile(user: user,),
//                                   );
//                                 },
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 8),
//                                 child: Text(user['name'],
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.black
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // Text("Table "+ meja,
//                                 //   style: TextStyle(
//                                 //     fontWeight: FontWeight.w700,
//                                 //     color: Colors.deepOrange,
//                                 //     fontSize: 34,
//                                 //     shadows: [
//                                 //       Shadow(
//                                 //         blurRadius: 2,
//                                 //         color: Colors.grey,
//                                 //         offset: Offset(0,2)
//                                 //       )
//                                 //     ]
//                                 //   ),
//                                 // ),
//                               ],
//                             )
//                           )
//                         ],
//                       ),
//                     ),
                    
//                     /* sub menu */
//                     Container(
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//                           for(var i = 0; i < _listSub.length;i++)
//                           InkWell(
//                             child: Card(
//                               color: _listSub[i]['ditekan']? Colors.cyan[700]:Colors.cyan,
//                               child: Container(
//                                 padding: EdgeInsets.all(4),
//                                 child: Text(_listSub[i]['judul'],
//                                   style: TextStyle(
//                                     color: _listSub[i]['ditekan']? Colors.white:Colors.cyan[100],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 _menu.forEach((el) {
//                                   if(el['groupp'].toString().trim() == _listSub[i]['judul']){
//                                     el['terlihat'] = true;
//                                   }else{
//                                     el['terlihat'] = false;
//                                   }
//                                 });

//                                 _listSub.forEach((element) {
//                                   if(element['judul'].toString().trim() == _listSub[i]['judul']){
//                                     element['ditekan'] = true;
//                                   }else{
//                                     element['ditekan'] = false;
//                                   }
//                                 });

//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               body: Column(
//                 children: [
//                   /* 
//                   Flexible(
//                     flex: 1,
//                     child: ListItemMenu(
//                       listMenu: _menu,
//                       host: host,
//                       meja: meja,
//                       user: user,
//                       searchController: _searchController,
//                       onDitambah: (List val) {
//                         /* update list meu */
//                         setState((){
                      
//                             _menu = val;
//                             try {
//                               var ttlQty = val.where((element) => element['qty'] != 0).map((e) => e['qty']).reduce((value, element) => value + element);
//                               var ttlVal = val.where((element) => element['qty'] != 0).map((e) => int.parse(e['harga_pro'].toString()) * int.parse(e['qty'].toString())).reduce((value, element) => int.parse(value.toString()) + int.parse(element.toString()));
//                               totalQty = ttlQty;
//                               totalValue = ttlVal;
//                               totalan = true;
//                             } catch (e) {
//                               totalan = false;
//                             }
                        
//                         });

//                         print('update');
              
//                       },
//                       onTambah: () {
//                         print("ditambah kok");
//                       },
//                     )
//                   ),
//                   !totalan?SizedBox.shrink():
//                   Card(
//                     elevation: 10,
//                     color: Color(0.enam()),
//                     margin: EdgeInsets.all(8),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       width: double.infinity,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Total QTY "+totalQty.toString() +" | Rp."+ totalValue.toString() +" (Est)",
//                             style: TextStyle(
//                               color: Colors.white
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.shopping_basket,
//                               color: Colors.white,
//                             ), 
//                             onPressed: () => lihatRincianOrder(context, _menu,totalQty.toString(), totalValue.toString())
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 */],
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }
// }

// void messageInfo(BuildContext context,String judul,String isi){
//     showDialog(context: context,
//       child: AlertDialog(
//         titlePadding: EdgeInsets.all(0),
//         contentPadding: EdgeInsets.all(0),
//         title: Container(
//           padding: EdgeInsets.all(8),
//           color: Colors.blue[300],
//           child: Text(judul)
//         ),
//         content: Container(
//           padding: EdgeInsets.all(8),
//           child: Text(isi)
//         ),
//       )
//     );
//   }

/* lihat rincian orderan */
// void lihatRincianOrder(BuildContext context, List _menu, String totalQty, String totalValue)async{
//   var lsNya = _menu.where((element) => element['qty'] != 0).toList();
//   showModalBottomSheet(
//     isDismissible: true,
//     isScrollControlled: true,
//     context: context, 
//     builder: (context) => 
//     Container(
//       height: MediaQuery.of(context).size.height/1.1,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             width: double.infinity,
//             alignment: Alignment.center,
//             color: Colors.grey[300],
//             child: Text("==="),
//           ),
//           Flexible(
//             child: Card(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 child: ListView(
//                   children: [
//                     for(var i = 0 ;i < lsNya.length;i++)
//                     Container(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             child: Card(
//                               child: CachedNetworkImage(
//                                 fit: BoxFit.cover,
//                                 imageUrl: lsNya[i]['foto'],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(lsNya[i]['nama_pro'],
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Text(lsNya[i]['qty'].toString()+" x  Rp "+NumberFormat("#,###","IDR").format(int.parse(lsNya[i]['harga_pro'].toString()))),
//                                       Text("Rp "+ NumberFormat("#,###","IDR").format((int.parse(lsNya[i]['qty'].toString())* int.parse(lsNya[i]['harga_pro'].toString()))))
//                                       //Text("Rp "+ (int.parse(lsNya[i]['qty'].toString())* int.parse(lsNya[i]['harga_pro'].toString())).toString())
//                                     ],
//                                   ),
//                                   Text(lsNya[i]['note'].toString(),
//                                     style: TextStyle(
//                                       color: Colors.grey
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Card(
//                       margin: EdgeInsets.only(top: 50),
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Detail Value Estimation",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
                                
//                                 Text("TOTAL ESTIMATION:"),
//                                 Text("Rp "+NumberFormat("#,###","IDR").format(int.parse(totalValue)))
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("TOTAL QTY:"),
//                                 Text(totalQty)
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Card(
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   FlatButton(
//                     minWidth: double.infinity,
//                     color: Color(0.enam()),
//                     textColor: Colors.white,
//                     onPressed: ()async{
//                       SharedPreferences prf = await SharedPreferences.getInstance();
//                       final host = prf.getString('host');
//                       final meja = prf.getString('meja');
//                       final user = jsonDecode(prf.getString("user"));

//                       var bill = _menu.where((e) => e['qty'] != 0).toList().map((m)=>{
//                         "product_id": m['kode_pro'],
//                         "product_price": m['harga_pro'],
//                         "qty": m['qty'],
//                         "note": m['note']
//                       }).toList();

//                       var paket = {
//                         "customer_id": user['phone'],
//                         "name": user['name'],
//                         "phone": user['phone'],
//                         "email": user['email'],
//                         "billDetail": bill
//                       };
                      
//                      /* upaya terakhir */
//                       try {
//                         print(paket);
//                         final res = await new Dio().post("$host/api/saveOrder/"+meja,data: paket);
//                         if(res.data['status']){
//                          /*  prf.clear();
//                           prf.setString('pesanan', jsonEncode(_menu).toString());
//                           Phoenix.rebirth(context); */
//                           infoTerakhir(context,_menu);
//                         }
//                       } catch (e) {
//                         messageInfo(context, "error", e.toString());
//                       } 

//                     }, 
//                     child: Text('PROCCESS')
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }


/* finaising info terakhir */
void infoTerakhir(BuildContext context, List menu)async{
  
  await showDialog(
    context: context,
    child: AlertDialog(
      title: Text('info'),
      content: Text('Thank For Your Order'),
      actions: [
        FlatButton(
          onPressed: (){
            pembersihanLogOut(context, menu);
          }, 
          child: Text('OK')
        )
      ],
    )
  );
  pembersihanLogOut(context, menu);
}

/* untuk logout */
void pembersihanLogOut(BuildContext context, List menu)async{
  final _prf = await SharedPreferences.getInstance();
  _prf.clear();
  _prf.setString("pesanan", jsonEncode(menu).toString());
  Navigator.of(context).pushReplacementNamed('/');
}


/* list menu utama */
// class ListItemMenu extends StatelessWidget{
//   final List listMenu;
//   final VoidCallback onTambah;
//   final Function(List) onDitambah;
//   final _noteController = TextEditingController();
//   final meja, user , host;
//   final searchController;
//   ListItemMenu({Key key, this.listMenu, this.onTambah, this.onDitambah, this.meja, this.user, this.host, this.searchController}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
    
//     return ListView(
//       children: [
//         Container(
//           height: 200,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.asset('assets/images/bahan.jpg',
//                 fit: BoxFit.cover,
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.all(8),
//                   child: Text("Table "+ meja,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       color: Colors.cyan,
//                       fontSize: 34,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 2,
//                           color: Colors.white,
//                           offset: Offset(0,2)
//                         )
//                       ]
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             fillColor: Colors.grey[200],
//             contentPadding: EdgeInsets.symmetric(vertical: 16),
//             hintText: 'search',
//             filled: true,
//             isDense: true,
//             enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//             prefixIcon: Icon(Icons.search),
//             suffixIcon: IconButton(
//               icon: Icon(Icons.remove_circle,
//               ),
//               onPressed: (){
//                 FocusScope.of(context).requestFocus(new FocusNode());
//                 searchController.clear();
//                 listMenu.forEach((el) {
//                   if(el['groupp'].toString().trim() == "FOOD"){
//                     el['terlihat'] = true;
//                   }else{
//                     el['terlihat'] = false;
//                   }
//                 });

//                 onDitambah(listMenu);
//               }
//             )
//           ),
//           onChanged: (value) {
//             listMenu.forEach((el) {
//               if(el['nama_pro'].toString().trim().toLowerCase().contains(value.toString())){
//                 el['terlihat'] = true;
//               }else{
//                 el['terlihat'] = false;
//               }
//             });
//             if(value == ""){
//               listMenu.forEach((el) {
//                 if(el['groupp'].toString().trim() == "FOOD"){
//                   el['terlihat'] = true;
//                 }else{
//                   el['terlihat'] = false;
//                 }
//               });
//             }
//             onDitambah(listMenu);
//           },
//         ),
        
//         for(var a = 0; a < listMenu.length ;a ++)
//         Visibility(
//           visible: listMenu[a]['terlihat'],
//           child: Container(
//             padding: EdgeInsets.all(8),
//             color: Colors.white,
//             width: double.infinity,
//             margin: EdgeInsets.only(bottom: 8),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       child: InkWell(
//                         onTap: (){
//                           showDialog(context: context,
//                             child: AlertDialog(
//                               content: DetailMenu(listMenu: listMenu[a],)
//                             )
//                           );
//                         },
//                         child: Card(
//                           child: CachedNetworkImage(
//                             imageUrl: listMenu[a]['foto'],
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => Center(child: Icon(Icons.replay_outlined)),
//                             errorWidget: (context, url, error) => Center(child: Text('error')),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(listMenu[a]['nama_pro'],
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(vertical: 8),
//                               child: Text(listMenu[a]['ket'],
//                               overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.grey
//                                 ),
//                               ),
//                             ),
//                             /* note : harga */
//                             Container(
//                               child: Text("Rp "+NumberFormat("#,###","IDR").format(int.parse(listMenu[a]['harga_pro'].toString())),
//                                 style: TextStyle(
//                                   //fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                             ),
//                             !listMenu[a]['lihatEditTambah']?SizedBox.shrink():
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Wrap(
//                                 alignment: WrapAlignment.end,
//                                 crossAxisAlignment: WrapCrossAlignment.center,
//                                 children: [
//                                   Text(listMenu[a]['note'],
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   Wrap(
//                                     alignment: WrapAlignment.end,
//                                     crossAxisAlignment: WrapCrossAlignment.center,
//                                     children: [
//                                       Card(
//                                         child: InkWell(
//                                           child: Icon(Icons.edit,
//                                             color: listMenu[a]['note'] == ""?Colors.cyan:Colors.blue[300],
//                                           ), 
//                                           onTap: (){
//                                             _noteController.text = listMenu[a]['note'];
//                                             editNote(context,_noteController,onEditNote: () {
//                                               listMenu[a]['note'] = _noteController.text;
//                                               Navigator.of(context,rootNavigator: true).pop('dialog');
//                                               onDitambah(listMenu);
//                                             },);
//                                           }
//                                         ),
//                                       ),
//                                       /* note : hapus qty */
//                                       IconButton(
//                                         icon: Icon(Icons.remove_circle,
//                                           color: Colors.red[300],
//                                         ), 
//                                         onPressed: () => hapusPilihan(context,okHapus: (){
//                                           listMenu[a]['lihatTambah'] = true;
//                                           listMenu[a]['lihatEditTambah'] = false;
//                                           listMenu[a]['qty'] = 0;
//                                           onDitambah(listMenu);
//                                           Navigator.of(context,rootNavigator: true).pop('dialog');
//                                         })
//                                       )
//                                     ],
//                                   ),
//                                   Card(
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         /* note : kurangi qty */
//                                         InkWell(
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(vertical: 4),
//                                             margin: EdgeInsets.symmetric(horizontal: 8),
//                                             child: Text(' - ',
//                                               style: TextStyle(
//                                                 color: Colors.green
//                                               ),
//                                             ),
//                                           ), 
//                                           onTap: (){
//                                             listMenu[a]['qty'] -=1;
//                                             if(listMenu[a]['qty'] < 1){
//                                               listMenu[a]['lihatTambah'] = true;
//                                               listMenu[a]['lihatEditTambah'] = false;
//                                               listMenu[a]['qty'] = 0;
//                                               onDitambah(listMenu);
//                                             }
//                                             onDitambah(listMenu);
//                                           }
//                                         ),
//                                         /* note : tampilan qty */
//                                         Container(
//                                           padding: EdgeInsets.symmetric(horizontal: 16),
//                                           child: Text(listMenu[a]['qty'].toString()),
//                                         ),
//                                         /* note : tambah qty */
//                                         InkWell(
//                                           child: Icon(Icons.add,
//                                             color: Colors.green[300],
//                                           ), 
//                                           onTap: (){
//                                             listMenu[a]['qty'] +=1;
//                                             onDitambah(listMenu);
//                                           }
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             !listMenu[a]['lihatTambah']?SizedBox.shrink():
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: InkWell(
//                                 onTap: (){
//                                   listMenu[a]['lihatTambah'] = false;
//                                   listMenu[a]['lihatEditTambah'] = true;
//                                   listMenu[a]['qty'] = 1;
//                                   onDitambah(listMenu);
//                                 }, 
//                                 child: Card(
//                                   color: Color(0.enam()),
//                                   child: Container(
//                                     padding: EdgeInsets.only(top: 4,bottom: 4, left: 8, right: 8),
//                                     child: Text('add +',
//                                       style: TextStyle(
//                                         color: Colors.white
//                                       ),
//                                     )
//                                   )
//                                 )
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )
//       ],   
//     );
//   }


//   void hapusPilihan(BuildContext context,{VoidCallback okHapus}){
//     showModalBottomSheet(
//       context: context, 
//       builder: (context) => 
//       Container(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.all(8),
//               child: Text("Delete One Item ??")
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: FlatButton(
//                 color: Colors.deepOrange,
//                 textColor: Colors.white,
//                 onPressed: () => okHapus(), 
//                 child: Text('delete')
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void editNote(BuildContext context,TextEditingController _noteController,{VoidCallback onEditNote}){
//     print("sdit note");
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => 
//       Container(
//         height: MediaQuery.of(context).size.height/1.1,
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               color: Colors.grey,
//               alignment: Alignment.center,
//               child: Text("==="),
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
                  
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Add Some Note',
//                       style: TextStyle(
//                         fontSize: 24
//                       ),
//                     ),
//                   ),
//                   TextField(
//                     controller: _noteController,
//                     maxLength: 50,
//                     maxLines: 1,
//                     decoration: InputDecoration(
//                       labelText: "eg : spicy please",
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     child: FlatButton(
//                       color: Color(0.enam()),
//                       onPressed: () => onEditNote(), 
//                       child: Text('SAVE',
//                         style: TextStyle(
//                           color: Colors.white
//                         ),
//                       )
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
    
//   }

// }

