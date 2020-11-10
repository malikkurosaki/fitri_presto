import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/company_controller.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/controller/user_controller.dart';
import 'package:presto_qr/views/detail_menu.dart';
import 'package:presto_qr/views/detail_orderan.dart';
import 'package:presto_qr/views/user_profile.dart';

class OpenTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        for(var i = 0; i < ListMenuNya.to.listMenu.length;i++){
          ListMenuNya.to.listMenu[i].lihatEditTambah = false;
        }
        ListMenuNya.to.listMenu.update((value) {print('update list ');});
      },
      child: GetX<ListMenuNya>(
        initState: (state) => ListMenuNya.to.getListMenu(),
        builder: (controller) => 
          Container(
            child: Scaffold(
            // disini : bottom sheet
            // bottomSheet: DetailBawah(),
            floatingActionButton: !controller.adaOrderan.value?null:
            FloatingActionButton.extended(
              backgroundColor: Color(0.enam()),
              onPressed: (){
                // showModalBottomSheet(
                //   context: context, 
                //   isScrollControlled: true,
                //   builder: (context) => DetailOrderan(),
                // );

                // showModalBottomSheet(
                //   context: context, 
                //   isScrollControlled: true,
                //   builder: (_) => DetailOrderan()
                // );
                showModalBottomSheet(
                  context: context, 
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => DetailOrderan()
                );
                
              },
              label: Text(controller.totalQty.toString()+" item of "+controller.totalOrder.toString()+" order"),
              icon: Icon(Icons.shopping_cart),
            ),
            body: ListMenuNya.to.listMenu.isEmpty?Padding(
              padding: const EdgeInsets.all(64),
              child: Center(child: Image.asset('assets/images/logo_qr_presto.png')),
            ):
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // disini : appbar
                  Container(
                    child: Visibility(
                      visible: !ListMenuNya.to.totalanBawah.value,
                      child: Column(
                        children: [
                          AppBarAtas(),
                        ],
                      ),
                    ),
                  ),
                  PanelBar(),
                  Flexible(
                    child: ListMenuView()
                  )
                ],
              ),
            ),
          ),
        ),
      )
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
  // final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
  
  return 
  GetX<CompanyProfileController>(
    initState: (state){
      CompanyProfileController.to.init();
      UserController.to.init();
    },
    builder: (controller) => 
    controller.cp.value.data.isNull?Text("loading"):
    Container(
      color: Color(0.enam()),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                InkWell(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_circle_sharp),
                  ),
                  onTap: () => showModalBottomSheet(
                    context: context, 
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => UserProfile()
                  )
                ),
                UserController.to.user.value.user.isNull?Text("name"):
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(UserController.to.user.value.user.name).judulPutih
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(CompanyProfileController?.to?.cp?.value?.data?.name??"name").putih(),
              Text("Table "+ListMenuNya.to.meja.value).putih(),
            ],
          )
        ],
      ),
    ),
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
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => ListMenuNya.to.sortSubMenu(i), 
                        child: Container(
                          color: _theMenu.subMenu[i]['dipilih']?Colors.orange:Color(0.enam()),
                          
                          child: Container(
                            color: Color(0.enam()),
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 4),
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

    return Container(
      child: Obx(
        (){
          return _theMenu.listMenu.isEmpty?Center(child: Image.asset('assets/images/logo_qr_presto.png'),):
          ListView.builder(
            addAutomaticKeepAlives: true,
            //controller: _theMenu.scrollController.value,
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
                              placeholder: (context, url) => Center(child: Image.asset('assets/images/logo_qr_presto.png'),),
                              errorWidget: (context, url, error) => 
                              Center(child: Image.asset('assets/images/logo_qr_presto.png')),
                            ),
                          ),
                          onTap: (){
                            showModalBottomSheet(
                              context: context, 
                              backgroundColor: Colors.transparent,
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
                                /* disini : keterangan note */
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: !_theMenu.listMenu[i].lihatEditTambah?
                                  Visibility(
                                    visible: _theMenu.listMenu[i].note == ""?false:true,
                                    child: Container(
                                      child: Text(_theMenu.listMenu[i].note??"",
                                        style: TextStyle(
                                          backgroundColor: Colors.green[50],
                                          color: Colors.green
                                        ),
                                      )
                                    ),
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
                                        controller: _theMenu.noteController[i],
                                        onChanged: (nilai){
                                          _theMenu.listMenu[i].note = nilai;
                                        },
                                      ),
                                    ),
                                  )
                                ),
                                _theMenu.listMenu[i].qty == 0?
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Card(
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
                                      onTap: ()=>ListMenuNya.to.tambahOrderan(i),
                                    ),
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
                                            child:Icon(Icons.edit,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          onTap: () => ListMenuNya.to.tambahNote(i),
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
                                              onTap: () => ListMenuNya.to.kurangiQty(i),
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
                                              onTap: () => ListMenuNya.to.tambahQty(i),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            child: Card(
                                              child: Icon(Icons.remove_circle,
                                                color: Colors.red,
                                              )
                                            ),
                                            onTap: () => ListMenuNya.to.hapusOrderan(i),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
    );
  }
}
