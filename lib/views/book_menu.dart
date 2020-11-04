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

    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 0.8,
      expand: true,
      builder: (_,__) => 
      GetX<ListMenuNya>(
        initState: (state) => ListMenuNya.to.getListMenu(),
        builder: (val) => 
        Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: __,
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
                      onTap: () => Get.bottomSheet(DetailMenu(listMenu: val.listMenu[i],i: i,tambah: false,))
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsetsDirectional.only(start: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(val.listMenu[i].namaPro,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ).paddingOnly(bottom: 8),
                            Text(val.listMenu[i].hargaPro).paddingOnly(bottom: 8),
                            Text(val.listMenu[i].ket,
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
            ],
          ),
        ),
      )
    );
  }
}
