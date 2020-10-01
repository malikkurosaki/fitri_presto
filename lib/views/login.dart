
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:presto_qr/controller/kunci.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatelessWidget{

  final meja,host;
  Login({Key key, this.meja, this.host}) : super(key: key);
  static final _datanya = ['guest name','email','phone number'];
  static final _iconnya = [Icons.people,Icons.email,Icons.phone];
  final _con = List.generate(_datanya.length, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    // final _setting = Provider.of<Map>(context);

    // if(_setting == null) return Center(child: CircularProgressIndicator(),);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("TABLE "+ meja.toString()),
        // actions: _setting == null?null:!_setting[Setting.DEVELOP.toString()]?null:[
        //   IconButton(
        //     icon: Icon(Icons.settings), 
        //     onPressed: (){
        //       Navigator.pushNamed(context, '/setting');
        //     }
        //   )
        // ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600
            ),
            child: Container(
              child: meja == null?gkAdaMeja():adaMeja(context),
            ),
          ),
        ),
      ),
    );
  }

  Future<List> getMenuNya()async{
    return jsonDecode(await rootBundle.loadString('./fake/menu.json'));
  }

  adaMeja(BuildContext context){
    return Card(
      child: ListView(
        children: [
          // Container(
          //   height: 100,
          //   alignment: Alignment.centerLeft,
          //   color: Colors.blue[300],
          //   child: Text("TABLE "+ meja.toString(),
          //     style: TextStyle(
          //       fontSize: 42,
          //       color: Colors.white
          //     ),
          //   ),
          // ),
          /* FlatButton(
            onPressed: ()async{
              SharedPreferences prf = await SharedPreferences.getInstance();
              final mn = await getMenuNya();
              prf.setString('menu', jsonEncode(mn).toString());
              prf.setString('meja', '4');
              print('ok gaes');

            }, 
            child: Text('lihat')
          ), */
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for(var i = 0; i < _datanya.length;i++)
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _con[i],
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      prefixIcon: Icon(_iconnya[i]),
                      labelText: _datanya[i],
                      border: InputBorder.none
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(28))
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      SharedPreferences prf = await SharedPreferences.getInstance();
                      var kosong = false;
                        for(var a in _con){
                          if(a.text == ""){
                            print(a.text);
                            kosong = true;
                          }
                        }

                        /* jika ada kosong */
                        if(kosong){
                          showDialog(context: context,
                            child: AlertDialog(
                              titlePadding: EdgeInsets.all(0),
                              title: Container(child: Text('INFORMATION',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
                              content: Text("empty not allowed"),
                            )
                          );
                          return;
                        }

                        /* jika format email saalah */
                        if(!_con[1].text.contains("@") || !_con[1].text.contains(".")){
                          showDialog(context: context,
                            child: AlertDialog(
                              titlePadding: EdgeInsets.all(0),
                              title: Container(child: Text('INFORMATION',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
                              content: Text("wrong email format"),
                            )
                          );
                          return;
                        }

                        /* jika format email saalah */
                        if(_con[2].text.length < 10){
                          showDialog(context: context,
                            child: AlertDialog(
                              titlePadding: EdgeInsets.all(0),
                              title: Container(child: Text('INFORMATION',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
                              content: Text("inserty true phone number"),
                            )
                          );
                          return;
                        }

                        try {
                          int.parse(_con[2].text);
                        } catch (e) {
                          showDialog(context: context,
                            child: AlertDialog(
                              titlePadding: EdgeInsets.all(0),
                              title: Container(child: Text('INFORMATION',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
                              content: Text("wrong phone number format"),
                            )
                          );
                          return;
                        }


                      print('coba login');
                      Map<String,dynamic> paket = {
                        "name": _con[0].text,
                        "phone": _con[2].text,
                        "email": _con[1].text
                      };
                      print('https://'+host+'/api/setUserTable/'+meja);


                     /*  prf.setString('auth', jsonEncode(paket).toString());
                      prf.setString('meja', "3");
                      prf.setString('menu', jsonEncode(await rootBundle.loadString('./fake/menu.json'))); */

                      
                      try {
                        var cobaLogin = await new Dio().post('https://'+host+'/api/setUserTable/'+meja,data: paket);

                        if(cobaLogin.data['status']){

                          prf.setString(Malik.AUTH.toString(), jsonEncode(cobaLogin.data['user']).toString());
                          prf.setString(Malik.HOST.toString(), host);
                          prf.setString(Malik.MEJA.toString(), meja);

                          // print(cobaLogin.data);
                          /* keopen order */
                          print('menuju ke open order');
                          Navigator.of(context).pushReplacementNamed('/open-order');

                        }else{
                          pesanDialog(context, 'message', cobaLogin.data['note']);
                        }
                      } catch (e) {
                        pesanDialog(context, "error message", "enable to connect to server");
                      }
                    }, 
                    child: Text('LOGIN')
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void pesanDialog(BuildContext context,String judul,String pesan){
    showDialog(context: context,
      child: AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(child: Text(judul,
          style: TextStyle(
            color: Colors.white
          ),
        ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
        content: Text(pesan),
      )
    );
  }

  gkAdaMeja(){
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Center(
            child: Text('please scan the table first , please!',
              style: TextStyle(
                fontSize: 42,
                color: Colors.grey
              ),
            )
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Image.asset('assets/images/qr.png')
            ),
          )
        ],
      ),
    );
  }
}
