import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'book_menu.dart';


class MyHome extends StatefulWidget {
  final meja,host;
  const MyHome({Key key, this.meja, this.host}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List _menu;
  List _lsMenu;

  @override
  void initState() {
    Future.microtask(()async{
      final _prf = await SharedPreferences.getInstance();
      if(_prf.getString('pesanan') != null ){
        setState(() {
          _menu = jsonDecode(_prf.getString('pesanan')).where((e)=>e['qty'] != 0).toList();
          _lsMenu = jsonDecode(_prf.getString('pesanan'));
        });
       
      }else{
        print('menu kosong');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    print("iam in myhome");
    
    return _menu != null ? LihatPesaanan(menu: _menu,lsMenu: _lsMenu,):
    Scaffold(
      body: SafeArea(
        child: Center(
          child: InkWell(
            onLongPress: ()async{
              final conMeja = TextEditingController();
              

              showDialog(context: context,
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: conMeja,
                        decoration: InputDecoration(
                          hintText: 'maasukkan nomer mejanya'
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('fasilitas ini hanya untuk kepentingan developer aja , akan dihapus setelah release',
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        )
                      )
                    ],
                  ),
                  actions: [
                    FlatButton(
                      onPressed: ()async{
                        if(conMeja.text == "" || !isNumeric(conMeja.text)) conMeja.text = "3";
                        await new Dio().post("https://prestoqr.probussystem.com/api/clearTable/"+conMeja.text);
                        Navigator.of(context).pushReplacementNamed('/3/prestoqr.probussystem.com');
                      }, 
                      child: Text('ok')
                    )
                  ],
                )
              );
              
            },
            child: Text('WELCOME',
              style: TextStyle(
                fontSize: 42,
                color: Colors.grey
              ),
            )
          ),
        )
        
      ),
    );
  }
}
 


class LihatPesaanan extends StatelessWidget {
  final List menu;
  final List lsMenu;

  LihatPesaanan({Key key, this.menu, this.lsMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500
          ),
          child: Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView(
                      children: [
                        Text('List Of Your Order',
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.grey
                          ),
                        ),
                        for(var i = 0; i < menu.length;i++)
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                elevation: 10,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: menu[i]['foto'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child:  Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(menu[i]['nama_pro'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.grey
                                        ),
                                      ),
                                      Chip(
                                        label : Text(menu[i]['qty'].toString() + " x",
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                      Text(menu[i]['note'].toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: ()async{
                        showDialog(context: context,
                          child: AlertDialog(
                            contentPadding: EdgeInsets.all(8),
                            scrollable: true,
                            content: Center(child: CircularProgressIndicator(),),
                          )
                        );
                        
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.of(context,rootNavigator: true).pop();

                        showModalBottomSheet(
                          context: context, 
                          isScrollControlled: true,
                          isDismissible: true,
                          builder: (context) => ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 500
                            ),
                            child: BookMenu(menu: lsMenu,)
                          ),
                        );
                      }, 
                      child: Text('LIST MENU')
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  

}
