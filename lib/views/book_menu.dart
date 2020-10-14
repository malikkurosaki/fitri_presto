import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presto_qr/views/detail_menu.dart';

class BookMenu extends StatelessWidget{
  final List menu;

  const BookMenu({Key key, this.menu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: MediaQuery.of(context).size.height/1.1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.grey,
            width: double.infinity,
            child: Text("==="),
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500
              ),
              child: Card(
                child: ListView(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('List Of Menu'),
                                Text('this is only light list of menu , You can re-login or re-scan, to start a new order',
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        for(var a = 0; a < menu.length; a++)
                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                content: DetailMenu(listMenu: menu[a],)
                              )
                            );
                          },
                          child: Card(
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: menu[a]['foto']??"",
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                    errorWidget: (context, url, error) => Center(child: Text('error'),),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.deepOrange,
                                            Colors.yellow
                                          ]
                                        )
                                      ),
                                      child: Text(menu[a]['nama_pro'],
                                      overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                      color: Colors.cyan,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text("Rp "+NumberFormat("#,###","IDR").format(int.parse(menu[a]['harga_pro'].toString())),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }
  
}