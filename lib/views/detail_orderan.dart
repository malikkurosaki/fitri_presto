import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';

class DetailOrderan extends StatelessWidget {
  final _theMenu = Get.find<ListMenuNya>();
  final controllerNya;

  DetailOrderan({Key key, this.controllerNya}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 1,
      minChildSize: 0.7,
      builder: (_,__) => 
        Card(
        child: Obx(()=>
          Column(
            children: [
              Flexible(
                child: ListView(
                  controller: __,
                  children: [
                      for(var i = 0; i < _theMenu.listMenu.length; i++)
                      Visibility(
                        visible: _theMenu.listMenu[i].qty != 0?true:false,
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      child: CachedNetworkImage(
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        imageUrl: _theMenu.listMenu[i].foto??"",
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                        errorWidget: (context, url, error) => Image.asset('assets/images/logo_qr_presto.png'),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_theMenu.listMenu[i].namaPro),
                                          Text(_theMenu.listMenu[i].hargaPro.rupiah(),
                                            style: TextStyle(
                                              color: Colors.orange
                                            ),
                                          ),
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
                                                    Get.bottomSheet(
                                                      Card(
                                                        child: Container(
                                                          padding: EdgeInsets.all(16),
                                                          child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text("Delete This Item ? "),
                                                                FlatButton(
                                                                  child: Text("OK",
                                                                    style: TextStyle(
                                                                      color: Color(0.enam())
                                                                    ),
                                                                  ),
                                                                  onPressed: (){
                                                                    _theMenu.hapusOrderan(i);
                                                                    _theMenu.listMenu[i].lihatEditTambah = false;
                                                                    Get.back();
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                        ),
                                                      ),
                                                    );
                                                  
                                                  },
                                                ),
                                              ),
                                              Card(
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        padding: EdgeInsets.all(8),
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
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text(_theMenu.listMenu[i].qty.toString())
                                                    ),
                                                    InkWell(
                                                      child: Container(
                                                        padding: EdgeInsets.all(8),
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
                      ),
                    // disini : bagian prosses
                    
                  ],
                ),
              ),
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
                          color: Color(0.enam()),
                          onPressed: (){
                            _theMenu.prossesOrderan(context);
                          }, 
                          child: Text('PROCCESS')
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}