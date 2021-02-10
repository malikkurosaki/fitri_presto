
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hide_keyboard/hide_keyboard.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/api_controller.dart';
import 'package:presto_qr/controller/company_controller_bak.dart';
import 'package:presto_qr/controller/list_menu_controller_bak.dart';
import 'package:presto_qr/controller/login_controller_bak.dart';
import 'package:presto_qr/main.dart';
import 'package:presto_qr/model/company_model.dart';
import 'package:presto_qr/model/login_model.dart';
import 'package:presto_qr/views/book_menu_bak.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'open_table.dart';


// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: double.infinity,
//           child: ListView(
//             children: [
//               LoginBarAtas(),
//               FormLogin()
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }


// /* login bar atas */
// class LoginBarAtas extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:  Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 150,
//                 child: Stack(
//                   children: [
//                     Image.asset('assets/images/gb1.jpeg',
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       child: Text("Table #"+ ListMenuNya.to.meja.value,
//                         style: TextStyle(
//                           fontSize: 42,
//                           color: Color(0.enam()),
//                           shadows: [
//                             Shadow(
//                               color: Colors.grey,
//                               blurRadius: 5,
//                               offset: Offset(0,4)
//                             )
//                           ]
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 90,
//               )
//             ],
//           ),
//           GetX<CompanyProfileController>(
//             initState: (state) => CompanyProfileController.to.init(),
//             builder: (controller) => 
//               controller.cp.value.data == null?Text("loading"):
//               Column(
//               children: [
//                 CachedNetworkImage(
//                   imageUrl: controller.cp.value.data.logo ??"",
//                   placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
//                   errorWidget: (context, url, error) => 
//                   Center(
//                     child: CircleAvatar(
//                       backgroundColor: Colors.grey[400],
//                       radius: 50,
//                       child: Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                         child: Image.asset('assets/images/noimage.png',
//                           fit: BoxFit.cover,
//                         )
//                       )
//                     )
//                   ),
//                   imageBuilder: (context, imageProvider) => 
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
//                     child: Container(
//                       padding: EdgeInsets.all(4),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: imageProvider,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Chip(
//                   backgroundColor: Colors.grey[100],
//                   label: Text(controller.cp.value.data.name??"",
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: Color(0.lima()),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


// class FormLogin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       child: Form(
//         key: LoginController.to.kunciState,
//         child: Column(
//           children: [
//             for(var a = 0; a < LoginController.listProperty.length;a++)
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Card(
//                 child: TextFormField(
//                   textInputAction: TextInputAction.next,
//                   controller: LoginController.to.lsController[a],
//                   validator: (val){
//                     return val.isEmpty ?"no empty allowed":null;
//                   },
//                   decoration: InputDecoration(
//                     labelText: LoginController.listProperty[a]['nama'],
//                     isDense: true,
//                     fillColor: Colors.grey[200],
//                     filled: true,
//                     border: InputBorder.none,
//                     prefixIcon: Icon(LoginController.listProperty[a]['icon'])
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 10),
//                   padding: EdgeInsets.all(8),
//                   width: double.infinity,
//                   child: Card(
//                     child: Obx(() => 
//                       FlatButton(
//                         color: Color(0.enam()),
//                         textColor: Colors.white,
//                         padding: EdgeInsets.all(16),
//                         onPressed: LoginController.to.ditekan.value?null:()async => LoginController.to.cobaLogin(), 
//                         child: Text('Login')
//                       )
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   alignment: Alignment.centerRight,
//                   child: Wrap(
//                     alignment: WrapAlignment.end,
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     children: [
//                       Text('or just show me the'),
//                       FlatButton(
//                         textColor: Color(0.enam()),
//                         onPressed: ()async{

//                           showModalBottomSheet(
//                             backgroundColor: Colors.transparent,
//                             isScrollControlled: true,
//                             context: Get.context, 
//                             builder: (_) => 
//                             Container(
//                               height: Get.mediaQuery.size.height/1.1,
//                               child: BookMenu(),
//                             )
//                           );
//                         }, 
//                         child: Text('MENU')
//                       ),
                      
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      key: UniqueKey(),
      child: Scaffold(
        key: UniqueKey(),
        body: Container(
          color: Colors.cyan[900],
          child: SafeArea(
            child: FutureBuilder(
              future: LoginCtrl.init(),
              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done?
              SplashScreen(): FormLogin()
            )
          ),
        ),
      ),
    );
  }
}


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      color: Colors.cyan,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("PRESTO QR",
              style: TextStyle(
                fontSize: 32,
                color: Colors.orange[100]
              ),
            ),
            Text("probus system",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 12
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> kunciState = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.all(8),
      key: UniqueKey(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FlatButton(
          //   onPressed: () => ApiController.hapusMeja2(LoginCtrl.hostParam, LoginCtrl.mejaParam), 
          //   child: Text("hapus meje ${LoginCtrl.mejaParam}")
          // ),
          Container(
            alignment: Alignment.center,
            child: Image.network(LoginCtrl?.company?.value?.logo??"",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text("Login",
            style: TextStyle(
              fontSize: 62,
              color: Colors.orange[100]
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: kunciState,
                  child: Column(
                    children: [
                      for(var i = 0; i < LoginCtrl.lsForm.length; i++)
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          key: UniqueKey(),
                          controller: LoginCtrl.lsTextCtrl[i],
                          validator: (value) => value.isEmpty? "fill in all data completely": null,
                          decoration: InputDecoration(
                            labelText: LoginCtrl.lsForm[i]['nama'],
                            labelStyle: TextStyle(
                              color: Colors.orange[100]
                            ),
                            prefixIcon: Icon(LoginCtrl.lsForm[i]['icon'],
                              color: Colors.orange[100],
                            ),
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            filled: true,
                            fillColor: Colors.cyan[900],
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange[100]))
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Obx( () => 
                        LoginCtrl.loading.value?CircularProgressIndicator(strokeWidth: 0.5,)
                        :InkWell(
                          key: UniqueKey(),
                          onTap: () => LoginCtrl.cobaLogin(kunciState),
                          onLongPress: () => ApiController.hapusMeja2(LoginCtrl.hostParam, LoginCtrl.mejaParam),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("LOGIN",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.orange[100],
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.orange[100],
                                )
                              ],
                            )
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/// controller
/// ======================
/// http://localhost:54521/#/login?meja=1&host=http%3A%2F%2F192.168.192.110%2Fpresto-qr%2Fpublic&token=FETE3D1
class LoginCtrl extends MyCtrl{
  static final loading = false.obs;
  static final loadingLogin = false.obs;
  static final hostParam = Get.parameters['host'];
  static final mejaParam = Get.parameters['meja'];
  static final tokenParam = Get.parameters['token'];
  static final company = ModelCompany().obs;

  static final List<TextEditingController> lsTextCtrl = List.generate(lsForm.length, (index) => TextEditingController());
  static final lsForm = [
    {
      "nama": "User Name",
      "icon": Icons.person_outline_sharp
    },
    {
      "nama": "Email",
      "icon": Icons.email
    },
    {
      "nama": "Phone Number",
      "icon": Icons.phone_android
    }
  ];

  

  static init()async{
    company.value = await ApiController.getDtaCompany(hostParam);
    await GetStorage().write("company", company.value);

    await GetStorage().write("activ", true);
    await Future.delayed(Duration(seconds: 2));
  }

  static cobaLogin(GlobalKey<FormState> kunciState)async{
    loading.value = true;
    HideKeyboard.now();
    if(kunciState.currentState.validate()){

      /// cek emil
      if(!lsTextCtrl[1].text.isEmail){
        Get.snackbar("email", "wrong email",
          backgroundColor: Colors.cyan,
          colorText: Colors.white
        );
        loading.value = false;
        return;
      }

      /// cek phone
      if(!lsTextCtrl[2].text.isPhoneNumber){
        Get.snackbar("phone number", "wrong phone number",
          backgroundColor: Colors.cyan,
          colorText: Colors.white
        );
        loading.value = false;
        return;
      }

      final loginPaket = LoginModel(
        name: lsTextCtrl[0].text.toString(),
        email: lsTextCtrl[1].text.toString(),
        phone: lsTextCtrl[2].text.toString(),
        token: tokenParam
      );

      print(hostParam);

      try {
        final coba = await Dio().post("$hostParam/api/setUserTable/$mejaParam",data: loginPaket.toJson());
        //print(coba.data);
        
        if(coba.data['status']){
          await GetStorage().write('auth', coba.data);
          await GetStorage().write("meja", mejaParam);
          await GetStorage().write("host", hostParam);
          await GetStorage().write("token", tokenParam);
          loading.value = false;
          
          Get.offNamed("/open-table");
        }
        else{
          Get.snackbar("login", coba.data['note'].toString(),
            backgroundColor: Colors.white
          );
          loading.value = false;
        }
      } catch (e) {

        print(e.toString());
        Get.snackbar("login", e.toString(),
          backgroundColor: Colors.white
        );
        loading.value = false;
      }

    }

    loading.value = false;
  }

  
}

