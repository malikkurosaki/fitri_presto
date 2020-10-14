import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presto_qr/views/book_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';


class Login extends StatefulWidget{
  final meja,host;
  const Login({Key key, this.meja, this.host}) : super(key: key);
  @override
  _LoginState createState() => _LoginState(meja,host);
}

class _LoginState extends State<Login> {
  static final _judul = ['User Name','Email', 'Phone Number'];
  static final _iconInput = [Icons.person_outline_sharp,Icons.email, Icons.phone_android];
  final _lsCon = List.generate(_judul.length, (index) => TextEditingController()).toList();
  final _kunci = GlobalKey<FormState>();
  final meja,host;

  _LoginState(this.meja, this.host);

  @override
  Widget build(BuildContext context) {
    print('login');

    Future.microtask(()async{
      SharedPreferences prf = await SharedPreferences.getInstance();
      prf.clear();
      print('hapus cache');
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500
              ),
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            color: Colors.grey,
                            child: Stack(
                              children: [
                                Image.asset('assets/images/gb1.jpeg',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Text("Table #"+ meja,
                                  style: TextStyle(
                                    fontSize: 42,
                                    color: Colors.orange,
                                    shadows: [
                                      Shadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(0,4)
                                      )
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                          )
                        ],
                      ),
                      FutureBuilder(
                        future: getCompany(host),
                        builder: (context, snapshot){
                          if(snapshot.connectionState != ConnectionState.done) return Center(child: CircularProgressIndicator(),);
                          Map dat = snapshot.data;
                          return Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: dat['logo'],
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => Text("error"),
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  radius: 50,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Text(dat['name'])
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Form(
                      key: _kunci,
                      child: Column(
                        children: [
                          for(var a = 0; a < _judul.length;a++)
                          Container(
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _lsCon[a],
                              validator: (val){
                                return val.isEmpty ?"no empty allowed":null;
                              },
                              decoration: InputDecoration(
                                labelText: _judul[a],
                                isDense: true,
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: InputBorder.none,
                                prefixIcon: Icon(_iconInput[a])
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 50),
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  color: Colors.blue[300],
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(16),
                                  onPressed: ()async{
                                    if(_kunci.currentState.validate()){

                                      if(!isEmail(_lsCon[1].text)){
                                        showMessage(context, "info", "insert email");
                                        return;
                                      }

                                      if(_lsCon[2].text.toString().length < 9 || !isNumeric(_lsCon[2].text.replaceAll("0", "1"))){
                                        showMessage(context, "info", "insert your phone number ");
                                        return;
                                      }

                                     
                                      Map paket = Map();
                                      try {
                                        paket['name'] = _lsCon[0].text.toString();
                                        paket['phone'] = _lsCon[2].text.toString();
                                        paket['email'] = _lsCon[1].text.toString();
                                      } catch (e) {
                                        print(e);
                                      }
                                      
                                      print(paket);

                                      // var aman = scure?"https://":"http://";
                                      // var hostJadi = "$aman$host/prestoqr/public";

                                      print(host);

                                      try {

                                        final coba = await Dio().post("$host/api/setUserTable/$meja",data: jsonEncode(paket).toString());
                                        if(coba.data['status']){
                                          SharedPreferences prf = await SharedPreferences.getInstance();
                                          prf.setString('meja', meja);
                                          prf.setString('host', host);
                                          prf.setString('user', jsonEncode(coba.data['user']).toString());

                                          print(prf.getString('host'));
                                          //Navigator.of(context).pushReplacementNamed('/open-table');

                                        }else{
                                          showMessage(context, "info", coba.data['note']);
                                        }
                                      } catch (e) {
                                        showMessage(context, "error", "cannot connect to server \n '$host/api/setUserTable/$meja' \n "+ e.toString());
                                      }


                                    }
                                  }, 
                                  child: Text('Login')
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.centerRight,
                                child: Wrap(
                                  alignment: WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text('or just show me the'),
                                    FlatButton(
                                      textColor: Colors.green,
                                      onPressed: ()async{
                                        showDialog(context: context,
                                          child: AlertDialog(
                                            contentPadding: EdgeInsets.all(8),
                                            scrollable: true,
                                            content: Center(child: CircularProgressIndicator(),),
                                          )
                                        );
                        
                                        final res = await new Dio().get('$host/api/getMenu?product=&group=&subgroup=');
                                        // print(res.data);
                                        Navigator.of(context,rootNavigator: true).pop('dialog');
                                        showModalBottomSheet(context: context, 
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          builder: (context) => BookMenu(menu: res.data,),
                                        );
                                      }, 
                                      // onLongPress: () => Navigator.of(context).push(""),
                                      child: Text('MENU')
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<Map> getCompany(String host)async{
    print("$host/api/getCompanyProfile");
    final _res = await new Dio().get("$host/api/getCompanyProfile");
    print(_res.data['data']['logo']);
    return _res.data['data'];
  }


  void showMeJustMenu(BuildContext context, List menu)async{
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context, 
      builder: (context) => 
      Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.grey[200],
            child: Text('===')
          ),
          Flexible(
            child: ListView(
              children: [
                
              ],
            ),
          )
        ],
      ),
    );
  }

  void showMessage(BuildContext context, String title,String isi){
    showDialog(context: context,
      child: AlertDialog(
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.all(8),
          color: Colors.blue[300],
          child: Text(title),
        ),
        content: Container(
          padding: EdgeInsets.all(8),
          child: Text(isi)
        ),
      )
    );
  }
}



// class Login extends StatelessWidget{
//   static final _datanya = ['guest name','email','phone number'];
//   static final _iconnya = [Icons.people,Icons.email,Icons.phone];
//   final _con = List.generate(_datanya.length, (index) => TextEditingController());
//   final _load = Map();

//   void _memuat(BuildContext context,MalikDynamic _malik)async{
//     if(_load['udah'] == null){
//       await _malik.loadMalik();
//       _malik.update();
//       _load['udah'] = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('iam in login');
//     final _malik = Provider.of<MalikDynamic>(context);

//     _memuat(context,_malik);
    
//     print(_load['udah']);

//     return _malik == null ? Scaffold(body: Center(child: Text('loading'),),):
//     _malik.meja == null || _malik.host == null? Scaffold(body: Center(child: Text('try to detect table ... '),),):
//     WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         body: SafeArea(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: 600
//               ),
//               child: Container(
//                 child: _malik.meja == null?gkAdaMeja():adaMeja(context,_malik),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<List> getMenuNya()async{
//     return jsonDecode(await rootBundle.loadString('./fake/menu.json'));
//   }

//   adaMeja(BuildContext context,MalikDynamic _malik){
//     return Card(
//       child: ListView(
//         children: [
//           // Container(
//           //   height: 100,
//           //   alignment: Alignment.centerLeft,
//           //   color: Colors.blue[300],
//           //   child: Text("TABLE "+ meja.toString(),
//           //     style: TextStyle(
//           //       fontSize: 42,
//           //       color: Colors.white
//           //     ),
//           //   ),
//           // ),
//           /* FlatButton(
//             onPressed: ()async{
//               SharedPreferences prf = await SharedPreferences.getInstance();
//               final mn = await getMenuNya();
//               prf.setString('menu', jsonEncode(mn).toString());
//               prf.setString('meja', '4');
//               print('ok gaes');

//             }, 
//             child: Text('lihat')
//           ), */
//           Container(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 for(var i = 0; i < _datanya.length;i++)
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: TextField(
//                     textInputAction: TextInputAction.next,
//                     controller: _con[i],
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey[100],
//                       filled: true,
//                       prefixIcon: Icon(_iconnya[i]),
//                       labelText: _datanya[i],
//                       border: InputBorder.none
//                       // border: OutlineInputBorder(borderRadius: BorderRadius.circular(28))
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 50),
//                   padding: EdgeInsets.all(16),
//                   width: double.infinity,
//                   child: FlatButton(
//                     padding: EdgeInsets.all(16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
//                     color: Colors.green,
//                     textColor: Colors.white,
//                     onPressed: () async {
//                       SharedPreferences prf = await SharedPreferences.getInstance();
//                       var kosong = false;
//                         for(var a in _con){
//                           if(a.text == ""){
//                             print(a.text);
//                             kosong = true;
//                           }
//                         }

//                         /* jika ada kosong */
//                         if(kosong){
//                           showDialog(context: context,
//                             child: AlertDialog(
//                               titlePadding: EdgeInsets.all(0),
//                               title: Container(child: Text('INFORMATION',
//                                 style: TextStyle(
//                                   color: Colors.white
//                                 ),
//                               ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
//                               content: Text("empty not allowed"),
//                             )
//                           );
//                           return;
//                         }

//                         /* jika format email saalah */
//                         if(!_con[1].text.contains("@") || !_con[1].text.contains(".")){
//                           showDialog(context: context,
//                             child: AlertDialog(
//                               titlePadding: EdgeInsets.all(0),
//                               title: Container(child: Text('INFORMATION',
//                                 style: TextStyle(
//                                   color: Colors.white
//                                 ),
//                               ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
//                               content: Text("wrong email format"),
//                             )
//                           );
//                           return;
//                         }

//                         /* jika format email saalah */
//                         if(_con[2].text.length < 10){
//                           showDialog(context: context,
//                             child: AlertDialog(
//                               titlePadding: EdgeInsets.all(0),
//                               title: Container(child: Text('INFORMATION',
//                                 style: TextStyle(
//                                   color: Colors.white
//                                 ),
//                               ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
//                               content: Text("inserty true phone number"),
//                             )
//                           );
//                           return;
//                         }

//                         try {
//                           int.parse(_con[2].text);
//                         } catch (e) {
//                           showDialog(context: context,
//                             child: AlertDialog(
//                               titlePadding: EdgeInsets.all(0),
//                               title: Container(child: Text('INFORMATION',
//                                 style: TextStyle(
//                                   color: Colors.white
//                                 ),
//                               ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
//                               content: Text("wrong phone number format"),
//                             )
//                           );
//                           return;
//                         }


//                       print('coba login');

//                       Map paket = Map();
//                       try {
//                         paket['name'] = _con[0].text.toString();
//                         paket['phone'] = _con[2].text.toString();
//                         paket['email'] = _con[1].text.toString();
//                       } catch (e) {
//                         print(e);
//                       }

//                       print(paket.toString());
                      
//                       try {
//                         print('try connect  : https://'+_malik.host+'/api/setUserTable/'+_malik.meja);

//                         var cobaLogin = await new Dio().post('https://'+_malik.host+'/api/setUserTable/'+_malik.meja,data: jsonEncode(paket));

//                         if(cobaLogin.data['status']){

//                           prf.setString('user', jsonEncode(cobaLogin.data['user']).toString());

//                           // print(cobaLogin.data);
//                           /* keopen order */
//                           print('menuju ke open order');
//                           await _malik.loadMalik();
//                           Navigator.of(context).pushReplacementNamed('/open-order');

//                         }else{
//                           pesanDialog(context, 'message', cobaLogin.data['note']);
//                         }
//                       } catch (e) {
//                         pesanDialog(context, "error message", "enable to connect to server");
//                       }
//                     }, 
//                     child: Text('LOGIN')
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void pesanDialog(BuildContext context,String judul,String pesan){
//     showDialog(context: context,
//       child: AlertDialog(
//         titlePadding: EdgeInsets.all(0),
//         title: Container(child: Text(judul,
//           style: TextStyle(
//             color: Colors.white
//           ),
//         ),color: Colors.blue[200],padding: EdgeInsets.all(8),),
//         content: Text(pesan),
//       )
//     );
//   }

//   gkAdaMeja(){
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: ListView(
//         children: [
//           Center(
//             child: Text('please scan the table first , please!',
//               style: TextStyle(
//                 fontSize: 42,
//                 color: Colors.grey
//               ),
//             )
//           ),
//           Center(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               child: Image.asset('assets/images/qr.png')
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
