import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/model/login_model.dart';
import 'package:presto_qr/views/book_menu.dart';
import 'package:validators/validators.dart';
import 'package:get/get_rx/src/rx_iterables/rx_map.dart';
import 'package:presto_qr/component/garis_putus.dart';


class Login extends StatelessWidget {
  static final _judul = ['User Name','Email', 'Phone Number'];
  static final _iconInput = [Icons.person_outline_sharp,Icons.email, Icons.phone_android];
  final _lsCon = List.generate(_judul.length, (index) => TextEditingController()).toList();
  final _kunci = GlobalKey<FormState>();

  final str = GetStorage();
  final cpn = Get.find<CompanyProfileController>();

  var nama = "".obs;

  @override
  Widget build(BuildContext context) {
    print('login');
    Future.microtask((){
      cpn.getCompanyProfile();
    });
    // Future.microtask(()async{
    //   SharedPreferences prf = await SharedPreferences.getInstance();
    //   prf.clear();
    //   print('hapus cache');
    // });

    return Scaffold(
      body: SafeArea(
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
                      child: Stack(
                        children: [
                          Card(
                            child: Image.asset('assets/images/gb1.jpeg',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Text("Table #"+ str.read('meja',),
                              style: TextStyle(
                                fontSize: 42,
                                color: Color(0.enam()),
                                shadows: [
                                  Shadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0,4)
                                  )
                                ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                    )
                  ],
                ),
                GetX<CompanyProfileController>(
                  builder: (controller) => 
                    Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: controller.cp['logo']??"",
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => Center(child: CircleAvatar(radius: 60,backgroundColor: Colors.grey,)),
                        imageBuilder: (context, imageProvider) => 
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: imageProvider,
                            ),
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.white,
                        label: Text(controller.cp['name']??"",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0.lima()),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      )
                    ],
                  ),
                )
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
                      child: Card(
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
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Card(
                            child: FlatButton(
                              color: Color(0.enam()),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16),
                              onPressed: ()async{
                                Get.dialog(Center(child: CircularProgressIndicator(),));
                                if(_kunci.currentState.validate()){

                                  if(!isEmail(_lsCon[1].text)){
                                    showMessage(context, "info", "insert email");
                                    return;
                                  }

                                  if(_lsCon[2].text.toString().length < 9 || !isNumeric(_lsCon[2].text.replaceAll("0", "1"))){
                                    showMessage(context, "info", "wrong phone number");
                                    return;
                                  }

                                  final loginPaket = LoginModel(
                                    name: _lsCon[0].text.toString(),
                                    email: _lsCon[1].text.toString(),
                                    phone: _lsCon[2].text.toString()
                                  );

                                  try {
                                    final coba = await Dio().post("${str.read('host')}/api/setUserTable/${str.read('meja')}",data: loginPaket);
                                    Get.back();
                                    if(coba.data['status']){
                                      await str.write('auth', coba.data['user']);
                                      Get.offNamed('/open-table');
                                    }else{
                                      showMessage(context, "info", coba.data['note']);
                                    }
                                  } catch (e) {
                                    showMessage(context, "error", "cannot connect to server \n '${str.read('host')}/api/setUserTable/${str.read('meja')}' \n "+ e.toString());
                                  }

                                }
                              }, 
                              child: Text('Login')
                            ),
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
                  
                                  final res = await new Dio().get('${str.read('host')}/api/getMenu?product=&group=&subgroup=');
                                  // print(res.data);
                                  Navigator.of(context,rootNavigator: true).pop('dialog');
                                  showModalBottomSheet(context: context, 
                                    isDismissible: true,
                                    isScrollControlled: true,
                                    builder: (context) => BookMenu(),
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





// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:presto_qr/views/book_menu.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:validators/validators.dart';


// class Login extends StatefulWidget{
//   final meja,host;
//   const Login({Key key, this.meja, this.host}) : super(key: key);
//   @override
//   _LoginState createState() => _LoginState(meja,host);
// }

// class _LoginState extends State<Login> {
//   static final _judul = ['User Name','Email', 'Phone Number'];
//   static final _iconInput = [Icons.person_outline_sharp,Icons.email, Icons.phone_android];
//   final _lsCon = List.generate(_judul.length, (index) => TextEditingController()).toList();
//   final _kunci = GlobalKey<FormState>();
//   final meja,host;

//   _LoginState(this.meja, this.host);

//   @override
//   Widget build(BuildContext context) {
//     print('login');

//     Future.microtask(()async{
//       SharedPreferences prf = await SharedPreferences.getInstance();
//       prf.clear();
//       print('hapus cache');
//     });

//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 150,
//                       child: Stack(
//                         children: [
//                           Card(
//                             child: Image.asset('assets/images/gb1.jpeg',
//                               width: double.infinity,
//                               height: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(16),
//                             child: Text("Table #"+ meja,
//                               style: TextStyle(
//                                 fontSize: 42,
//                                 color: Colors.orange,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.grey,
//                                     blurRadius: 5,
//                                     offset: Offset(0,4)
//                                   )
//                                 ]
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 100,
//                     )
//                   ],
//                 ),
//                 FutureBuilder(
//                   future: getCompany(host),
//                   builder: (context, snapshot){
//                     if(snapshot.connectionState != ConnectionState.done) return Center(child: CircularProgressIndicator(),);
//                     Map dat = snapshot.data;
//                     return Column(
//                       children: [
//                         CachedNetworkImage(
//                           imageUrl: dat['logo']??"",
//                           placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
//                           errorWidget: (context, url, error) => Text("error"),
//                           imageBuilder: (context, imageProvider) => 
//                           Card(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
//                             child: Container(
//                               padding: EdgeInsets.all(4),
//                               child: CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: imageProvider,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Chip(
//                           backgroundColor: Colors.white,
//                           label: Text(dat['name'])
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 50),
//               child: Form(
//                 key: _kunci,
//                 child: Column(
//                   children: [
//                     for(var a = 0; a < _judul.length;a++)
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       child: Card(
//                         child: TextFormField(
//                           textInputAction: TextInputAction.next,
//                           controller: _lsCon[a],
//                           validator: (val){
//                             return val.isEmpty ?"no empty allowed":null;
//                           },
//                           decoration: InputDecoration(
//                             labelText: _judul[a],
//                             isDense: true,
//                             fillColor: Colors.grey[200],
//                             filled: true,
//                             border: InputBorder.none,
//                             prefixIcon: Icon(_iconInput[a])
//                           ),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 50),
//                           padding: EdgeInsets.all(8),
//                           width: double.infinity,
//                           child: Card(
//                             child: FlatButton(
//                               color: Colors.blue[300],
//                               textColor: Colors.white,
//                               padding: EdgeInsets.all(16),
//                               onPressed: ()async{
//                                 if(_kunci.currentState.validate()){

//                                   if(!isEmail(_lsCon[1].text)){
//                                     showMessage(context, "info", "insert email");
//                                     return;
//                                   }

//                                   if(_lsCon[2].text.toString().length < 9 || !isNumeric(_lsCon[2].text.replaceAll("0", "1"))){
//                                     showMessage(context, "info", "insert your phone number ");
//                                     return;
//                                   }

                                 
//                                   Map paket = Map();
//                                   try {
//                                     paket['name'] = _lsCon[0].text.toString();
//                                     paket['phone'] = _lsCon[2].text.toString();
//                                     paket['email'] = _lsCon[1].text.toString();
//                                   } catch (e) {
//                                     print(e);
//                                   }
                                  
//                                   print(paket);


//                                   print(host);

//                                   try {

//                                     final coba = await Dio().post("$host/api/setUserTable/$meja",data: jsonEncode(paket).toString());
//                                     if(coba.data['status']){
//                                       SharedPreferences prf = await SharedPreferences.getInstance();
//                                       prf.setString('meja', meja);
//                                       prf.setString('host', host);
//                                       prf.setString('user', jsonEncode(coba.data['user']).toString());

//                                       print(prf.getString('host'));
//                                       Navigator.of(context).pushReplacementNamed('/open-table');

//                                     }else{
//                                       showMessage(context, "info", coba.data['note']);
//                                     }
//                                   } catch (e) {
//                                     showMessage(context, "error", "cannot connect to server \n '$host/api/setUserTable/$meja' \n "+ e.toString());
//                                   }


//                                 }
//                               }, 
//                               child: Text('Login')
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           alignment: Alignment.centerRight,
//                           child: Wrap(
//                             alignment: WrapAlignment.end,
//                             crossAxisAlignment: WrapCrossAlignment.center,
//                             children: [
//                               Text('or just show me the'),
//                               FlatButton(
//                                 textColor: Colors.green,
//                                 onPressed: ()async{
//                                   showDialog(context: context,
//                                     child: AlertDialog(
//                                       contentPadding: EdgeInsets.all(8),
//                                       scrollable: true,
//                                       content: Center(child: CircularProgressIndicator(),),
//                                     )
//                                   );
                  
//                                   final res = await new Dio().get('$host/api/getMenu?product=&group=&subgroup=');
//                                   // print(res.data);
//                                   Navigator.of(context,rootNavigator: true).pop('dialog');
//                                   showModalBottomSheet(context: context, 
//                                     isDismissible: true,
//                                     isScrollControlled: true,
//                                     builder: (context) => BookMenu(menu: res.data,),
//                                   );
//                                 }, 
//                                 // onLongPress: () => Navigator.of(context).push(""),
//                                 child: Text('MENU')
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       )
//     );
//   }

//   Future<Map> getCompany(String host)async{
//     print("$host/api/getCompanyProfile");
//     final _res = await new Dio().get("$host/api/getCompanyProfile");
//     print(_res.data['data']['logo']);
//     return _res.data['data'];
//   }


//   void showMeJustMenu(BuildContext context, List menu)async{
//     showModalBottomSheet(
//       isDismissible: true,
//       isScrollControlled: true,
//       context: context, 
//       builder: (context) => 
//       Column(
//         children: [
//           Container(
//             alignment: Alignment.center,
//             width: double.infinity,
//             color: Colors.grey[200],
//             child: Text('===')
//           ),
//           Flexible(
//             child: ListView(
//               children: [
                
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void showMessage(BuildContext context, String title,String isi){
//     showDialog(context: context,
//       child: AlertDialog(
//         titlePadding: EdgeInsets.all(0),
//         contentPadding: EdgeInsets.all(0),
//         title: Container(
//           padding: EdgeInsets.all(8),
//           color: Colors.blue[300],
//           child: Text(title),
//         ),
//         content: Container(
//           padding: EdgeInsets.all(8),
//           child: Text(isi)
//         ),
//       )
//     );
//   }
// }

