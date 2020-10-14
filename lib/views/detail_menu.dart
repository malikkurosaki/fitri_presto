import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailMenu extends StatelessWidget {
  final Map listMenu;

  const DetailMenu({Key key, this.listMenu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Container(
        //   color: Colors.grey[300],
        //   width: double.infinity,
        //   alignment: Alignment.center,
        //   child: Text("==="),
        // ),
        Flexible(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: Card(
                      child: InkWell(
                        onTap: () => Navigator.of(context,rootNavigator: true).pop(),
                        child: CachedNetworkImage(
                          imageUrl: listMenu['foto'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                          errorWidget: (context, url, error) => Center(child: Text('error'),),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(listMenu['nama_pro'],
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text("Rp "+NumberFormat("#,###","IDR").format(int.parse(listMenu['harga_pro'].toString())),
                  style: TextStyle(
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(listMenu['ket'],
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}