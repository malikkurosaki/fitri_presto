
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hide_keyboard/hide_keyboard.dart';
import 'package:presto_qr/controller/api_controller.dart';
import 'package:presto_qr/main.dart';
import 'package:presto_qr/model/company_model.dart';
import 'package:presto_qr/model/login_model.dart';

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

