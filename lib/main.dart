import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/my_home.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/views/setting.dart';
import 'package:presto_qr/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:regex_router/regex_router.dart';

void main() {

 final router = RegexRouter.create({
    "/": (context, args) => Splash(),
    "/:meja/:host/:scure": (context, args) => Splash(meja: args['meja'], host: args['host'], scure: args['scure'],),
    "/home": (context,_) => MyHome(),
    "/setting": (context,_) => MySetting(),
    "/login": (context,_) => Login(),
    "/open-table": (context,_) => OpenTable()
  });

  runApp(
    Phoenix(
      child: MaterialApp(
        title: 'presto qr | probus system',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: "/",
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
      ),
    )
  );
}







