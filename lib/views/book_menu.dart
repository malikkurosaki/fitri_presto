import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/views/detail_menu.dart';

class BookMenu  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height/1.1,
      child: Scaffold(
        body: GetX<ListMenuNya>(
           initState: (state) => ListMenuNya.to.getListMenu(),
           builder: (val) => 
           Column(
            children: [
              InkWell(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_drop_down),
                ),
                onTap: (){
                  Get.back();
                },
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
          ),
        )
      ),
    );
  }
}
