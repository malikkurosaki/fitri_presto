import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detailmenu extends StatelessWidget{
  final Map<String,dynamic> dataMenu;
  const Detailmenu({Key key, this.dataMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Text('detail menu')
          ],
        ),
      ),
    );
  }

}