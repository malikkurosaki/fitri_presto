import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/views/detail_menu.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/component/garis_putus.dart';

class BookMenu  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 1,
      minChildSize: 0.7,
      expand: true,
      builder: (_,__) => 
      GetX(
        initState: (state) => ListMenuNya.to.getListMenu(),
        builder: (_) => ListMenuNya.to.listMenu.isEmpty?Center(child: CircularProgressIndicator( ),):
        Column(
          children: [
            //PanelBar(),
            Flexible(
              child: Card(
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
                                    placeholder: (context, url) => Center(child: Image.asset('assets/images/logo_qr_presto.png'),),
                                    errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/logo_qr_presto.png'),),
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () => showModalBottomSheet(context: context, 
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => DetailMenu(listMenu: ListMenuNya.to.listMenu[i],i: i,tambah: false,),
                                )
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
                                      Text(ListMenuNya.to.listMenu[i].hargaPro.rupiah(),
                                        style: TextStyle(
                                          color: Colors.orange
                                        ),
                                      ).paddingSymmetric(vertical: 8),
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
            ),
          ],
        )
      )
    );
  }
}
