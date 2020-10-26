import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';

class DetailMenu extends StatelessWidget {
  final MenuModel listMenu;
  final int i;
  final _theMenu = Get.find<ListMenuNya>();
  final tambah;

  DetailMenu({Key key, this.listMenu, this.i, this.tambah}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height/1.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.green,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text("==="),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: InkWell(
                      onTap: () => Navigator.of(context,rootNavigator: true).pop(),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: listMenu.foto,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => Center(child: Text('error'),),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(listMenu.namaPro,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("Rp "+NumberFormat("#,###","IDR").format(int.parse(listMenu.hargaPro.toString())),
                          style: TextStyle(
                          ),
                        ),
                        !tambah?SizedBox.shrink():
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            color: Color(0.tiga()),
                            textColor: Colors.white,
                            child: Text('add +'),
                            onPressed: (){
                              _theMenu.tambahQty(i);
                              Get.back();
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(listMenu.ket,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}