import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:presto_qr/controller/auth.dart';
import 'package:presto_qr/controller/list_menu.dart';
import 'package:presto_qr/controller/malik_dynamic.dart';
import 'package:presto_qr/controller/setting_cotroller.dart';
import 'package:presto_qr/views/my_home.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/open_order.dart';
import 'package:presto_qr/views/setting.dart';
import 'package:presto_qr/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:regex_router/regex_router.dart';

void main() {

  
 final router = RegexRouter.create({
    "/": (context, _) => MyHome(),
    "/login": (context, _) => MyHome(),
    "/login/:meja/:host": (context, args) => Splash(meja: args['meja'], host: args['host']),
    "/open-order": (context, args) => OpenOrder(),
  });

  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          FutureProvider(create: (context) => MalikDynamic().getMenu(),),
          ChangeNotifierProvider(create: (context)=>MalikDynamic(),),
        ],
        child: MaterialApp(
          title: 'presto qr | probus system',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.generateRoute,
          initialRoute: "/",
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    )
  );
}







