
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:presto_qr/controller/kunci.dart';
import 'package:presto_qr/controller/malik_dynamic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


/* class OpenOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _malik = Provider.of<MalikDynamic>(context);
    final _menu = Provider.of<Map>(context);
    
    return lihat(context);
  }

  Widget lihat(BuildContext context){
    final layout = Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Text('ini orderran')
          ],
        ),
      ),
    );
    return layout;
  }
  
} */



class OpenOrder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print('open order');
    final _menu = Provider.of<Map>(context);
    final _malik = Provider.of<MalikDynamic>(context);
    
    final _catatan = TextEditingController();
    final _lsController = ScrollController();
    
    return (_menu == null  || _malik == null)?Center(child: CircularProgressIndicator(),):
    WillPopScope(
      onWillPop: () async{
        print('mau kembali');
        return false;
      },
      child: Scaffold(
        // floatingActionButton: _menu == null?null:_menu['muncul']??false?
        // FloatingActionButton.extended(
        //   icon: Icon(Icons.shopping_cart),
        //   label: Text(_menu['total'].toString()??""),
        //   onPressed: (){
        //     /* perhitungan totalnya */
        //     perhitungan(_menu, _malik);

        //     /* munculkan detail orderan */
        //     showDialog(context: context,
        //       child: detailOrder(context,_malik,_menu,_con)
        //     );

        //   }
        // ):null,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _menu == null?Text('loading')
                  :Card(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Table "+_menu[Malik.MEJA.toString()],
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.search), 
                                    onPressed: (){

                                    }
                                  ),
                                  PopupMenuButton(
                                    icon: Icon(Icons.account_circle_rounded),
                                    onSelected: (val){
                                      print(val);
                                    },
                                    itemBuilder:  (context) => <PopupMenuItem>[
                                      for(var a = 0; a < 10; a++)
                                      PopupMenuItem(
                                        child: Text("menu "+a.toString()),
                                        value: a.toString(),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              for(var i = 0;i < _menu[Malik.GROUP.toString()].length;i++)
                              InkWell(
                                onTap: ()async{
                                  _menu[Malik.MENU.toString()].forEach((e)async{
                                    e[Malik.TERLIHAT.toString()] = false;
                                  });
                                  _malik.update();
                                  await Future.delayed(Duration(microseconds: 10));

                                  _menu[Malik.MENU.toString()].forEach((e)async{
                                    if(e['groupp'].toString().trim() == _menu[Malik.GROUP.toString()][i]['group'].toString().trim()){
                                      e[Malik.TERLIHAT.toString()] = true;
                                    }else{
                                      e[Malik.TERLIHAT.toString()] = false;
                                    }
                                  });

                                  _malik.update();
                                  

                                  // for(var x = 0; x < _menu[Malik.MENU.toString()].length;x++){
                                  //   if(_menu[Malik.MENU.toString()][x]['groupp'].toString().trim() == _menu[Malik.GROUP.toString()][i]['group'].toString().trim()){
                                  //     _menu[Malik.MENU.toString()][x][Malik.TERLIHAT.toString()] = true;
                                  //     await Future.delayed(Duration(seconds: 1));
                                  //     _malik.update();
                                  //   }else{
                                  //     _menu[Malik.MENU.toString()][x][Malik.TERLIHAT.toString()] = false;
                                  //   }
                                  // }

                                  

                                  // /* sekaligus bikin animasi */
                                  // _malik.data['padding'] = 120;
                                  // _malik.update();

                                  // /* animasi saat ganti group menu */
                                  // await Future.delayed(Duration(seconds: 1));
                                  // _menu[Malik.MENU.toString()].forEach((e){
                                  //   if(e['groupp'].toString().trim() == _menu[Malik.GROUP.toString()][i]['group'].toString().trim()){
                                  //     e[Malik.TERLIHAT.toString()] = true;
                                  //   }else{
                                  //     e[Malik.TERLIHAT.toString()] = false;
                                  //   }
                                  // });
                                  // _malik.update();
                                  // await Future.delayed(Duration(seconds: 1));
                                  // _malik.data[Malik.PADDING.toString()] = 0;
                                  // _malik.update();
                                },
                                child: Chip(
                                  backgroundColor: Colors.cyan,
                                  label: Text(_menu[Malik.GROUP.toString()][i]['group'].toString(),
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* kumpulan menu */
                  Flexible(
                    flex: 1,
                    child: ListView(
                      controller: _lsController,
                      children: [
                        Column(
                          children: [
                            for(var i = 0; i < _menu[Malik.MENU.toString()].length; i++)
                            /* per menunya */
                            Visibility(
                              visible: _menu[Malik.MENU.toString()][i][Malik.TERLIHAT.toString()],
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[200]
                                    )
                                  )
                                ),
                                child: ListTile(
                                  /* ketika listmenu di click */
                                  onTap: (){

                                    showDialog(
                                      context: context,
                                      child: Container(
                                        padding: EdgeInsets.all(42),
                                        child: Scaffold(
                                          appBar: AppBar(
                                            title: Text('Detail'),
                                            centerTitle: false,
                                          ),
                                          body: ListView(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: _menu[Malik.MENU.toString()][i]['foto'],
                                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                                errorWidget: (context, url, error) => 
                                                Container(
                                                  width: double.infinity,
                                                  height: 200,
                                                  child: Center(
                                                    child: Text('image error')
                                                  ),
                                                  color: Colors.grey
                                                )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(_menu[Malik.MENU.toString()][i]['nama_pro'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Rp " +_menu[Malik.MENU.toString()][i]['harga_pro']),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(_menu[Malik.MENU.toString()][i]['ket']),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  },
                                  leading: CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    imageUrl: _menu[Malik.MENU.toString()][i]['foto'],
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                    errorWidget: (context, url, error) => 
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.error,
                                        color: Colors.red,
                                        )
                                      ),
                                    ),
                                  ),
                                  /* nama product */
                                  title: Text(_menu[Malik.MENU.toString()][i]['nama_pro']),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /* harga */
                                      Text("Rp "+_menu[Malik.MENU.toString()][i]['harga_pro'],),
                                      Container(
                                        width: double.infinity,
                                        /* pembungkus note dan lainnya */
                                        child: Wrap(
                                          alignment: WrapAlignment.end,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text(_menu[Malik.MENU.toString()][i][Malik.NOTE.toString()],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.blue
                                              ),
                                            ),
                                            Visibility(
                                              visible: _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] == null?false:true,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.edit,color: Colors.green,), 
                                                    onPressed: (){
                                                      /* dialog tambah note */
                                                      showDialog(
                                                        context: context,
                                                        child: AlertDialog(
                                                          titlePadding: EdgeInsets.all(0),
                                                          contentPadding: EdgeInsets.all(4),
                                                          title: Container(
                                                            padding: EdgeInsets.all(8),
                                                            color: Colors.blue[300],
                                                            child: Text('add some note',
                                                            style: TextStyle(
                                                              color: Colors.white
                                                            ),
                                                            )
                                                          ),
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              /* tambah note */
                                                              TextField(
                                                              controller: _catatan,
                                                              textAlign: TextAlign.start,
                                                              textAlignVertical: TextAlignVertical.top,
                                                                maxLines: 5,
                                                                maxLength: 100,
                                                                decoration: InputDecoration(
                                                                  contentPadding: EdgeInsets.all(0),
                                                                  hintText: 'some note',
                                                                  border: InputBorder.none,
                                                                  fillColor: Colors.grey[100],
                                                                  filled: true,
                                                                  alignLabelWithHint: true,
                                                                  prefix: Icon(Icons.edit),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: double.infinity,
                                                                alignment: Alignment.centerRight,
                                                                child: FlatButton(
                                                                  textColor: Colors.white,
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                  color: Colors.blue,
                                                                  onPressed: (){
                                                                    _menu[Malik.MENU.toString()][i][Malik.NOTE.toString()] =  _catatan.text;
                                                                    print(_catatan.text);
                                                                    _malik.update();
                                                                    Navigator.of(context,rootNavigator: true).pop('dialog');
                                                                  }, 
                                                                  child: Text('DONE')
                                                            ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                    );
                                                  }
                                                ),

                                                /* hapus pesasnannya coy */
                                                IconButton(
                                                  icon: Icon(Icons.delete,
                                                    color: Colors.red,
                                                  ), 
                                                  onPressed: (){

                                                    showDialog(context: context,
                                                      child: AlertDialog(
                                                        title: Text('MESSAGE '),
                                                        content: Text('will you delete it ??'),
                                                        actions: [
                                                          IconButton(
                                                            icon: Text('OK'), 
                                                            onPressed: (){
                                                              _menu[Malik.MENU.toString()][i][Malik.NOTE.toString()] = "";
                                                              _menu[Malik.MENU.toString()][i][Malik.BTN_ADD.toString()] = true;
                                                              _menu[Malik.MENU.toString()][i][Malik.BTN_QTY.toString()]= false;
                                                              _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] = null;
                                                              _malik.update();
                                                              perhitungan(_menu, _malik);
                                                              Navigator.of(context,rootNavigator: true).pop('dialog');
                                                            }
                                                          ),
                                                          IconButton(
                                                            icon: Text('NO'), 
                                                            onPressed: (){
                                                              Navigator.of(context,rootNavigator: true).pop('dialog');
                                                            }
                                                          )
                                                        ],
                                                      )
                                                    );
                                                  }
                                                ),
                                                ],
                                              ),
                                            ),
                                          /* tombol tambah dan kurang */
                                          Visibility(
                                            visible:  _menu[Malik.MENU.toString()][i][Malik.BTN_QTY.toString()],
                                            child: Card(
                                              color: Colors.green,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  /* tombol pengurangan */
                                                  InkWell(
                                                    child: Chip(
                                                      backgroundColor: Colors.grey[200],
                                                      label: Text("-",
                                                        style: TextStyle(
                                                          color: Colors.red
                                                        ),
                                                      )
                                                    ),
                                                    onTap: (){
                                                      _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] -= 1;

                                                      /* jika qty kurang dari satu */
                                                      if(_menu[Malik.MENU.toString()][i][Malik.QTY.toString()] < 1){
                                                        _menu[Malik.MENU.toString()][i][Malik.NOTE.toString()] = "";
                                                        _menu[Malik.MENU.toString()][i][Malik.BTN_ADD.toString()] = true;
                                                        _menu[Malik.MENU.toString()][i][Malik.BTN_QTY.toString()]= false;
                                                        _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] = null;
                                                      } 
                                                      perhitungan(_menu, _malik);
                                                    },
                                                  ),
                                                  Chip(
                                                    label: Text(_menu[Malik.MENU.toString()][i][Malik.QTY.toString()].toString()??"")
                                                  ),
                                                  InkWell(
                                                    child: Chip(
                                                      backgroundColor: Colors.grey[200],
                                                      label: Text("+",
                                                        style: TextStyle(
                                                          color: Colors.green
                                                        )
                                                      )
                                                    ),
                                                    onTap: (){
                                                      _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] += 1;
                                                      perhitungan(_menu, _malik);
                                                    },
                                                  )
                                                ],
                                              ),
                                            )
                                          ),

                                          /* tombol tambah add */
                                          Visibility(
                                            visible: _menu[Malik.MENU.toString()][i][Malik.BTN_ADD.toString()],
                                            child: FlatButton(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                color: Colors.grey[200],
                                                onPressed: (){
                                                  _menu[Malik.MENU.toString()][i][Malik.BTN_ADD.toString()] = false;
                                                  _menu[Malik.MENU.toString()][i][Malik.BTN_QTY.toString()] = true;
                                                  _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] = 1;
                                                  _menu[Malik.MUNCUL_TOTAL.toString()] = true;
                                                  perhitungan(_menu, _malik);
                                                }, 
                                                child: Text('add  +',
                                                style: TextStyle(
                                                  color: Colors.green
                                                ),
                                                )
                                            ),
                                          )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  /* totalan */
                  Visibility(
                    visible: _menu[Malik.MUNCUL_TOTAL.toString()]??false,
                    child: Card(
                      color: Colors.blue[300],
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_menu[Malik.TOTAL_QTY.toString()].toString() +" Item  | Rp " + _menu[Malik.TOTAL_BAYAR.toString()].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.shopping_cart,
                                color: Colors.white,
                              ), 
                              onPressed: (){
                                List lsMn = _menu[Malik.MENU.toString()].where((e)=>e[Malik.QTY.toString()] != null).toList();

                                /* memunculkan detail order */
                                showDialog(context: context,
                                  child: Container(
                                    padding: EdgeInsets.all(24),
                                    child: Scaffold(
                                      appBar: AppBar(
                                        title: Text('Detail Order'),
                                      ),
                                      body: Column(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: ListView(
                                              children: [
                                                Column(
                                                  children: [
                                                    for(var i = 0; i < lsMn.length;i++)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                                      ),
                                                      padding: EdgeInsets.all(8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text("${lsMn[i][Malik.QTY.toString()]} x ${lsMn[i]['nama_pro']}",
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                              Text("Rp "+(int.parse(lsMn[i][Malik.QTY.toString()].toString())*int.parse(lsMn[i]['harga_pro'].toString())).toString(),
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Text(lsMn[i][Malik.NOTE.toString()],
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                          Card(
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              color: Colors.green,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(_menu[Malik.TOTAL_QTY.toString()].toString() + " Item  |  Total ",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                        ),
                                                      ),
                                                      Text("Rp "+_menu[Malik.TOTAL_BAYAR.toString()].toString(),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(

                                                    /* prosses masukkan data ke server */
                                                    width: double.infinity,
                                                    margin: EdgeInsets.only(top: 20),
                                                    child: FlatButton(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                      color: Colors.white,
                                                      textColor: Colors.green,
                                                      onPressed: ()async{
                                                        SharedPreferences prf = await SharedPreferences.getInstance();

                                                        var bill = _menu[Malik.MENU.toString()].where((e) => e[Malik.QTY.toString()] != null).toList().map((m)=>{
                                                          "product_id": m['kode_pro'],
                                                          "product_price": m['harga_pro'],
                                                          "qty": m[Malik.QTY.toString()],
                                                          "note": m[Malik.NOTE.toString()]
                                                        }).toList();

                                                        var paket = {
                                                          "customer_id": _menu[Malik.USER.toString()]['phone'],
                                                          "name": _menu[Malik.USER.toString()]['name'],
                                                          "phone": _menu[Malik.USER.toString()]['phone'],
                                                          "email": _menu[Malik.USER.toString()]['email'],
                                                          "billDetail": bill
                                                        };

                                                        print("https://${_menu[Malik.HOST.toString()]}/api/saveOrder/"+_menu[Malik.MEJA.toString()]);
                                                        print(paket);

                                                        try {
                                                          print('coba kirim paketan');
                                                          final res = await new Dio().post("https://${_menu[Malik.HOST.toString()]}/api/saveOrder/"+_menu[Malik.MEJA.toString()],data: paket);
                                                          print(res.data);

                                                          if(res.data['status']){
                                                            /* simpan response */
                                                            print('simpan kengembalian');
                                                            prf.setString(Malik.DIORDER.toString(), jsonEncode(res.data).toString());

                                                            print('coba logout dan hapus meja');
                                                            /* coba untuk logout */
                                                            final keluar = await new Dio().post("https://"+_menu[Malik.HOST.toString()]+"/api/clearTable/"+_menu[Malik.MEJA.toString()]);

                                                            print('meja '+_menu[Malik.MEJA.toString()]+" berhasil dihapus");

                                                            print('coba membersihkan semua data yang ada dilocal');
                                                            prf.clear();
                                                            print('data local telah dibersihkan');
                                                            print('menyimpan menu yang telah diorder');
                                                            prf.setString('menu', jsonEncode(_menu[Malik.MENU.toString()]).toString());
                                                          
                                                            showDialog(context: context,
                                                              child: AlertDialog(
                                                                content: Text('data saved'),
                                                              )
                                                            );
                                                            print('restart aplikasi');
                                                            Phoenix.rebirth(context);
                                                          }else{
                                                            showDialog(context: context,
                                                              child: AlertDialog(
                                                                content: Text('some error detected'),
                                                              )
                                                            );
                                                          }

                                                        } catch (e) {
                                                          print("mengalami kegagalan "+e.toString());
                                                          showDialog(context: context,
                                                            child: AlertDialog(
                                                              title: Text('Message'),
                                                              content: Text(e.toString()),
                                                            )
                                                          );
                                                        }

                                                      }, 
                                                      child: Text('PROCCESS',
                                                        style: TextStyle(
                                                          fontSize: 18
                                                        ),
                                                      )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                );
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // /* detail menu popup */
  // detailMenu(MalikDynamic _malik, menu){
  //   return Container(
  //     child: ListView(
  //       children: [
  //         Image.network(menu['foto']),
  //         Container(
  //           padding: EdgeInsets.all(8),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(menu['nama_pro'],
  //                 style: TextStyle(
  //                   fontSize: 24,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.grey
  //                 ),
  //               ),
  //               Text(menu['harga_pro'],
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   color: Colors.deepOrange,
  //                   fontWeight: FontWeight.bold
  //                 ),
  //               ),
  //               SizedBox(height: 25,),
  //               Text(menu['ket'],
  //                 style: TextStyle(
  //                   color: Colors.grey,
  //                   fontStyle: FontStyle.italic
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
          
  //       ],
  //     ),
  //   );
  // }

  // detailOrder(BuildContext context, MalikDynamic _malik,_menu, List<TextEditingController> _con){
  //   final _val = Perubahan(context);

  //   return ValueListenableBuilder(
  //     valueListenable: _val,
  //     builder: (BuildContext context, value, Widget child) =>
  //     Container(
  //       padding: EdgeInsets.all(42),
  //       child: Scaffold(
  //         appBar: AppBar(),
  //         body: Column(
  //           children: [
  //             Flexible(
  //               fit: FlexFit.tight,
  //               flex: 1,
  //               child: ListView(
  //                 children: [
  //                   for(var i = 0; i < _menu[Malik.MENU.toString()].length;i++)
  //                   Visibility(
  //                     visible: _menu[Malik.MENU.toString()][i]['dipilih']??false,
  //                     child: ListTile(
  //                       title: Text(_menu[Malik.MENU.toString()][i]['nama_pro'],
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold
  //                         ),
  //                       ),
  //                       subtitle: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Expanded(
  //                                 child: Text(_menu[Malik.MENU.toString()][i]['harga_pro']),
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   FlatButton(
  //                                     color: Colors.red,
  //                                     textColor: Colors.white,
  //                                     shape: CircleBorder(),
  //                                     onPressed: (){
  //                                       if(_menu[Malik.MENU.toString()][i][Malik.QTY.toString()] == null) _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] = 1;
  //                                       _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] -= 1;
  //                                       if(_menu[Malik.MENU.toString()][i][Malik.QTY.toString()] < 1) _menu[Malik.MENU.toString()].removeAt(i);
  //                                       _malik.update();
  //                                       _val.update();


  //                                        /* perhitungan totalnya */
  //                                       perhitungan(_menu, _malik);
  //                                     }, 
  //                                     child: Text('-')
  //                                   ),
  //                                   Chip(
  //                                     label: Text(_menu[Malik.MENU.toString()][i][Malik.QTY.toString()] == null? "1": _menu[Malik.MENU.toString()][i][Malik.QTY.toString()].toString())
  //                                   ),
  //                                   FlatButton(
  //                                     color: Colors.green,
  //                                     textColor: Colors.white,
  //                                     shape: CircleBorder(),
  //                                     onPressed: (){
  //                                       if(_menu[Malik.MENU.toString()][i][Malik.QTY.toString()] == null) _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] = 1;
  //                                       _menu[Malik.MENU.toString()][i][Malik.QTY.toString()] += 1;
  //                                       _malik.update();
  //                                       _val.update();

  //                                       /* perhitungan totalnya */
  //                                       perhitungan(_menu, _malik);
  //                                     }, 
  //                                     child: Text('+')
  //                                   )
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                           /* buat note */
  //                           TextField(
  //                             controller: _con[i],
  //                             decoration: InputDecoration(
  //                               filled: true,
  //                               fillColor: Colors.grey[100],
  //                               labelText: 'write some note'
  //                             ),
  //                             onEditingComplete: (){
  //                               print(_con[i].text);
  //                             },
  //                           )
  //                         ],
  //                       ),
  //                       dense: true,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               height: 70,
  //               alignment: Alignment.centerLeft,
  //               color: Colors.green,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 mainAxisSize: MainAxisSize.max,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.all(4),
  //                     color: Colors.white.withOpacity(0.2),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Text("total qty order : "+ _menu[Malik.TOTAL_QTY.toString()].toString()),
  //                         Text("total value : "+ _menu[Malik.TOTAL_BAYAR.toString()].toString())
  //                       ],
  //                     ),
  //                   ),

  //                   /* memprosses orderan */
  //                   FlatButton(
  //                     onPressed: ()async{
  //                       SharedPreferences prf = await SharedPreferences.getInstance();
  //                       for (var i = 0; i < _menu[Malik.MENU.toString()].length;i++){
  //                         _menu[Malik.MENU.toString()][i][Malik.NOTE.toString()] = _con[i].text;
  //                       }

  //                       // Paketan paketan = new Paketan();
  //                       // BillDetail billDetail = new BillDetail();


  //                       var bill = _menu[Malik.MENU.toString()].where((e) => e['dipilih'] == true).toList().map((m)=>{
  //                         "product_id": m['kode_pro'],
  //                         "product_price": m['harga_pro'],
  //                         "qty": m[Malik.QTY.toString()],
  //                         "note": m[Malik.NOTE.toString()]
  //                       }).toList();

  //                       var paket = {
  //                         "customer_id": _menu['user']['phone'],
  //                         "name": _menu['user']['name'],
  //                         "phone": _menu['user']['phone'],
  //                         "email": _menu['user']['email'],
  //                         "billDetail": bill
  //                       };


  //                       // var coba = {
  //                       //   "customer_id": "1",
  //                       //   "name": "Fitri",
  //                       //   "phone": "080823",
  //                       //   "email": "fitridwi62@gmail.com",
  //                       //   "billDetail": [
  //                       //     {
  //                       //       "product_id": "MSC.0002",
  //                       //       "product_price": "20000",
  //                       //       "qty": 2,
  //                       //       "note": "extra gula"
  //                       //     },
  //                       //     {
  //                       //       "product_id": "RST.0006",
  //                       //       "product_price": "20000",
  //                       //       "qty": "3",
  //                       //       "note": "dijadikan 1"
  //                       //     }
  //                       //   ]
  //                       // };

  //                       try {
  //                         print('coba kirim paketan');
  //                         final res = await new Dio().post("https://${_menu['host']}/api/saveOrder/"+_menu['meja'],data: paket);
  //                         print(res.data);

  //                         if(res.data['status']){
  //                           print('coba logout dan hapus meja');
  //                           final keluar = await new Dio().post("https://"+_menu['host']+"/api/clearTable/"+_menu['meja']);
  //                           print('meja '+_menu['meja']+" berhasil dihapus");

  //                           print('coba membersihkan semua data yang ada dilocal');
  //                           prf.clear();
  //                           print('data local telah dibersihkan');
  //                           print('menyimpan menu yang telah diorder');
  //                           prf.setString('menu', jsonEncode(_menu[Malik.MENU.toString()]).toString());
                          
  //                           showDialog(context: context,
  //                             child: AlertDialog(
  //                               content: Text('data saved'),
  //                             )
  //                           );
  //                           print('restart aplikasi');
  //                           Phoenix.rebirth(context);
  //                         }else{
  //                           showDialog(context: context,
  //                             child: AlertDialog(
  //                               content: Text('some error detected'),
  //                             )
  //                           );
  //                         }

  //                       } catch (e) {
  //                         print("mengalami kegagalan "+e.toString());
  //                       }
  //                     }, 
  //                     child: Text('PROCCES',
  //                       style: TextStyle(
  //                         color: Colors.white
  //                       ),
  //                     )
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  perhitungan(_menu,MalikDynamic _malik){
    List datanya = _menu[Malik.MENU.toString()].where((e) => e[Malik.QTY.toString()] != null).toList();
    var totalBayar = 0;
    var totalQty = 0;
    for(var i = 0; i< datanya.length; i++){
      totalBayar += int.parse(datanya[i][Malik.QTY.toString()].toString()) * int.parse(datanya[i]['harga_pro'].toString());
      totalQty += int.parse(datanya[i][Malik.QTY.toString()].toString());
    }
    print("$totalBayar => $totalQty");
    _menu[Malik.TOTAL_BAYAR.toString()] = totalBayar;
    _menu[Malik.TOTAL_QTY.toString()] = totalQty;
    if(_menu[Malik.TOTAL_QTY.toString()] < 1) _menu[Malik.MUNCUL_TOTAL.toString()] = false;
    _malik.update();
  }

}

class GakAdaHost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('scan barcode on the table first , please',
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 42,
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}


class Perubahan extends ValueNotifier {
  Perubahan(value) : super(value);
  update(){notifyListeners();}
}


