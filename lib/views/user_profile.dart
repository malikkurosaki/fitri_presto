import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';

class UserProfile extends StatelessWidget {
  // final Map user;
  // final meja, host;

  //const UserProfile({Key key, this.user, this.meja, this.host}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.1,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              alignment: Alignment.center,
              child: Icon(Icons.arrow_drop_down),
            ),
            onTap: () => Get.back(),
          ),
          Container(
            height: 250,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Container(
                      height: 160,
                      color: Colors.cyan,
                    ),
                    Container(
                      height: 90,
                      color: Colors.white,
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[100],
                        child: Icon(Icons.people_alt_rounded),
                      ),
                      RaisedButton(
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: ()async{
                          ListMenuNya.to.keluar();
                        },
                        child: Text('LOGOUT',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: GetX<UserController>(
              initState: (state) => UserController.to.getUserNya(),
              builder: (_) => 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_.user.value.user.name).judul(),
                  GarisPutus(),
                  Text(_.user.value.user.phone).judul(),
                  GarisPutus(),
                  Text(_.user.value.user.deviceName).judul(),
                  GarisPutus(),
                  Text(_.user.value.user.email).judul()
                ],
              ),
            ),
          )
          /* for(var x = 0;x < user.entries.map((e) => e.value).toList().length;x++)
          ListTile(
            title: Text(user.entries.map((e) => e.value).toList()[x].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),
            ),
            dense: true,
            leading: Icon(Icons.donut_small),
          ) */
          // Container(
          //   padding: EdgeInsets.all(8),
          //   child: Text(user.toString()),
          // ),
          // Container(
          //   padding: EdgeInsets.all(8),
          //   child: Text(user['email']),
          // )
        ],
      ),
    );
  }
}