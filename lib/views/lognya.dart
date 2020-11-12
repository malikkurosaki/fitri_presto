import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presto_qr/controller/lognya_controller.dart';

class LogNya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Text("lihat log"),
              for(var i = 0; i < LognyaController.to.log.length;i++)
              Text(LognyaController.to.log[i].toString())
            ],
          ),
        ),
      ),
    );
  }
}