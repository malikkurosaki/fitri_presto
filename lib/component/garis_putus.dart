import 'package:ansicolor/ansicolor.dart';
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

  biru(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 0, g: 1, b: 1);
    return pen(this);
  }

  ungu(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 1, g: 0, b: 1);
    return pen(this);
  }

  kuning(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 1, g: 1, b: 0);
    return pen(this);
  }

  merah(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 1.5, g: 0, b: 0);
    return pen(this);
  }

  hijau(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 0, g: 0.5, b: 0);
    return pen(this);
  }

  abu(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 0.5, g: 0.5, b: 0.5);
    return pen(this);
  }

  orange(){
    AnsiPen pen = new AnsiPen()..white()..rgb(r: 1, g: 0.5, b: 0.5);
    return pen(this);
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

  judul(){
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(this.data,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ), 
      ),
    );
  }

  get judulPutih => Text(this.data,
    style: TextStyle(
      color: Colors.white,
      fontSize: 18
    ),
  );

}


extension Warana on int{
  satu() => 0xffAAB3A4;
  duaa() => 0xffE7E2DF;
  tiga() => 0xff587B5C;
  empat() => 0xffE9816D;
  lima() => 0xff422B30;
  enam() => 0xff3381AD;
}


class Komponen {
  
}