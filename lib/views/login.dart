import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/company_controller.dart';
import 'package:presto_qr/controller/login_controller.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/model/login_model.dart';
import 'package:presto_qr/views/book_menu.dart';
import 'package:validators/validators.dart';
import 'package:get/get_rx/src/rx_iterables/rx_map.dart';
import 'package:presto_qr/component/garis_putus.dart';


class Login extends StatelessWidget {

  
  // static final _judul = ['User Name','Email', 'Phone Number'];
  // static final _iconInput = [Icons.person_outline_sharp,Icons.email, Icons.phone_android];
  // final _lsCon = List.generate(_judul.length, (index) => TextEditingController()).toList();
  // final _kunci = GlobalKey<FormState>();

  // final str = GetStorage();
  // final cpn = Get.find<CompanyProfileController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              LoginBarAtas(),
              Flexible(
                child: ListView(
                  children: [
                    FormLogin()
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}


/* login bar atas */
class LoginBarAtas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
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
                      child: Text("Table #"+ GetStorage().read('meja',),
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
                height: 90,
              )
            ],
          ),
          GetX<CompanyProfileController>(
            initState: (state) => CompanyProfileController.to.init(),
            builder: (controller) => 
              controller.cp.value.data.isNull?Text("loading"):
              Column(
              children: [
                CachedNetworkImage(
                  imageUrl: controller.cp.value.data.logo ??"",
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => 
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[400],
                      radius: 50,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Image.asset('assets/images/noimage.png',
                          fit: BoxFit.cover,
                        )
                      )
                    )
                  ),
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
                  backgroundColor: Colors.grey[100],
                  label: Text(controller.cp.value.data.name??"",
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
    );
  }
}


class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Form(
        key: LoginController.to.kunciState,
        child: Column(
          children: [
            for(var a = 0; a < LoginController.listProperty.length;a++)
            Container(
              padding: EdgeInsets.all(8),
              child: Card(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: LoginController.to.lsController[a],
                  validator: (val){
                    return val.isEmpty ?"no empty allowed":null;
                  },
                  decoration: InputDecoration(
                    labelText: LoginController.listProperty[a]['nama'],
                    isDense: true,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: InputBorder.none,
                    prefixIcon: Icon(LoginController.listProperty[a]['icon'])
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Card(
                    child: FlatButton(
                      color: Color(0.enam()),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: ()async{
                        Get.dialog(Center(child: CircularProgressIndicator(),));
                        if(LoginController.to.kunciState.currentState.validate()){
                          
                          if(!isEmail(LoginController.to.lsController[1].text)){
                            Get.dialog(Center(child: Text("insert right email format"),));
                            return;
                          }

                          if(LoginController.to.lsController[2].text.toString().length < 9 || !isNumeric(LoginController.to.lsController[2].text.replaceAll("0", "1"))){
                            Get.dialog(Center(child: Card(child: Text("wrong phone number"),),));
                            return;
                          }

                          final loginPaket = LoginModel(
                            name: LoginController.to.lsController[0].text.toString(),
                            email: LoginController.to.lsController[1].text.toString(),
                            phone: LoginController.to.lsController[2].text.toString()
                          );

                          try {
                            final coba = await Dio().post("${GetStorage().read('host')}/api/setUserTable/${GetStorage().read('meja')}",data: loginPaket);
                            Get.back();
                            if(coba.data['status']){
                              await GetStorage().write('auth', coba.data);
                              Get.offNamed('/open-table');
                            }else{
                              Get.dialog(Center(child: Card(child: Text(coba.data['note']),),));
                            }
                          } catch (e) {
                            Get.dialog(Center(child: Card(child: Text(e.toString())),));
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
                        textColor: Color(0.enam()),
                        onPressed: ()async{
                          showDialog(context: context,
                            child: AlertDialog(
                              contentPadding: EdgeInsets.all(8),
                              scrollable: true,
                              content: Center(child: CircularProgressIndicator(),),
                            )
                          );
          
                          final res = await new Dio().get('${GetStorage().read('host')}/api/getMenu?product=&group=&subgroup=');
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
    );
  }
}