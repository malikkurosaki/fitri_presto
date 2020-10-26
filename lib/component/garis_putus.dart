import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GarisPutus extends StatelessWidget {
  final warna;
  final garis = 10.0;

  const GarisPutus({Key key, this.warna}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        width: double.infinity,
        child: Row(
          children: [
            for(var i = 0; i < constraints.maxWidth/garis ;i++)
            Expanded(
              child: Container(
                width: garis,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 2),
                color: warna??Colors.grey,
              ),
            )
          ],
        )
      ),
    );
  }
}

extension Tulisan on String{
  rupiah(){
    return "Rp "+NumberFormat("#,###","IDR").format(int.parse(this.contains(".")?this.split('.')[0].toString():this));
  }
}

extension TextNya on Text{
  putih(){
    return Text(this.data,
      style: TextStyle(
        color: Colors.white
      ),
    );
  }

  paddingBawah(){
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        this.data,
        style: this.style,
      ),
    );
  }
}


extension Warana on int{
  satu() => 0xffAAB3A4;
  duaa() => 0xffE7E2DF;
  tiga() => 0xff587B5C;
  empat() => 0xffE9816D;
  lima() => 0xff422B30;
  enam() => 0xff3381AD;
}