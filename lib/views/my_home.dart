
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder(
        initState: (state) => ListMenuNya.to.lihatPesanan(), 
        builder: (ListMenuNya controller) => 
        Column(
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(16),
                child: ListView(
                  children: [
                    for(var i = 0; i < controller.pesananNya.value.detailBills.length ;i++)
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: controller.pesananNya.value.detailBills[i].foto??"",
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                    errorWidget: (context, url, error) => Image.asset('assets/images/bahan.jpg',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                      elevation: 10,
                                      color: Colors.deepOrangeAccent,
                                      child: Text(controller.pesananNya.value.detailBills[i].qty.toString()+" X ",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
                                
                                Text(controller.pesananNya.value.detailBills[i].namaPro,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(controller.pesananNya.value.detailBills[i].hargaPro.toString().rupiah(),
                                  style: TextStyle(
                                    color: Color(0.empat()),
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                                Text(controller.pesananNya.value.detailBills[i].note??"",
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
                ),
              ),
            ),
            Card(
              color: Color(0.duaa()),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(controller.pesananNya.value.name + " | ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text("Table  "+controller.pesananNya.value.tableId,
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
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
                              //Text("order has been delivered"),
                              FlatButton(
                                textColor: Colors.white,
                                color: Color(0.enam()),
                                minWidth: double.infinity,
                                child: Text("my order has been delivered"),
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
                              FlatButton(
                                textColor: Colors.white,
                                color: Color(0.enam()),
                                minWidth: double.infinity,
                                child: Text("show the menu list"),
                                onPressed: (){
                                  // Get.dialog(Center(child: CircularProgressIndicator(),));
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context, 
                                    builder: (context) => BookMenu(),
                                  );
                                  //Get.back();
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
      ),
    );
  }
}

/* class MyHomeAdaPesanan extends StatelessWidget {
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
              child: Container(
                padding: EdgeInsets.all(16),
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
                ),
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
                            //Text("order has been delivered"),
                            FlatButton(
                              textColor: Colors.white,
                              color: Color(0.enam()),
                              minWidth: double.infinity,
                              child: Text("my order has been delivered"),
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
                            // Text("who knows if you want to order again",
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            FlatButton(
                              textColor: Colors.white,
                              color: Color(0.enam()),
                              minWidth: double.infinity,
                              child: Text("show the menu list"),
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
} */

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
                    //http://prestoqr.probussystem.net/qr/#/login?meja=1&host=http://prestoqr.probussystem.net/presto/public
                    await _theMenu.kosongkanMeja(
                      "3",
                      "http://prestoqr.probussystem.net/presto/public"
                    );
                    print("hapus meja");
                    Get.offAllNamed('/login?meja=3&host=http://prestoqr.probussystem.net/presto/public');
                    print("menuju login");
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
