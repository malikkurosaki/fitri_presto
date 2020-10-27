import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/component/garis_putus.dart';

class DetailOrderan extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.1,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Icon(Icons.arrow_drop_down),
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: [
                    Flexible(
                      child: Obx(()=>
                        ListView(
                          children: [
                            for(var i = 0; i < _theMenu.listMenu.length; i++)
                            Visibility(
                              visible: _theMenu.listMenu[i].qty != 0?true:false,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Card(
                                            child: CachedNetworkImage(
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              imageUrl: _theMenu.listMenu[i].foto
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(_theMenu.listMenu[i].namaPro),
                                                Text(_theMenu.listMenu[i].hargaPro.rupiah()),
                                                Text(_theMenu.listMenu[i].note??"",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    backgroundColor: Colors.green[100]
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Card(
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Color(0.empat()),
                                                        ),
                                                        onTap: (){
                                                          _theMenu.hapusOrderan(i);
                                                        },
                                                      ),
                                                    ),
                                                    Card(
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                                              child: Text("-"),
                                                            ),
                                                            onTap: (){
                                                              if(_theMenu.listMenu.where((e) => e.qty != 0).map((e) => e.qty).reduce((a, b) => a+b) > 1){
                                                                _theMenu.kurangiQty(i);
                                                              }else{
                                                                _theMenu.hapusOrderan(i);
                                                              }
                                                              
                                                            },
                                                          ),
                                                          Text(_theMenu.listMenu[i].qty.toString()),
                                                          InkWell(
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                                              child: Text("+"),
                                                            ),
                                                            onTap: (){
                                                              _theMenu.tambahQty(i);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // titik titik dibawah
                                    GarisPutus()
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      )
                    ),

                    // disini : bagian prosses
                    Obx( () =>
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                color: Color(0.duaa()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Estimation",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    ),
                                    Text("total qty : "+ _theMenu.totalQty.toString()),
                                    Text("total order : "+ _theMenu.totalOrder.toString()),
                                    Text("estimated pay : "+ _theMenu.totalValue.toString().rupiah())
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: FlatButton(
                                  textColor: Colors.white,
                                  color: Color(0.tiga()),
                                  onPressed: (){
                                    _theMenu.prossesOrderan(context);
                                  }, 
                                  child: Text('Prosses')
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    )
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