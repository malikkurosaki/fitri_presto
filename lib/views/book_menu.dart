import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/views/detail_menu.dart';
import 'package:presto_qr/views/open_table.dart';

class BookMenu  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 0.8,
      expand: true,
      builder: (_,__) => 
      GetX(
        initState: (state) => ListMenuNya.to.getListMenu(),
        builder: (_) => ListMenuNya.to.listMenu.isEmpty?Center(child: CircularProgressIndicator( ),):
        Column(
          children: [
            PanelBar(),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(16),
                child: ListView(
                  controller: __,
                  children: [
                    for(var i = 0; i< ListMenuNya.to.listMenu.length;i++)
                    Visibility(
                      visible: ListMenuNya.to.listMenu[i].terlihat,
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            InkWell(
                              child: Card(
                                child: CachedNetworkImage(
                                  imageUrl: ListMenuNya.to.listMenu[i].foto,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                  errorWidget: (context, url, error) => Center(child: Text("error"),),
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: () => Get.bottomSheet(DetailMenu(listMenu: ListMenuNya.to.listMenu[i],i: i,tambah: false,))
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsetsDirectional.only(start: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ListMenuNya.to.listMenu[i].namaPro,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ).paddingOnly(bottom: 8),
                                    Text(ListMenuNya.to.listMenu[i].hargaPro).paddingOnly(bottom: 8),
                                    Text(ListMenuNya.to.listMenu[i].ket,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey
                                      ),
                                    ).paddingOnly(bottom: 8),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
            /* Obx(() => 
              Container(
                child: Row(
                  children: [
                    for(var i = 0; i < ListMenuNya.to.subMenu.length;i++)
                    FlatButton(
                      color: ListMenuNya.to.subMenu[i]['dipilih']?Colors.grey:Colors.transparent,
                      onPressed: () => ListMenuNya.to.sortSubMenu(i), 
                      child: Text(ListMenuNya.to.subMenu[i]['nama'])
                    )
                  ],
                )
              )
            ) */
            
          ],
        )
      )
    );
  }
}
