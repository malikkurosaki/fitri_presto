import 'package:flutter/material.dart';
import 'package:presto_qr/controller/malik_dynamic.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("home");
    // final _malik = Provider.of<MalikDynamic>(context);
    final _menu = Provider.of<MalikDynamicModel>(context);

    return Scaffold(
      body: SafeArea(
        child: _menu == null ? Text('loading'):
        Text(_menu.nama.toString() +"ini"),
        
      ),
      // body: _menu == null? Center(child: CircularProgressIndicator(),):
      // _menu[Malik.DIORDER.toString()] == null?
      // Center(
      //   child: ConstrainedBox(
      //     constraints: BoxConstraints(
      //       maxWidth: 600
      //     ),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.max,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Container(
      //           padding: EdgeInsets.all(8),
      //           width: 200,
      //           child: Image.asset('assets/images/logo.png',
      //             scale: 3/2,
      //           ),
      //         ),
      //         Text('scan barcode on the table first , please',
      //         textAlign: TextAlign.center,
      //           style: TextStyle( 
      //             fontSize: 42,
      //             color: Colors.grey
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ):Center(
      //   child: Text(_menu[Malik.DIORDER.toString()]),
      // )
    );
  }
  
}