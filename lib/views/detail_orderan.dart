import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presto_qr/controller/list_menu.dart';
import 'package:provider/provider.dart';

class DetailOrderan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
     body: SafeArea(
       child: Consumer<ListMenu>(
         builder: (context, value, child) {
           return Text(value.lsData.length.toString());
         },
       ),
     ),
   );
  }
  
}

/* class DetailOrderan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print('detail order');
    final lsMenu = Provider.of<ListMenu>(context);
    final _kunci = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _kunci,
      appBar: AppBar(
        title: Text('Detail Order'),
        actions: [
          FlatButton(
            textColor: Colors.deepOrange,
            onPressed: (){
              lsMenu.lsData.forEach((element) {
                if(element['dipilih']){
                  element['dipilih'] = false;
                }
              });
              lsMenu.update();
              Navigator.pop(context);
            },
            child: Text('CANSEL ORDER')
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  for(var i = 0;i < lsMenu.lsData.length;i++)
                  Visibility(
                    visible: lsMenu.lsData[i]['dipilih'],
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      margin: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: Image.network(lsMenu.lsData[i]['foto'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(lsMenu.lsData[i]['nama_pro'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(lsMenu.lsData[i]['harga_pro'].toString(),
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                              color: Colors.red,
                                            ), 
                                            onPressed: (){
                                              lsMenu.lsData.removeAt(i);
                                              lsMenu.update();
                                            }
                                          ),
                                          Card(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove,
                                                    color: Colors.yellow,
                                                  ), 
                                                  onPressed: (){
                                                    lsMenu.lsData[i]['qty'] -= 1;
                                                    if(lsMenu.lsData[i]['qty'] < 1) lsMenu.lsData.removeAt(i);
                                                    lsMenu.update();
                                                  }
                                                ),
                                                Chip(
                                                  label: Text(lsMenu?.lsData[i]['qty']?.toString()??"1")
                                                ),
                                                /* tambah qty */
                                                IconButton(
                                                icon: Icon(Icons.plus_one,
                                                  color: Colors.green,
                                                ), 
                                                onPressed: (){
                                                  lsMenu.lsData[i]['qty'] == null?lsMenu.lsData[i]['qty'] = 1: lsMenu.lsData[i]['qty'] +=1;  
                                                  lsMenu.update();
                                                }
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
                          Container(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'write some note gaes',
                                fillColor: Colors.grey[100],
                                filled: true
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              /* tombol proccess */
              child: FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: (){
                  showDialog(context: context,
                    child: AlertDialog(
                      content: Text('uda yakin .. ?'),
                      actions: [
                        FlatButton(
                          onPressed: (){
                            Navigator.of(context,rootNavigator: true).pop('dialog');
                          }, 
                          child: Text('BELUM')
                        ),
                        FlatButton(
                          onPressed: (){
                            Navigator.of(context,rootNavigator: true).pop('dialog');
                          }, 
                          child: Text('SUDAH')
                        )
                      ],
                    ),
                  );
                }, 
                child: Text('PROCCESS')
              ),
            )
          ],
        ),
      ),
    );
  }
}

 */