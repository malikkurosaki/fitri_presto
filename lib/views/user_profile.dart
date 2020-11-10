import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';
import 'package:presto_qr/controller/list_menu_controller.dart';
import 'package:presto_qr/controller/user_controller.dart';

class UserProfile extends StatelessWidget {
  // final Map user;
  // final meja, host;

  //const UserProfile({Key key, this.user, this.meja, this.host}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 1,
      minChildSize: 0.7,
      builder: (context, scrollController) => 
      Card(
        color: Colors.white,
        child: ListView(
          controller: scrollController,
          children: [
            Container(
              height: 250,
              child: Stack(
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
            GetX<UserController>(
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
            )
          ],
        ),
      ),
    );
  }
}